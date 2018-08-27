<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<title>DAIMLER</title>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="author" content="codedthemes" />
<!-- Favicon icon -->
<link rel="icon" href="resources/assets/images/favicon.ico"
	type="image/x-icon">
<!-- Google font
	<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600" rel="stylesheet">-->
<!-- Required Fremwork -->
<link rel="stylesheet" type="text/css"
	href="resources/bower_components/bootstrap/css/bootstrap.min.css">
<!-- themify icon -->
<link rel="stylesheet" type="text/css"
	href="resources/assets/icon/themify-icons/themify-icons.css">
<!-- Font Awesome -->
<link rel="stylesheet" type="text/css"
	href="resources/assets/icon/font-awesome/css/font-awesome.min.css">
<!-- ico font -->
<link rel="stylesheet" type="text/css"
	href="resources/assets/icon/icofont/css/icofont.css">
<!-- Data Table Css -->
<link rel="stylesheet" type="text/css"
	href="resources/bower_components/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/assets/pages/data-table/css/buttons.dataTables.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/bower_components/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/assets/pages/data-table/extensions/responsive/css/responsive.dataTables.css">

<!-- Date-time picker css -->
<link rel="stylesheet" type="text/css"
	href="../files/assets/pages/advance-elements/css/bootstrap-datetimepicker.css">
<!-- scrollbar.css -->
<link rel="stylesheet" type="text/css"
	href="resources/assets/css/jquery.mCustomScrollbar.css">
<!-- radial chart.css -->
<link rel="stylesheet"
	href="resources/assets/pages/chart/radial/css/radial.css"
	type="text/css" media="all">
<!-- Style.css -->
<link rel="stylesheet" type="text/css"
	href="resources/assets/css/style.css">
	<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script type="application/javascript">
	
	$(document).ready(function(){
		hideFunction();	
		$("#cmbPassType").on('change',function(){
		   if($(this).val()=="MULTI"){
			   $("#txtNTimePassValitity").show();
			   $("#lblNTimePass").show();		
		   }else{
			   hideFunction();
		   }
									  
		});
		
        
		function hideFunction(){
		     $("#txtNTimePassValitity").hide();
			 $("#lblNTimePass").hide();
		}
		
		$("#linkAdd").on('click',function(){
			 $("#disDivAddEditForm").show();			
		});
		
		$("#linkClose").on('click',function(){
			 $("#disDivAddEditForm").hide();
		});
		<c:forEach var="vehicle" items="${vehicles}">
		$("#${vehicle.vehicle_No}").on('click',function(){
			$("#disDivAddEditForm").show();
						
			$("#txtVehicleno").val("${vehicle.vehicle_No}");
			$("#cmbSupplierIBL1").val("${vehicle.supplier}");
			$("#cmbSupplierName").val("${vehicle.supplier_Name}");
			$("#cmbVehiceleType").val("${vehicle.vehicle_Type}");
			$("#txtRcBookValidDate").val("${vehicle.RCBOOK_Valid_Date}");
			$("#txtInsuranceValidDate").val("${vehicle.insurance_Valid_Date}");
			$("#txtFCValidDate").val("${vehicle.FC_Valid_Date}");
			$("#txtLicenceValidDate").val("${vehicle.vehicle_No}");
			$("#txtPollutionCertificateValidDate").val("${vehicle.pollution_Certificate_Valid_Date}");
			$("#cmbPassType").val("${vehicle.pass_Type}");
			
			
		});
		</c:forEach>
		
		
	});
	
	</script>
	<script>
	function OnPrint(vehicle_No){
		
		
		$.ajax({
			url : "/SpringMvcUser/getVehicle",
			type : 'GET',
			dataType : 'text',
			data: { 
			    vehicle_No:vehicle_No
			},
			contentType : 'application/json',
			mimeType : 'application/json',
			success : function(data) {
				
				var obj = JSON.parse(data);
				
				$("#lblGateNo").text(": NA");
				$("#lblName").html(": <b>"+obj.supplier+"</b>");
				$("#lblVehicleNo").html(": <b>"+obj.vehicle_No+"</b>");
				$("#lblReportingTime").html(": <b>"+obj.ReportingTime+"</b>");
				$("#lblVehicleType").html(": <b>"+obj.vehicle_type+"</b>");
				
				$("#lblNoOfInvoice").text(": NA");
				$("#lblDriverName").text(": NA");
				$("#lblContactNo").text(": NA");
				$("#lblPassCode").text(": NA");
				
			
			},
				
			error : function(XMLHttpRequest, textStatus, errorThrown) {
                alert("Invalid Pass: Contact Admin "+errorThrown);
            }
		});
		
	}
	function printDiv(divName) {		
	     var printContents = document.getElementById(divName).innerHTML;
	     var originalContents = document.body.innerHTML;
	     document.body.innerHTML = printContents;
	     window.print();
	     document.body.innerHTML = originalContents;
	     location.reload();
	}
	</script>
