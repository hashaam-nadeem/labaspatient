import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/model/clinic.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/department_to_clinics.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Departments extends StatelessWidget {
  Departments({
    Key key,
    this.isDepartmentRoute = true,
  }) : super(key: key);

  final bool isDepartmentRoute;
  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _dataProvider = Provider.of<DataProvider>(context);
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: width * .04,
      spacing: width * .06,
      children: List.generate(
        _dataProvider.allDepartments.length,
        (index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                width * .04,
              ),
            ),
            shadowColor: Colors.grey,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            child: InkWell(
              onTap: () {
                // User.userData.searchClinics = List<Clinic>();
                // User.userData.selectedDepartment = _dataProvider.allDepartments[index].id;
                // User.userData.departmentName=
                User.userData.departmentId=_dataProvider.allDepartments[index].id;
                User.userData.departmentName=_widgetProvider.languageIndex == 1
                    ? _dataProvider.allDepartments[index].name
                    : _dataProvider.allDepartments[index].arabicName;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DepartmentScreen2(
                      // departmentLogo: APINetwork.BASE_URL +
                      departmentLogo: APINetwork.BASE_URL +
                          _dataProvider.allDepartments[index].imageURL,
                      departmentName: _widgetProvider.languageIndex == 1
                          ? _dataProvider.allDepartments[index].name
                          : _dataProvider.allDepartments[index].arabicName,
                      departmentId: _dataProvider.allDepartments[index].id.toString(),
                    ),
                  ),
                );
              },
              splashColor: Colors.grey,
              child: Container(
                width: width * .4,
                height: height * .22,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * .3,
                          height: height * .13,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: SizedBox(
                            width: width * .3,
                            height: height * .14,
                            child: FadeInImage.assetNetwork(
                              placeholder: appLogo,
                              image: APINetwork.BASE_URL +
                                  _dataProvider.allDepartments[index].imageURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              width * .03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            _widgetProvider.languageIndex == 1
                                ? _dataProvider.allDepartments[index].name
                                : _dataProvider
                                    .allDepartments[index].arabicName,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: labelTextStyle.copyWith(
                              fontSize: width * .038,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
