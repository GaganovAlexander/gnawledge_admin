import 'package:flutter/material.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';

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
    return AlertDialog(
      title: Text(widget.initial == null ? 'Add User' : 'Edit User'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  controller: _first,
                  decoration: const InputDecoration(labelText: 'First name'),
                  validator: _r),
              TextFormField(
                  controller: _last,
                  decoration: const InputDecoration(labelText: 'Last name'),
                  validator: _r),
              TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: _r),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                initialValue: _role,
                items: const ['Admin', 'Manager', 'User']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _role = v!),
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              DropdownButtonFormField(
                initialValue: _status,
                items: const ['active', 'inactive']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _status = v!),
                decoration: const InputDecoration(labelText: 'Status'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
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
          child: const Text('Save'),
        ),
      ],
    );
  }

  String? _r(String? v) => v == null || v.trim().isEmpty ? '' : null;
}
