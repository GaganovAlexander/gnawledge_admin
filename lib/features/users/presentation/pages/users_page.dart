import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/presentation/dialogs/user_form_dialog.dart';
import 'package:gnawledge_admin/features/users/presentation/providers.dart';
import 'package:gnawledge_admin/features/users/presentation/widgets/status_badge.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';
import 'package:gnawledge_admin/shared/widgets/confirm_dialog.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final state = ref.watch(usersControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: t.users_search_hint,
                  ),
                  onChanged: (v) =>
                      ref.read(usersControllerProvider.notifier).setQuery(v),
                ),
              ),
              const SizedBox(width: 16),
              FilledButton.icon(
                onPressed: () async {
                  final u = await showDialog<AppUser>(
                    context: context,
                    builder: (_) => const UserFormDialog(),
                  );
                  if (u != null) {
                    await ref.read(usersControllerProvider.notifier).add(u);
                  }
                },
                icon: const Icon(Icons.add),
                label: Text(t.users_add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
              data: (users) => _UsersTable(users: users, t: t),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsersTable extends StatelessWidget {
  const _UsersTable({required this.users, required this.t});

  final List<AppUser> users;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const nameCol = 300.0;
          const emailCol = 340.0;
          const roleCol = 140.0;
          const statusCol = 140.0;
          const dateCol = 160.0;
          const actionsCol = 60.0;
          const horizontalPadding = 24.0 * 2;
          const horizontalSizedBox = 16.0 * 2;
          const tableWidth = nameCol +
              emailCol +
              roleCol +
              statusCol +
              dateCol +
              actionsCol +
              horizontalPadding +
              horizontalSizedBox;
          final width = math.max(constraints.maxWidth, tableWidth);

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: width,
              child: ListView.separated(
                itemCount: users.length + 1,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _HeaderRow(t: t);
                  }
                  final u = users[index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: nameCol,
                          child: Row(
                            children: [
                              CircleAvatar(child: Text(_initials(u))),
                              const SizedBox(width: horizontalSizedBox),
                              Expanded(
                                child: Text(
                                  u.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: emailCol, child: Text(u.email)),
                        SizedBox(
                          width: roleCol,
                          child: Text(_roleLabel(t, u.role)),
                        ),
                        SizedBox(
                          width: statusCol,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: StatusBadge(status: u.status),
                          ),
                        ),
                        SizedBox(width: dateCol, child: Text(_fmt(u.joinDate))),
                        PopupMenuButton<String>(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(t.users_action_edit),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(t.users_action_delete),
                            ),
                          ],
                          onSelected: (v) async {
                            if (v == 'edit') {
                              final edited = await showDialog<AppUser>(
                                context: context,
                                builder: (_) => UserFormDialog(initial: u),
                              );
                              if (edited != null) {
                                if (!context.mounted) return;
                                final container =
                                    ProviderScope.containerOf(context);
                                await container
                                    .read(
                                      usersControllerProvider.notifier,
                                    )
                                    .edit(edited);
                              }
                            }
                            if (v == 'delete') {
                              if (!context.mounted) return;

                              final ok = await showConfirmDialog(
                                context,
                                title: t.confirm_delete_user_title,
                                text: t.confirm_delete_user_text,
                                cancelText: t.common_cancel,
                                acceptText: t.common_delete,
                                acceptBg: colors.dangerous,
                              );

                              if (!ok) return;

                              if (!context.mounted) return;
                              final container =
                                  ProviderScope.containerOf(context);
                              await container
                                  .read(
                                    usersControllerProvider.notifier,
                                  )
                                  .remove(u.id);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String _initials(AppUser u) =>
      // ignore: lines_longer_than_80_chars
      '${u.firstName.isNotEmpty ? u.firstName[0] : ''}${u.lastName.isNotEmpty ? u.lastName[0] : ''}'
          .toUpperCase();
  String _fmt(DateTime d) =>
      // ignore: lines_longer_than_80_chars
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  String _roleLabel(AppLocalizations t, String role) {
    switch (role) {
      case 'Admin':
        return t.role_admin;
      case 'Manager':
        return t.role_manager;
      default:
        return t.role_user;
    }
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.t});

  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: colors.textMedium,
          fontWeight: FontWeight.w600,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          SizedBox(width: 320, child: Text(t.users_col_user, style: style)),
          SizedBox(width: 360, child: Text(t.users_col_email, style: style)),
          SizedBox(width: 160, child: Text(t.users_col_role, style: style)),
          SizedBox(width: 160, child: Text(t.users_col_status, style: style)),
          SizedBox(width: 180, child: Text(t.users_col_joinDate, style: style)),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