</head>

<body>
	<!-- Pre-loader start -->
	<div class="theme-loader">
		<div class="loader-track">
			<div class="loader-bar"></div>
		</div>
	</div>
	<!-- Pre-loader end -->
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
			<nav class="navbar header-navbar pcoded-header">
				<div class="navbar-wrapper">
					<div class="navbar-logo">
						<a class="mobile-menu" id="mobile-collapse" href="#!"> <i
							class="ti-menu"></i>
						</a>
						<div class="mobile-search">
							<div class="header-search">
								<div class="main-search morphsearch-search">
									<div class="input-group">
										<span class="input-group-addon search-close"><i
											class="ti-close"></i></span> <input type="text" class="form-control"
											placeholder="Enter Keyword"> <span
											class="input-group-addon search-btn"><i
											class="ti-search"></i></span>
									</div>
								</div>
							</div>
						</div>
						<a href="index.html"> <img class="img-fluid"
							src="resources/assets/images/logo.png" alt="Theme-Logo" />
						</a> <a class="mobile-options"> <i class="ti-more"></i>
						</a>
					</div>

					<div class="navbar-container container-fluid">
						<ul class="nav-left">
							<li>
								<div class="sidebar_toggle">
									<a href="javascript:void(0)"><i class="ti-menu"></i></a>
								</div>
							</li>
							<li class="header-search">
								<div class="main-search morphsearch-search">
									<div class="input-group">
										<span class="input-group-addon search-close"><i
											class="ti-close"></i></span> <input type="text" class="form-control">
										<span class="input-group-addon search-btn"><i
											class="ti-search"></i></span>
									</div>
								</div>
							</li>
							<li><a href="#!" onClick="javascript:toggleFullScreen()">
									<i class="ti-fullscreen"></i>
							</a></li>
						</ul>
						<ul class="nav-right">
							<li class="header-notification"><a href="#!"> <i
									class="ti-bell"></i> <span class="badge bg-c-pink"></span>
							</a>
								<ul class="show-notification">
									<li>
										<h6>Notifications</h6> <label class="label label-danger">New</label>
									</li>
									<li>
										<div class="media">
											<img class="d-flex align-self-center img-radius"
												src="resources/assets/images/avatar-2.jpg"
												alt="Generic placeholder image">
											<div class="media-body">
												<h5 class="notification-user">Truck Name</h5>
												<p class="notification-msg">Lorem ipsum dolor sit amet,
													consectetuer elit.</p>
												<span class="notification-time">30 minutes ago</span>
											</div>
										</div>
									</li>

								</ul></li>

							<li class="user-profile header-notification"><a href="#!">
									<img src="resources/assets/images/avatar-4.jpg"
									class="img-radius" alt="User-Profile-Image"> <span>John
										Doe</span> <i class="ti-angle-down"></i>
							</a>
								<ul class="show-notification profile-notification">
									<li><a href="#!"> <i class="ti-settings"></i> Settings
									</a></li>
									<li><a href="#"> <i class="ti-user"></i> Profile
									</a></li>
									<li><a href="#"> <i class="ti-email"></i> My Messages
									</a></li>
									<li><a href="#"> <i class="ti-lock"></i> Lock Screen
									</a></li>
									<li><a href="#"> <i class="ti-layout-sidebar-left"></i>
											Logout
									</a></li>
								</ul></li>
						</ul>
					</div>
				</div>
			</nav>

			<!-- Sidebar inner chat end-->
			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">
					<nav class="pcoded-navbar">
						<div class="sidebar_toggle">
							<a href="#"><i class="icon-close icons"></i></a>
						</div>
						<div class="pcoded-inner-navbar main-menu">

							<ul class="pcoded-item pcoded-left-item">
								<li class=" "><a href="index.html"> <span
										class="pcoded-micon"><i class="ti-home"></i><b>D</b></span> <span
										class="pcoded-mtext">Dashboard</span> <span
										class="pcoded-mcaret"></span>
								</a></li>

								<li class="pcoded-hasmenu "><a href="javascript:void(0)">
										<span class="pcoded-micon"><i
											class="fa fa-check-square"></i><b>P</b></span> <span
										class="pcoded-mtext">Yard</span> <span class="pcoded-mcaret"></span>
								</a>
									<ul class="pcoded-submenu">

										<li class=""><a href="yardIn.html"> <span
												class="pcoded-micon"><i class="ti-layout"></i></span> <span
												class="pcoded-mtext">Yard In</span> <span
												class="pcoded-mcaret"></span>
										</a></li>
										<li class=" "><a href="slots.html"> <span
												class="pcoded-micon"><i class="ti-layout"></i></span> <span
												class="pcoded-mtext">Yard Slots</span> <span
												class="pcoded-mcaret"></span>
										</a></li>
										<li class=""><a href="vehicleList.html"> <span
												class="pcoded-micon"><i class="ti-angle-right"></i></span> <span
												class="pcoded-mtext">Truck List</span> <span
												class="pcoded-mcaret"></span>
										</a></li>

									</ul></li>

								<li class="pcoded-hasmenu active"><a
									href="javascript:void(0)"> <span class="pcoded-micon"><i
											class="icofont icofont-long-drive"></i><b>W</b></span> <span
										class="pcoded-mtext">VRO</span> <span class="pcoded-mcaret"></span>
								</a>
									<ul class="pcoded-submenu">
										<li class="active"><a href="javascript:void(0)"> <span
												class="pcoded-micon"><i class="ti-angle-right"></i></span> <span
												class="pcoded-mtext">Vehicle Registration</span> <span
												class="pcoded-mcaret"></span>
										</a></li>
										<li class=" "><a href="driverRegistration.html"> <span
												class="pcoded-micon"><i class="ti-angle-right"></i></span> <span
												class="pcoded-mtext">Driver Registration</span> <span
												class="pcoded-mcaret"></span>
										</a></li>

									</ul></li>
								<!-- <i class="fa fa-truck"></i> -->

								<li class="pcoded-hasmenu"><a href="javascript:void(0)">
										<span class="pcoded-micon"><i class="fa fa-truck"></i><b>W</b></span>
										<span class="pcoded-mtext">Loading</span> <span
										class="pcoded-mcaret"></span>
								</a>
									<ul class="pcoded-submenu">
										<li class=" "><a href="unloadingDockEntry.html"> <span
												class="pcoded-micon"><i class="ti-angle-right"></i></span> <span
												class="pcoded-mtext">Unloading Dock Entry</span> <span
												class="pcoded-mcaret"></span>
										</a></li>
										<li class=" "><a href="emptyDockEntry.html"> <span
												class="pcoded-micon"><i class="ti-angle-right"></i></span> <span
												class="pcoded-mtext">Empty Dock Entry</span> <span
												class="pcoded-mcaret"></span>
										</a></li>
									</ul></li>

								<li class="pcoded-hasmenu"><a href="javascript:void(0)">
										<span class="pcoded-micon"><i
											class="icofont icofont-upload"></i><b>W</b></span> <span
										class="pcoded-mtext">IBL</span> <span class="pcoded-mcaret"></span>
								</a>
									<ul class="pcoded-submenu">
										<li class=""><a href="uploadCriticalPart.html"> <span
												class="pcoded-micon"><i class="ti-angle-right"></i></span> <span
												class="pcoded-mtext">Upload Critical Part</span> <span
												class="pcoded-mcaret"></span>
										</a></li>
										<li class=" "><a href="approveCriticalPart.html"> <span
												class="pcoded-micon"><i class="ti-angle-right"></i></span> <span
												class="pcoded-mtext">Approve Critical Part</span> <span
												class="pcoded-mcaret"></span>
										</a></li>

									</ul></li>

								<li class=""><a href="gateEntry.html"> <span
										class="pcoded-micon"><i
											class="icofont icofont-ui-unlock"></i><b>N</b></span> <span
										class="pcoded-mtext">Gate Entry</span> <span
										class="pcoded-mcaret"></span>
								</a></li>
								<li class=""><a href="vehicleTracking.html"> <span
										class="pcoded-micon"><i class="fa fa-map-marker"></i><b>N</b></span>
										<span class="pcoded-mtext">Truck Tracker</span> <span
										class="pcoded-mcaret"></span>
								</a></li>

							</ul>
						</div>
					</nav>
					<div class="pcoded-content">
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper" style="padding: 0px !important;">
									<!-- Page-body start -->
									<div class="page-body">

										<div class="card borderless-card">
											<div class="card-block default-breadcrumb">
												<div class="breadcrumb-header">
													<h5>
														<i class="fa fa-truck"></i> VEHICLE REGISTRATION
													</h5>
												</div>
												<div class="m-t-10">
													<ul class="breadcrumb-title">
														<li class="breadcrumb-item"><a href="index.html">
																<i class="icofont icofont-home"></i>
														</a></li>

														<li class="breadcrumb-item"><a href="#!">Vehicle
																Registration</a></li>
													</ul>
												</div>
											</div>
										</div>
									<form id="second" action="saveVehicle" method="post" novalidate>
										<div class="card" style="display: none" id="disDivAddEditForm">
											<div class="panel panel-default">
												<div class="panel-heading bg-default txt-white">
													<i class="icofont icofont-plus-circle"></i> VEHICLE
													REGISTRATION <span class="float-right"><a
														id="linkClose" href="#"><i
															class="icofont icofont-ui-close"></i> Close</a></span>
												</div>
												<div class="panel-body">
													
														<div class="card-block">
															<div class="form-group row">
																<div class="col-lg-6">

																	<div class="row row-mar-botm ">
																		<label class="col-sm-5 col-form-label">Vehicle
																			No</label>
																		<div class="col-sm-7">
																			<div class="input-group">
																				<input type="text" class="form-control"
																					id="txtVehicleno" name="txtVehicleno"
																					placeholder="Enter Vehicle No"> <span
																					class="input-group-addon" id="basic-addon5"><i
																					class="fa fa-qrcode"></i></span> &nbsp;&nbsp; <a href="#"
																					style="padding: 9px 5px 5px 10px;"
																					class="btn btn-danger"><b><i
																						class="fa fa-copyright"></i></b></a>
																			</div>

																			<span class="messages popover-valid"></span>
																		</div>

																		<div class="col-sm-1"></div>
																	</div>


																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">Supplier
																			/ IBL</label>
																		<div class="col-sm-7">
																			<select class="form-control" id="cmbSupplierIBL1"
																				name="cmbSupplierIBL1" placeholder="Select Supplier">
																				<option value="">-Select-</option>
																				<option value="SUPPLIER">Supplier</option>
																				<option value="IBL">IBL</option>
																				
																			</select> <span class="messages popover-valid"></span>
																		</div>
																	</div>

																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">Supplier
																			Name</label>
																		<div class="col-sm-7">
																			<select class="form-control" id="cmbSupplierName"
																				name="cmbSupplierName"
																				placeholder="Select Supplier Name">
																				<option value="">-Select-</option>
																				<option value="SP1">Supplier 1</option>
																				<option value="SP2">Supplier 2</option>
																				<option value="SP3">Supplier 3</option>
																			</select> <span class="messages popover-valid"></span>
																		</div>
																	</div>
																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">Vehicle
																			Type</label>
																		<div class="col-sm-7">
																			<select class="form-control" id="cmbVehiceleType"
																				name="cmbVehiceleType"
																				placeholder="Select Vehicele Type ">
																				<option value="">-Select-</option>
																				<option value="BS2">BS 2</option>
																				<option value="BS3">BS 3</option>
																				<option value="BS4">BS 4</option>
																				<option value="BS5">BS 5</option>
																				<option value="BS6">BS 6</option>
																			</select> <span class="messages popover-valid"></span>
																		</div>
																	</div>
																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">RC Book
																			Valid Date</label>
																		<div class="col-sm-7">
																			<input class="form-control" type="date"
																				id="txtRcBookValidDate" name="txtRcBookValidDate"
																				placeholder="Select RC Book Valid Date"> <span
																				class="messages popover-valid"></span>
																		</div>
																	</div>
																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">Insurance
																			Valid Date</label>
																		<div class="col-sm-7">
																			<input class="form-control" type="date"
																				id="txtInsuranceValidDate"
																				name="txtInsuranceValidDate"
																				placeholder="Select Insurance Valid Date"> <span
																				class="messages popover-valid"></span>
																		</div>
																	</div>
																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">FC
																			Valid Date</label>
																		<div class="col-sm-7">
																			<input class="form-control" type="date"
																				id="txtFCValidDate" name="txtFCValidDate"
																				placeholder="Select FC Valid Date"> <span
																				class="messages popover-valid"></span>
																		</div>
																	</div>
																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">Licence
																			Valid Date</label>
																		<div class="col-sm-7">
																			<input class="form-control" type="date"
																				id="txtLicenceValidDate" name="txtLicenceValidDate"
																				placeholder="Select Licence Valid Date"> <span
																				class="messages popover-valid"></span>
																		</div>
																	</div>
																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">Pollution
																			Certificate Valid Date</label>
																		<div class="col-sm-7">
																			<input class="form-control" type="date"
																				id="txtPollutionCertificateValidDate"
																				name="txtPollutionCertificateValidDate"
																				placeholder="Select Pollution Certificate Valid Date">
																			<span class="messages popover-valid"></span>
																		</div>
																	</div>


																	<!--<div class="row row-mar-botm">
                                                               <label class="col-sm-5 col-form-label">&nbsp;</label>
                                                               <div class="col-sm-7">
                                                                <div class="checkbox-color ">
                                                                    <input id="RCBook" type="checkbox" checked="">
                                                                    <label for="RCBook">
                                                                        RC Book
                                                                    </label>
                                                                </div>
                                                                
                                                                <div class="checkbox-color ">
                                                                    <input id="Insurance" type="checkbox" checked="">
                                                                    <label for="Insurance">
                                                                         Valid Insurance
                                                                    </label>
                                                                </div>
                                                               
                                                                <div class="checkbox-color">
                                                                    <input id="FC" type="checkbox" checked="">
                                                                    <label for="FC">
                                                                        FC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                                                                    </label>
                                                                </div>
                                                                 <div class="checkbox-color">
                                                                    <input id="Drivinglicence" type="checkbox" checked="">
                                                                    <label for="Drivinglicence">
                                                                        Driving License
                                                                    </label>
                                                                </div>
                                                                
                                                                <div class="checkbox-color ">
                                                                    <input id="PollutionCertifi" type="checkbox" checked="">
                                                                    <label for="PollutionCertifi">
                                                                        Pollution Certificate
                                                                    </label>
                                                                </div>
                                                                
                                                               </div> 
                                                               </div>-->

																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label">Pass
																			Type</label>
																		<div class="col-sm-7">
																			<select class="form-control" id="cmbPassType"
																				name="cmbPassType" placeholder="Select Pass Type">
																				<option value="">-Select-</option>
																				<option value="ONE">One Day Pass</option>
																				<option value="MULTI">'N Time Pass</option>
																			</select> <span class="messages popover-valid"></span>
																		</div>
																	</div>

																	<div class="row row-mar-botm">
																		<label class="col-sm-5 col-form-label"
																			id="lblNTimePass">N' Time Pass Validity </label>
																		<div class="col-sm-7">
																			<input class="form-control" type="date"
																				id="txtNTimePassValitity"
																				name="txtNTimePassValitity"
																				placeholder="Select N'  Time Pass Valitity">

																			<span class="messages popover-valid"></span>
																		</div>


																	</div>


																</div>


																<div class="col-lg-6  ">
																	<div class="col-lg-12  "
																		style="border: 1px solid #ddd; padding: 10px; margin: 5px 0;">
																		<div class="row row-mar-botm">
																			<label class="col-sm-2 col-form-label">D-Tag</label>
																			<div class="col-sm-4">
																				<input type="text" class="form-control" id="txtDtag"
																					name="txtDtag" placeholder="Enter D-Tag ">
																				<span class="messages popover-valid"></span>
																			</div>
																			<label class="col-sm-2 col-form-label">C-Tag</label>
																			<div class="col-sm-4">
																				<input type="text" class="form-control" id="txtCtag"
																					name="txtCtag" placeholder="Enter C-Tag ">
																				<span class="messages popover-valid"></span>
																			</div>

																		</div>
																		<div class="row row-mar-botm">
																			<label class="col-sm-2 col-form-label">Jacket</label>
																			<div class="col-sm-4">
																				<input type="text" class="form-control"
																					id="txtJacket" name="txtJacket"
																					placeholder="Enter Jacket "> <span
																					class="messages popover-valid"></span>
																			</div>
																			<label class="col-sm-2 col-form-label">Invoices</label>
																			<div class="col-sm-4">
																				<input type="text" class="form-control"
																					id="txtInvoices" name="txtInvoices"
																					placeholder="Enter Invoices "> <span
																					class="messages popover-valid"></span>
																			</div>

																		</div>
																		<div class="row row-mar-botm">

																			<div class="col-sm-12" style="text-align: center">
																				<button type="button"
																					class="btn btn-default btn-gray">Issue
																					Clearance</button>
																				<span class="messages popover-valid"></span>
																			</div>
																		</div>
																	</div>
																	<div class="col-lg-12  "
																		style="border: 1px solid #ddd; padding: 10px; margin: 5px 0;">
																		<div class="row row-mar-botm">
																			<label class="col-sm-3 col-form-label">Issue
																				Remarks</label>
																			<div class="col-sm-9">
																				<textarea class="form-control" id="txtRemarks"
																					name="txtRemarks" placeholder="Enter Remarks"></textarea>
																				<span class="messages popover-valid"></span>
																			</div>

																		</div>
																		<div class="row row-mar-botm">
																			<label class="col-sm-3 col-form-label">Upload
																				Document</label>
																			<div class="col-sm-9">
																				<input type="file" class="form-control"> <span
																					class="messages popover-valid"></span>
																			</div>
																		</div>
																		<div class="row row-mar-botm">
																			<label class="col-sm-3 col-form-label">&nbsp;</label>
																			<div class="col-sm-9">
																				<button type="button"
																					class="btn btn-default btn-gray">Raise
																					Document</button>
																				&nbsp;
																				<button type="button"
																					class="btn btn-default btn-gray">Document
																					Issue Closed</button>
																				&nbsp;
																			</div>
																		</div>
																	</div>
																</div>

															</div>
														</div>
												</div>

												<div class="panel-footer">
													<div class="row">
														<!-- <label class="col-sm-2"></label> -->
														<div class="col-sm-12" style="text-align: center;">

															<button type="submit" class="btn btn-default btn-primary">Save</button>
															&nbsp;
															<button type="reset" class="btn btn-default btn-primary">Clear</button>

														</div>
													</div>

												</div>

											</div>
										</div>
										</form>
									</div>
									
									<!-- Modal large-->

									<div class="modal fade" id="print-Modal" tabindex="-1"
										role="dialog">
										<div class="modal-dialog modal-lg" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title">E-PASS</h4>
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
												</div>
												<div class="modal-body" id="print-modal">
													<form id="frmModelPrint" action="#" method="post"
														novalidate>
														<div class="card-block">

															<div class="row row-mar-botm ">
																<label class="col-sm-2 col-form-label">Gate No </label>
																<label id="lblGateNo" class="col-sm-3 col-form-label"> : &nbsp;
																	
																</label> 
																<label class="col-sm-6 col-form-label"
																	style="font-size: 32px;"> &nbsp; <i
																	class="icofont icofont-barcode"></i><i
																	class="icofont icofont-barcode"></i></label> <label
																	class="col-sm-2 col-form-label">Supplier Name </label>
																<label id="lblName" class="col-sm-3 col-form-label"> : &nbsp;
																	
																</label>
																
																<label class="col-sm-2 col-form-label">Pass Code</label>
																<label id="lblPassCode" class="col-sm-3 col-form-label"> : &nbsp;
																	
																</label> 
																
															</div>
															<div class="row row-mar-botm ">
																<label class="col-sm-2 col-form-label">Vehicle
																	No </label> <label id="lblVehicleNo" class="col-sm-3 col-form-label"> :
																	
																</label> <label class="col-sm-2 col-form-label">Type </label> <label
																	class="col-sm-3 col-form-label" id="lblVehicleType"> </label>

															</div>
															<div class="row row-mar-botm ">
																<label class="col-sm-2 col-form-label">Reporting
																	Time </label> <label id="lblReportingTime" class="col-sm-3 col-form-label"> :
																	
																</label> <label class="col-sm-2 col-form-label">No Of
																	Invoices </label> <label id="lblNoOfInvoice" class="col-sm-3 col-form-label">
																	
																</label>

															</div>
															<div class="row row-mar-botm ">
																<label class="col-sm-2 col-form-label">Driver
																	Name </label> <label id="lblDriverName" class="col-sm-3 col-form-label"> :
																	
																</label> <label class="col-sm-2 col-form-label">Contact
																	No </label> <label id="lblContactNo" class="col-sm-3 col-form-label"> :
																	
																</label>

															</div>
															<div class="row row-mar-botm ">
																<label class="col-sm-2 col-form-label">Tag No </label> <label
																	class="col-sm-10 col-form-label"> : <b>&nbsp;
																		D - <input type="text" name="txt1" readonly
																		class="col-1" value="95">
																		&nbsp;&nbsp;&nbsp;&nbsp; C - <input type="text"
																		name="txt2" readonly class="col-1" value="Nill">
																		&nbsp;&nbsp;&nbsp;&nbsp; Jacket - <input type="text"
																		name="txt2" readonly class="col-1" value="Nill">
																</b>
																</label>

															</div>

														</div>

													</form>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default waves-effect "
														data-dismiss="modal">Close</button>
													<button type="button" onClick="printDiv('print-modal');"
														class="btn btn-primary waves-effect waves-light ">Print
														Pass</button>
												</div>
											</div>
										</div>
									</div>


									<div class="card">
										<div class="panel panel-default">
											<div class="panel-heading bg-default txt-white">
												<i class="icofont icofont-list"></i> VEHICLE LIST <span
													class="float-right"><a id="linkAdd" href="#"><i
														class="icofont icofont-plus"></i> ADD</a></span>
											</div>
											<div class="panel-body">
												<div class="card">
													<div class="card-block">
														<div class="">
															<div class="dt-responsive table-responsive ">
																<table id="new-cons"
																	class="table  table-striped table-bordered nowrap">
																	<thead>
																		<tr>
																			<th>#</th>
																			<th>Vehicle No</th>
																			<th>Supplier <br> Name
																			</th>
																			<th data-hide="all">Supplier/TVS</th>
																			<th data-hide="all">Insurance</th>
																			<th data-hide="all">RC</th>
																			<th data-hide="all">FC</th>
																			<th data-hide="all">Licence</th>
																			<th data-hide="all">Pollution <br>
																				Certificate
																			</th>
																			<th data-hide="all">Pass <br> Type
																			</th>
																			<th>Options</th>

																		</tr>
																	</thead>
																	<tbody>
																	<c:forEach var="vehicle" items="${vehicles}">
																	<tr>
																	    <td><c:out value="${vehicle.entry_No}"/></td>
																		<td><c:out value="${vehicle.vehicle_No}"/></td>
																		<td><c:out value="${vehicle.supplier}"/></td>
																		<td><c:out value="${vehicle.supplier_Name}"/></td>
																		<td><c:out value="${vehicle.license_Valid_Date}"/></td>
																		<td><c:out value="${vehicle.RCBOOK_Valid_Date}"/></td>
																		<td><c:out value="${vehicle.FC_Valid_Date}"/></td>
																		<td><c:out value="${vehicle.license_Valid_Date}"/></td>
																		<td><c:out value="${vehicle.pollution_Certificate_Valid_Date}"/></td>
																		<td><c:out value="${vehicle.pass_Type}"/></td>
																		<td><button class="btn btn-warning btn-icon">
																				<i style="margin-right: 0px;"
																					class="icofont icofont-pencil"></i>
																			</button>&nbsp;
																			<button class="btn btn-primary btn-icon">
																				<i style="margin-right: 0px;" data-toggle="modal"
																					data-target="#print-Modal"
																					class="icofont icofont-print" onclick="OnPrint('${vehicle.vehicle_No}');"></i>
																			</button>
																		</td>
																		</tr>
																	</c:forEach>
																	</tbody>
																</table>
															</div>
														</div>
													</div>

												</div>
												<!-- Config. table end -->

											</div>

										</div>
									</div>
								</div>
								<!-- Page-body end -->
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- Required Jquery -->
	<script src="resources/bower_components/jquery/js/jquery.min.js"></script>
	<script src="resources/bower_components/jquery-ui/js/jquery-ui.min.js"></script>
	<script src="resources/bower_components/popper.js/js/popper.min.js"></script>
	<script src="resources/bower_components/bootstrap/js/bootstrap.min.js"></script>
	<!-- jquery slimscroll js -->
	<script
		src="resources/bower_components/jquery-slimscroll/js/jquery.slimscroll.js"></script>
	<!-- modernizr js -->
	<script src="resources/bower_components/modernizr/js/modernizr.js"></script>
	<script src="resources/bower_components/modernizr/js/css-scrollbars.js"></script>

	<!-- Bootstrap date-time-picker js -->
	<script
		src="resources/assets/pages/advance-elements/moment-with-locales.min.js"></script>
	<script
		src="resources/bower_components/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
	<script
		src="resources/assets/pages/advance-elements/bootstrap-datetimepicker.min.js"></script>
	<!-- data-table js -->
	<script
		src="resources/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="resources/bower_components/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script src="resources/assets/pages/data-table/js/jszip.min.js"></script>
	<script src="resources/assets/pages/data-table/js/pdfmake.min.js"></script>
	<script src="resources/assets/pages/data-table/js/vfs_fonts.js"></script>
	<script
		src="resources/assets/pages/data-table/extensions/responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="resources/bower_components/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="resources/bower_components/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script
		src="resources/bower_components/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="resources/bower_components/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="resources/bower_components/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
	<!-- Custom js -->

	<script
		src="resources/assets/pages/data-table/extensions/responsive/js/responsive-custom.js"></script>
	<!-- menu js -->
	<script src="resources/assets/js/pcoded.min.js"></script>
	<script src="resources/assets/js/navbar-image/vertical-layout.min.js "></script>

	<script src="resources/assets/js/script.js"></script>
	
</body>

</html>
