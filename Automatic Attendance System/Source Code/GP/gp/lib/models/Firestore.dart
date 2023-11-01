/* class fireStore{

addData() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("employees");
    await userRef.doc(idController.text).set({
      "name": nameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "birth_date": birthdateController.text,
      "hiring_date": hiringdateController.text,
      "salary": salaryController.text,
      "job_title": jobController.text,
      "absence": 0,
      "late": 0,
      "bonus": 0,
      "punishment": 0,
      "image url": url
    }).then((value) {
       print("ya3mmm");
      showToast(
       
          message: "emp added Successfully",
          state: ToastStates.right,
          context: context);
    }).catchError((onError) {
       print("a3aaaaaaaa");
      showToast(
          message: "something went wrong",
          state: ToastStates.error,
          context: context);
    });
  }

} */