<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="19008000">
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
		<Item Name="DosagesQueueHandler.vi" Type="VI" URL="../DosagesQueueHandler.vi"/>
		<Item Name="DrugControllerMain.vi" Type="VI" URL="../DrugControllerMain.vi"/>
		<Item Name="DrugDosageTimeStampReference.ctl" Type="VI" URL="../DrugDosageTimeStampReference.ctl"/>
		<Item Name="PopulateSheduledStatusOfDosages.vi" Type="VI" URL="../PopulateSheduledStatusOfDosages.vi"/>
		<Item Name="Scheduler.vi" Type="VI" URL="../Scheduler.vi"/>
		<Item Name="Status.vi" Type="VI" URL="../Status.vi"/>
		<Item Name="TimeSimulator.vi" Type="VI" URL="../TimeSimulator.vi"/>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
