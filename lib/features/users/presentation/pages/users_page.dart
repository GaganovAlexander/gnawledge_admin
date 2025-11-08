import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/presentation/dialogs/user_form_dialog.dart';
import 'package:gnawledge_admin/features/users/presentation/providers.dart';
import 'package:gnawledge_admin/features/users/presentation/widgets/status_badge.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search users...',
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
                label: const Text('Add User'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
              data: (users) => _UsersTable(users: users),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsersTable extends StatelessWidget {
  const _UsersTable({required this.users});

  final List<AppUser> users;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: ListView.separated(
        itemCount: users.length + 1,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _HeaderRow();
          }
          final u = users[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 320,
                  child: Row(
                    children: [
                      CircleAvatar(child: Text(_initials(u))),
                      const SizedBox(width: 16),
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
                SizedBox(width: 360, child: Text(u.email)),
                SizedBox(width: 160, child: Text(u.role)),
                SizedBox(
                  width: 160,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: StatusBadge(status: u.status),
                  ),
                ),
                SizedBox(width: 180, child: Text(_fmt(u.joinDate))),
                PopupMenuButton<String>(
                  onSelected: (v) async {
                    if (v == 'edit') {
                      final edited = await showDialog<AppUser>(
                        context: context,
                        builder: (_) => UserFormDialog(initial: u),
                      );
                      if (edited != null) {
                        if (!context.mounted) return;
                        final container = ProviderScope.containerOf(context);
                        await container
                            .read(usersControllerProvider.notifier)
                            .edit(edited);
                      }
                    }
                    if (v == 'delete') {
                      if (!context.mounted) return;
                      final container = ProviderScope.containerOf(context);
                      await container
                          .read(usersControllerProvider.notifier)
                          .remove(u.id);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onOpened: () {},
                  onCanceled: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _initials(AppUser u) =>
      '${u.firstName.isNotEmpty ? u.firstName[0] : ''}${u.lastName.isNotEmpty ? u.lastName[0] : ''}'
          .toUpperCase();
  String _fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class _HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.w600,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          SizedBox(width: 320, child: Text('User', style: style)),
          SizedBox(width: 360, child: Text('Email', style: style)),
          SizedBox(width: 160, child: Text('Role', style: style)),
          SizedBox(width: 160, child: Text('Status', style: style)),
          SizedBox(width: 180, child: Text('Join Date', style: style)),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
