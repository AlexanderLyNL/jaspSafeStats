import QtQuick
import JASP.Module

Description
{
    name		: "jaspSafeStats"
    title		: qsTr("Safe Anytime-Valid Inference")
    description	: qsTr("e-values")
	version		: "0.1"
    author		: "Alexander Ly, Sebastian Arias, Sebastian Arnold, Stephan Bongers, Michele Meziu, Angel Reyero Lobo, Dante de Roos, Peter Grunwald"
    maintainer	: "Alexander Ly <a.ly@cwi.nl>"
    website		: "https://github.com/AlexanderLyNL/jaspSafeStats/"
    license		: "GPL (>= 2)"
    icon        : "exampleIcon.png" // Located in /inst/icons/
    preloadData : true
	requiresData: true


	GroupTitle
	{
        title:	qsTr("Design")
	}

	Analysis
	{
        title: qsTr("Design object creation") // Title for window
        menu: qsTr("Design object creation")  // Title for ribbon
		func: "interfaceExample"           // Function to be called
		qml: "Interface.qml"               // Design input window
		requiresData: false                // Allow to run even without data
	}

	GroupTitle
	{
        title:	qsTr("Analyses")
	}

    Analysis
    {
      title: qsTr("Loading data")
      menu: qsTr("Loading data")
      func: "processTable"
      qml: "LoadingData.qml"
    }

    /*GroupTitle
	{
	  title: qsTr("Plotting")
	}

	Analysis
	{
	  title: qsTr("Plot a parabola")
	  func: "parabola"
	  qml: "Parabola.qml"
	  requiresData: false
    }*/
}
