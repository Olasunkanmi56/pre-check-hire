import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployerRequestDomesticWorkerScreen extends StatefulWidget {
  const EmployerRequestDomesticWorkerScreen({super.key});

  @override
  State<EmployerRequestDomesticWorkerScreen> createState() =>
      _EmployerRequestDomesticWorkerScreenState();
}

class _EmployerRequestDomesticWorkerScreenState
    extends State<EmployerRequestDomesticWorkerScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _category, _jobType, _state, _lga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Domestic Workers',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Title of Domestic Service", ),
              _buildTextField(hintText: 'title'),

              _buildLabel("Domestic Service Category"),
              _buildDropdown(_category, (val) {
                setState(() => _category = val);
              }, ["Select Category", "Nanny", "Cook", "Driver"]),

              _buildLabel("Experience"),
              _buildTextField(),

              _buildLabel("Qualifications"),
              _buildTextField(),

              _buildLabel("Job Type"),
              _buildDropdown(_jobType, (val) {
                setState(() => _jobType = val);
              }, ["Full Time", "Part Time"]),

              _buildLabel("State"),
              _buildDropdown(_state, (val) {
                setState(() => _state = val);
              }, ["Lagos", "Abuja", "Kano"]),

              _buildLabel("LGA"),
              _buildDropdown(_lga, (val) {
                setState(() => _lga = val);
              }, ["Ikeja", "Wuse", "Nasarawa"]),

              _buildLabel("Description"),
              _buildTextField(maxLines: 4),

              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45.h),
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Request domestic workers",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextField({int maxLines = 1, String? hintText}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 139, 138, 138),
          ), // stays grey even when focused
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  Widget _buildDropdown(
    String? value,
    Function(String?) onChanged,
    List<String> items,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
    );
  }
}
