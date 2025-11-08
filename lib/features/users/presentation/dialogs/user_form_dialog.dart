import 'package:flutter/material.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';

class UserFormDialog extends StatefulWidget {
  const UserFormDialog({super.key, this.initial});

  final AppUser? initial;

  @override
  State<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  final _form = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _email = TextEditingController();
  String _role = 'User';
  String _status = 'active';

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    if (i != null) {
      _first.text = i.firstName;
      _last.text = i.lastName;
      _email.text = i.email;
      _role = i.role;
      _status = i.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(
        widget.initial == null ? t.user_form_add_title : t.user_form_edit_title,
      ),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _first,
                decoration: InputDecoration(labelText: t.user_form_firstName),
                validator: _r,
              ),
              TextFormField(
                controller: _last,
                decoration: InputDecoration(labelText: t.user_form_lastName),
                validator: _r,
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: t.user_form_email),
                validator: _r,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                initialValue: _role,
                items: [t.role_admin, t.role_manager, t.role_user]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e == t.role_admin
                            ? 'Admin'
                            : e == t.role_manager
                                ? 'Manager'
                                : 'User',
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _role = v!),
                decoration: InputDecoration(labelText: t.user_form_role),
              ),
              DropdownButtonFormField(
                initialValue: _status,
                items: [t.status_active, t.status_inactive]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e == t.status_active ? 'active' : 'inactive',
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _status = v!),
                decoration: InputDecoration(labelText: t.user_form_status),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.user_form_cancel),
        ),
        FilledButton(
          onPressed: () {
            if (!_form.currentState!.validate()) return;
            final now = DateTime.now();
            final u = AppUser(
              id: widget.initial?.id ?? 0,
              firstName: _first.text.trim(),
              lastName: _last.text.trim(),
              email: _email.text.trim(),
              role: _role,
              status: _status,
              joinDate: widget.initial?.joinDate ??
                  DateTime(now.year, now.month, now.day),
            );
            Navigator.pop(context, u);
          },
          child: Text(t.user_form_save),
        ),
      ],
    );
  }

  String? _r(String? v) => v == null || v.trim().isEmpty ? '' : null;
}
