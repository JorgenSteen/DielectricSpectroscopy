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
		<Item Name="Apps" Type="Folder">
			<Item Name="RDV-GUI-Compare_Permittivity_calc.vi" Type="VI" URL="../Data Viewer/RDV-GUI-Compare_Permittivity_calc.vi"/>
			<Item Name="RDV-GUI-SinglePlot.vi" Type="VI" URL="../Data Viewer/RDV-GUI-SinglePlot.vi"/>
		</Item>
		<Item Name="Tests" Type="Folder">
			<Item Name="RDC-compare_deembed.vi" Type="VI" URL="../Computation/RDC-compare_deembed.vi"/>
			<Item Name="RDC-test-Check_Error.vi" Type="VI" URL="../Computation/RDC-test-Check_Error.vi"/>
			<Item Name="RDC-test-check_perm.vi" Type="VI" URL="../Computation/RDC-test-check_perm.vi"/>
			<Item Name="RDC-test-get_perm.vi" Type="VI" URL="../Computation/RDC-test-get_perm.vi"/>
			<Item Name="RDC-tester.vi" Type="VI" URL="../Computation/RDC-tester.vi"/>
			<Item Name="RFH-test-excel_converter.vi" Type="VI" URL="../Reflector/RFH-test-excel_converter.vi"/>
			<Item Name="RFH-test-write_readback.vi" Type="VI" URL="../Reflector/RFH-test-write_readback.vi"/>
			<Item Name="RFH-test.vi" Type="VI" URL="../Reflector/RFH-test.vi"/>
		</Item>
		<Item Name="RDC-Reflection_Data_Computation.lvlib" Type="Library" URL="../Computation/RDC-Reflection_Data_Computation.lvlib"/>
		<Item Name="RDV-Reflection_Data_viewer.lvclass" Type="LVClass" URL="../Data Viewer/RDV-Reflection_Data_viewer.lvclass"/>
		<Item Name="RFH-Reflection_File_Handler.lvlib" Type="Library" URL="../Reflector/RFH-Reflection_File_Handler.lvlib"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Adjust for Labels.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Adjust for Labels.vi"/>
				<Item Name="Adjust Smith Scales.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Adjust Smith Scales.vi"/>
				<Item Name="Almost Equal.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Almost Equal.vi"/>
				<Item Name="Almost In Range.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Almost In Range.vi"/>
				<Item Name="Angle In Range.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Angle In Range.VI"/>
				<Item Name="Autoscale Smith as Needed.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Autoscale Smith as Needed.vi"/>
				<Item Name="Bit-array To Byte-array.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/Bit-array To Byte-array.vi"/>
				<Item Name="Built App File Layout.vi" Type="VI" URL="/&lt;vilib&gt;/AppBuilder/Built App File Layout.vi"/>
				<Item Name="Calc Long Word Padded Width.vi" Type="VI" URL="/&lt;vilib&gt;/picture/bmp.llb/Calc Long Word Padded Width.vi"/>
				<Item Name="Check Color Table Size.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Color Table Size.vi"/>
				<Item Name="Check Data Size.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Data Size.vi"/>
				<Item Name="Check File Permissions.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check File Permissions.vi"/>
				<Item Name="Check for Equality.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/Check for Equality.vi"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="Check Path.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Path.vi"/>
				<Item Name="Circle from 3 Points.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Circle from 3 Points.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Close Registry Key.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Close Registry Key.vi"/>
				<Item Name="Create ActiveX Event Queue.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/ax-events.llb/Create ActiveX Event Queue.vi"/>
				<Item Name="Create Directory Recursive.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Create Directory Recursive.vi"/>
				<Item Name="Create Error Clust.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/ax-events.llb/Create Error Clust.vi"/>
				<Item Name="Create Mask By Alpha.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Create Mask By Alpha.vi"/>
				<Item Name="Delimited String to 1D String Array.vi" Type="VI" URL="/&lt;vilib&gt;/AdvancedString/Delimited String to 1D String Array.vi"/>
				<Item Name="Destroy ActiveX Event Queue.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/ax-events.llb/Destroy ActiveX Event Queue.vi"/>
				<Item Name="Directory of Top Level VI.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Directory of Top Level VI.vi"/>
				<Item Name="Draw Arc as Line.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Arc as Line.VI"/>
				<Item Name="Draw Arc as PolyLine.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Arc as PolyLine.vi"/>
				<Item Name="Draw Arc.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Arc.vi"/>
				<Item Name="Draw Circle Segments.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Circle Segments.vi"/>
				<Item Name="Draw Clipped Arc.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Clipped Arc.vi"/>
				<Item Name="Draw Clipped Line.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Clipped Line.vi"/>
				<Item Name="Draw Clipped R-Curve.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Clipped R-Curve.vi"/>
				<Item Name="Draw Clipped Smith Line.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Clipped Smith Line.vi"/>
				<Item Name="Draw Clipped X-Curve.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Clipped X-Curve.vi"/>
				<Item Name="Draw Coordinate Text.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Coordinate Text.vi"/>
				<Item Name="Draw DBL Arc.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw DBL Arc.VI"/>
				<Item Name="Draw Exact Arc for PC.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Exact Arc for PC.VI"/>
				<Item Name="Draw Exact Arc.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Exact Arc.VI"/>
				<Item Name="Draw Grids for Smith Chart.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Grids for Smith Chart.vi"/>
				<Item Name="Draw Multiple Lines.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Multiple Lines.vi"/>
				<Item Name="Draw Oval.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Oval.vi"/>
				<Item Name="Draw Point.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Point.vi"/>
				<Item Name="Draw Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Rect.vi"/>
				<Item Name="Draw Smith Coordinates.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Smith Coordinates.vi"/>
				<Item Name="Draw Smith Grid.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Smith Grid.vi"/>
				<Item Name="Draw Smith Plot.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Smith Plot.vi"/>
				<Item Name="Draw Smith Point.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Smith Point.vi"/>
				<Item Name="Draw Smith PolyLine.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Smith PolyLine.vi"/>
				<Item Name="Draw Standard Smith Grid.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Draw Standard Smith Grid.vi"/>
				<Item Name="Draw Text in Rect(6_1).vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Text in Rect(6_1).vi"/>
				<Item Name="DU64_U32SubtractWithBorrow.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/TSOps.llb/DU64_U32SubtractWithBorrow.vi"/>
				<Item Name="Dynamic To Waveform Array.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/transition.llb/Dynamic To Waveform Array.vi"/>
				<Item Name="Enum to Array of Enums.vim" Type="VI" URL="/&lt;vilib&gt;/numeric/Enum to Array of Enums.vim"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Escape Characters for HTTP.vi" Type="VI" URL="/&lt;vilib&gt;/printing/PathToURL.llb/Escape Characters for HTTP.vi"/>
				<Item Name="EventData.ctl" Type="VI" URL="/&lt;vilib&gt;/Platform/ax-events.llb/EventData.ctl"/>
				<Item Name="ex_CorrectErrorChain.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/ex_CorrectErrorChain.vi"/>
				<Item Name="ex_GetAllExpressAttribs.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/transition.llb/ex_GetAllExpressAttribs.vi"/>
				<Item Name="ex_Modify Signal Name.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/ex_Modify Signal Name.vi"/>
				<Item Name="ex_Modify Signals Names.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/ex_Modify Signals Names.vi"/>
				<Item Name="ex_SmoothingDesign.vi" Type="VI" URL="/&lt;vilib&gt;/express/express analysis/FilterBlock.llb/ex_SmoothingDesign.vi"/>
				<Item Name="ex_WaveformAttribs.ctl" Type="VI" URL="/&lt;vilib&gt;/express/express shared/transition.llb/ex_WaveformAttribs.ctl"/>
				<Item Name="Express Waveform Components.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/transition.llb/Express Waveform Components.vi"/>
				<Item Name="Find R-Grid through {h,v}.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Find R-Grid through {h,v}.vi"/>
				<Item Name="Find X-Grid through {h,v}.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Find X-Grid through {h,v}.vi"/>
				<Item Name="Flip and Pad for Picture Control.vi" Type="VI" URL="/&lt;vilib&gt;/picture/bmp.llb/Flip and Pad for Picture Control.vi"/>
				<Item Name="From PC Angle.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/From PC Angle.vi"/>
				<Item Name="Generate R-Curves.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Generate R-Curves.vi"/>
				<Item Name="Generate Temporary File Path.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Generate Temporary File Path.vi"/>
				<Item Name="Generate X-Curves.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Generate X-Curves.VI"/>
				<Item Name="Get Clipped Circle Segment.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Get Clipped Circle Segment.vi"/>
				<Item Name="Get File Extension.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Get File Extension.vi"/>
				<Item Name="Get LV Class Default Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/LVClass/Get LV Class Default Value.vi"/>
				<Item Name="Get Range Of Smith Plots.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Get Range Of Smith Plots.vi"/>
				<Item Name="Get Scale Range of Smith Ln.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Get Scale Range of Smith Ln.vi"/>
				<Item Name="Get Smith Display Attributes.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Get Smith Display Attributes.vi"/>
				<Item Name="Get Smith Grids.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Get Smith Grids.vi"/>
				<Item Name="Get Smith Line Angles.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Get Smith Line Angles.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="Handle Open Word or Excel File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/NIReport.llb/Toolkit/Handle Open Word or Excel File.vi"/>
				<Item Name="I128 Timestamp.ctl" Type="VI" URL="/&lt;vilib&gt;/Waveform/TSOps.llb/I128 Timestamp.ctl"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="Is Path and Not Empty.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Is Path and Not Empty.vi"/>
				<Item Name="Largest R-Curve in Range.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Largest R-Curve in Range.vi"/>
				<Item Name="Largest X-Curve in Range.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Largest X-Curve in Range.vi"/>
				<Item Name="Less Comparable.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Comparison/Less/Less Comparable/Less Comparable.lvclass"/>
				<Item Name="Less Functor.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Comparison/Less/Less Functor/Less Functor.lvclass"/>
				<Item Name="Less.vim" Type="VI" URL="/&lt;vilib&gt;/Comparison/Less.vim"/>
				<Item Name="List Directory and LLBs.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/List Directory and LLBs.vi"/>
				<Item Name="Map (r,x).VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Map (r,x).VI"/>
				<Item Name="Map Coordinates.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Map Coordinates.vi"/>
				<Item Name="Map Setup.vi" Type="VI" URL="/&lt;vilib&gt;/picture/scale.llb/Map Setup.vi"/>
				<Item Name="Map Value to Pixel.vi" Type="VI" URL="/&lt;vilib&gt;/picture/scale.llb/Map Value to Pixel.vi"/>
				<Item Name="Max &amp; Min X-Curves in Range.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Max &amp; Min X-Curves in Range.vi"/>
				<Item Name="NI_AALBase.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALBase.lvlib"/>
				<Item Name="NI_AALPro.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALPro.lvlib"/>
				<Item Name="NI_Excel.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Utility/NIReport.llb/Excel/NI_Excel.lvclass"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="NI_Gmath.lvlib" Type="Library" URL="/&lt;vilib&gt;/gmath/NI_Gmath.lvlib"/>
				<Item Name="NI_HTML.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Utility/NIReport.llb/HTML/NI_HTML.lvclass"/>
				<Item Name="NI_MABase.lvlib" Type="Library" URL="/&lt;vilib&gt;/measure/NI_MABase.lvlib"/>
				<Item Name="NI_MAPro.lvlib" Type="Library" URL="/&lt;vilib&gt;/measure/NI_MAPro.lvlib"/>
				<Item Name="NI_Matrix.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/Matrix/NI_Matrix.lvlib"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="NI_report.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Utility/NIReport.llb/NI_report.lvclass"/>
				<Item Name="NI_ReportGenerationCore.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/NIReport.llb/NI_ReportGenerationCore.lvlib"/>
				<Item Name="NI_ReportGenerationToolkit.lvlib" Type="Library" URL="/&lt;vilib&gt;/addons/_office/NI_ReportGenerationToolkit.lvlib"/>
				<Item Name="NI_Standard Report.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Utility/NIReport.llb/Standard Report/NI_Standard Report.lvclass"/>
				<Item Name="Normalize Smith Plot.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Normalize Smith Plot.vi"/>
				<Item Name="OccFireType.ctl" Type="VI" URL="/&lt;vilib&gt;/Platform/ax-events.llb/OccFireType.ctl"/>
				<Item Name="Open Registry Key.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Open Registry Key.vi"/>
				<Item Name="Path to URL inner.vi" Type="VI" URL="/&lt;vilib&gt;/printing/PathToURL.llb/Path to URL inner.vi"/>
				<Item Name="Path to URL.vi" Type="VI" URL="/&lt;vilib&gt;/printing/PathToURL.llb/Path to URL.vi"/>
				<Item Name="PCT Pad String.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/PCT Pad String.vi"/>
				<Item Name="R Angle.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/R Angle.vi"/>
				<Item Name="Read JPEG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Read JPEG File.vi"/>
				<Item Name="Read PNG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/png.llb/Read PNG File.vi"/>
				<Item Name="Read Registry Value DWORD.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Read Registry Value DWORD.vi"/>
				<Item Name="Read Registry Value Simple STR.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Read Registry Value Simple STR.vi"/>
				<Item Name="Read Registry Value Simple U32.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Read Registry Value Simple U32.vi"/>
				<Item Name="Read Registry Value Simple.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Read Registry Value Simple.vi"/>
				<Item Name="Read Registry Value STR.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Read Registry Value STR.vi"/>
				<Item Name="Read Registry Value.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Read Registry Value.vi"/>
				<Item Name="Recursive File List.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Recursive File List.vi"/>
				<Item Name="Registry Handle Master.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Registry Handle Master.vi"/>
				<Item Name="Registry refnum.ctl" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Registry refnum.ctl"/>
				<Item Name="Registry RtKey.ctl" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Registry RtKey.ctl"/>
				<Item Name="Registry SAM.ctl" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Registry SAM.ctl"/>
				<Item Name="Registry Simplify Data Type.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Registry Simplify Data Type.vi"/>
				<Item Name="Registry View.ctl" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Registry View.ctl"/>
				<Item Name="Registry WinErr-LVErr.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/Registry WinErr-LVErr.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Sect Arc Segments.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Sect Arc Segments.vi"/>
				<Item Name="Sect R-Curve with Horiz Line.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Sect R-Curve with Horiz Line.vi"/>
				<Item Name="Sect R-Curve with Vert Line.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Sect R-Curve with Vert Line.vi"/>
				<Item Name="Set Pen State.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Set Pen State.vi"/>
				<Item Name="Show in File System.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Show in File System.vi"/>
				<Item Name="Smallest R-Curve in Range.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Smallest R-Curve in Range.vi"/>
				<Item Name="Smallest X-Curve in Range.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Smallest X-Curve in Range.vi"/>
				<Item Name="Smith Multi Plot.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Smith Multi Plot.vi"/>
				<Item Name="Smith Plot Style.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Smith Plot Style.ctl"/>
				<Item Name="Smith Plot.vi" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/Smith Plot.vi"/>
				<Item Name="Sort 1D Array Core.vim" Type="VI" URL="/&lt;vilib&gt;/Array/Helpers/Sort 1D Array Core.vim"/>
				<Item Name="Sort 1D Array.vim" Type="VI" URL="/&lt;vilib&gt;/Array/Sort 1D Array.vim"/>
				<Item Name="Space Constant.vi" Type="VI" URL="/&lt;vilib&gt;/dlg_ctls.llb/Space Constant.vi"/>
				<Item Name="STR_ASCII-Unicode.vi" Type="VI" URL="/&lt;vilib&gt;/registry/registry.llb/STR_ASCII-Unicode.vi"/>
				<Item Name="subFilter.vi" Type="VI" URL="/&lt;vilib&gt;/express/express analysis/FilterBlock.llb/subFilter.vi"/>
				<Item Name="System Exec.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/System Exec.vi"/>
				<Item Name="Timestamp Subtract.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/TSOps.llb/Timestamp Subtract.vi"/>
				<Item Name="To PC Angle.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/To PC Angle.VI"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="Wait On ActiveX Event.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/ax-events.llb/Wait On ActiveX Event.vi"/>
				<Item Name="Wait types.ctl" Type="VI" URL="/&lt;vilib&gt;/Platform/ax-events.llb/Wait types.ctl"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="Write BMP Data To Buffer.vi" Type="VI" URL="/&lt;vilib&gt;/picture/bmp.llb/Write BMP Data To Buffer.vi"/>
				<Item Name="Write BMP Data.vi" Type="VI" URL="/&lt;vilib&gt;/picture/bmp.llb/Write BMP Data.vi"/>
				<Item Name="Write BMP File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/bmp.llb/Write BMP File.vi"/>
				<Item Name="Write Delimited Spreadsheet (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet (DBL).vi"/>
				<Item Name="Write Delimited Spreadsheet (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet (I64).vi"/>
				<Item Name="Write Delimited Spreadsheet (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet (string).vi"/>
				<Item Name="Write Delimited Spreadsheet.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet.vi"/>
				<Item Name="Write JPEG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Write JPEG File.vi"/>
				<Item Name="Write PNG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/png.llb/Write PNG File.vi"/>
				<Item Name="Write Spreadsheet String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Spreadsheet String.vi"/>
				<Item Name="X Angle.VI" Type="VI" URL="/&lt;vilib&gt;/picture/smith.llb/X Angle.VI"/>
			</Item>
			<Item Name="Advapi32.dll" Type="Document" URL="Advapi32.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="kernel32.dll" Type="Document" URL="kernel32.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
