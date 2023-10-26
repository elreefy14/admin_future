import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../registeration/data/userModel.dart';
import 'onboarding_screen.dart';
class ShowCoachesInDialog extends StatelessWidget {
  final List<UserModel> selectedUsers;
  final Function(List<UserModel>) onSelectedUsersChanged;
  final bool isCoach;

  const ShowCoachesInDialog({
    Key? key,
    required this.selectedUsers,
    required this.onSelectedUsersChanged,
    required this.isCoach,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AddGroupCubit, AddGroupState>(
      builder: (context, state) {
        final logger = Logger();

        final addGroupCubit = context.read<AddGroupCubit>();
        final query = addGroupCubit.usersQuery;

        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:TextField(
                                          controller: addGroupCubit.searchController,
                                          textInputAction: TextInputAction.search,
                                          onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                                          decoration: InputDecoration(
                                            hintText: 'Search by name or phone number',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.search),
                                              onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                                            ),
                                          ),
                                        ),
              ),
              Expanded(
                child: FirestoreListView(
                  shrinkWrap: true,
                  cacheExtent: 500,
                  pageSize: 2,
                  query: query ??FirebaseFirestore.instance.collection('users') ,
                  itemBuilder: (context, document) {
                    final data = document.data() as Map<String, dynamic>;
                    final user = UserModel.fromJson(data);
                    return ListTile(
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.phone ?? ''),



                      trailing: Checkbox(
                        value: isCoach
                            ? state.selectedCoaches.map((user) => user.uId).contains(user.uId)
                            : state.selectedUsers.map((user) => user.uId).contains(user.uId),
                        onChanged: (value) {
                          logger.d('value is $value');
                          if (value!) {
                            if (isCoach) {
                              addGroupCubit.selectCoach(user);
                            } else {
                              addGroupCubit.selectUser(user);
                            }
                          } else if (!value) {
                            if (isCoach) {
                              logger.d('user id is ${user.uId}');
                              context
                                  .read<AddGroupCubit>()
                                  .deselectCoach(user);
                            } else {
                              context
                                  .read<AddGroupCubit>()
                                  .deselectUser(user);
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                  //    onSelectedUsersChanged(addGroupCubit.selectedUsers);

                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../registeration/data/userModel.dart';
//
// class ShowCoachesInDialog extends StatefulWidget {
//   final List<UserModel> selectedUsers;
//   final Function(List<UserModel>) onSelectedUsersChanged;
//   final isCoach ;
//
//   const ShowCoachesInDialog({
//     Key? key,
//     required this.selectedUsers,
//     required this.onSelectedUsersChanged, required this.isCoach,
//   }) : super(key: key);
//
//   @override
//   _ShowCoachesInDialogState createState() => _ShowCoachesInDialogState();
// }
//
// class _ShowCoachesInDialogState extends State<ShowCoachesInDialog> {
//   late List<UserModel> _selectedUsers;
//   late List<String> _selectedUsersUids;
//   late TextEditingController _searchController;
//   late Query<Map<String, dynamic>> _query;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedUsers = widget.selectedUsers;
//     _selectedUsersUids = _selectedUsers.map((user) => user.uId!).toList();
//     _searchController = TextEditingController();
//     if(widget.isCoach) {
//       _query = FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'coach');
//     } else {
//       _query = FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'user');
//     }
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _onSearchSubmitted(String value) async {
//    late Query newQuery;
//     if(widget.isCoach)
//        newQuery = FirebaseFirestore.instance
//           .collection('users')
// .orderBy('name')
// .startAt([value])
// .endAt([value + '\uf8ff'])
//           .where('role', isEqualTo: 'coach')
//           .limit(100);
//     else
//      newQuery = FirebaseFirestore.instance
//        .collection('users')
// .orderBy('name')
// .startAt([value])
// .endAt([value + '\uf8ff'])
//          .where('role', isEqualTo: 'user')
//         .limit(100);
//
//     QuerySnapshot querySnapshot =
//         await newQuery.get(GetOptions(source: Source.serverAndCache));
//     var numberOfQuery = querySnapshot.docs.length;
//     print('number of query is $numberOfQuery');
//     print(numberOfQuery);
//
//     if (numberOfQuery == 0) {
//       if(widget.isCoach)
//         newQuery = FirebaseFirestore.instance
//             .collection('users')
//             .where('phone', isGreaterThanOrEqualTo: value)
//             .where('phone', isLessThan: value + 'z')
//             //order by name
//             .orderBy('phone', descending: false)
//             .where('role', isEqualTo: 'coach')
//             .limit(100);
//       else
//         newQuery = FirebaseFirestore.instance
//             .collection('users')
//             .where('phone', isGreaterThanOrEqualTo: value)
//             .where('phone', isLessThan: value + 'z')
//             //order by name
//             .orderBy('phone', descending: false)
//             .where('role', isEqualTo: 'user')
//             .limit(100);
//     }
//
//     setState(() {
//       _query = newQuery as Query<Map<String, dynamic>>;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               //i want when i click on search icon the keyboard will be closed
//               textInputAction: TextInputAction.search,
//               onSubmitted: (value) => _onSearchSubmitted(value.trim()),
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search by name or phone number',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () =>
//                       _onSearchSubmitted(_searchController.text.trim()),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: FirestoreListView(
//               shrinkWrap: true,
//               cacheExtent: 300,
//               pageSize: 5,
//               query: _query,
//               itemBuilder: (context, document) {
//                 final data = document.data() as Map<String, dynamic>;
//                 final user = UserModel.fromJson(data);
//                 return ListTile(
//                   title: Text(user.name ?? ''),
//                   subtitle: Text(user.phone ?? ''),
//                   trailing: Checkbox(
//                     value: _selectedUsersUids.contains(user.uId),
//                     onChanged: (value) {
//                       setState(() {
//                         if (value!) {
//                           _selectedUsersUids.add(user.uId!);
//                           _selectedUsers.add(user);
//                         } else {
//                           _selectedUsersUids.remove(user.uId!);
//                           _selectedUsers.remove(user);
//                         }
//                         widget.onSelectedUsersChanged(_selectedUsers);
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   widget.onSelectedUsersChanged(_selectedUsers);
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Save'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
