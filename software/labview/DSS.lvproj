<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="20008000">
	<Property Name="NI.LV.All.SaveVersion" Type="Str">20.0</Property>
	<Property Name="NI.LV.All.SourceOnly" Type="Bool">true</Property>
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="RDC-Reflection_Data_Computation.lvlib" Type="Library" URL="../Computation/RDC-Reflection_Data_Computation.lvlib"/>
		<Item Name="RDV-Reflection_Data_viewer.lvclass" Type="LVClass" URL="../Data Viewer/RDV-Reflection_Data_viewer.lvclass"/>
		<Item Name="RFH-Reflection_File_Handler.lvlib" Type="Library" URL="../Reflector/RFH-Reflection_File_Handler.lvlib"/>
		<Item Name="Tests" Type="Folder">
			<Item Name="RDC-compare_dembedd.vi" Type="VI" URL="../Computation/RDC-compare_dembedd.vi"/>
			<Item Name="RDC-test-Check_Error.vi" Type="VI" URL="../Computation/RDC-test-Check_Error.vi"/>
			<Item Name="RFC-test-check_perm.vi" Type="VI" URL="../Computation/RFC-test-check_perm.vi"/>
			<Item Name="RFC-test-get_perm.vi" Type="VI" URL="../Computation/RFC-test-get_perm.vi"/>
			<Item Name="RFC-tester.vi" Type="VI" URL="../Computation/RFC-tester.vi"/>
			<Item Name="RFH-test-excel_converter.vi" Type="VI" URL="../Reflector/RFH-test-excel_converter.vi"/>
			<Item Name="RFH-test-write_readback.vi" Type="VI" URL="../Reflector/RFH-test-write_readback.vi"/>
			<Item Name="RFH-test.vi" Type="VI" URL="../Reflector/RFH-test.vi"/>
		</Item>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
