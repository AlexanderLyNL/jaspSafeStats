//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
import QtQuick
import QtQuick.Layouts
import JASP.Controls
import JASP.Widgets
import JASP

Form
{
  info: qsTr("The one sample t-test allows you to estimate the effect size and test the null hypothesis that the population mean equals a specific constant, i.e., the test value.\n") +
        "## " + "Assumptions" + "\n" + "- Continuous dependent variable.\n" + "- The data are a random sample from the population.\n" + "- The dependent variable is normally distributed in the population."

  VariablesForm
  {
      infoLabel: qsTr("Input")
      preferredHeight: jaspTheme.smallDefaultVariablesFormHeight
      AvailableVariablesList { name: "allVariablesList" }
      AssignedVariablesList
      {
          name: "dependent"
          title: qsTr("Variables")
          info: qsTr("In this box the dependent variable is selected.")
          allowedColumns: ["scale"]
          minNumericLevels: 1
      }
  }

  Section
  {
    title   : qsTr("Advanced")
    columns: 1

    Text { text: qsTr("This example shows how to get the factors of a variable") }

    DropDown
    {
      id              : nominalOrOrdinalVariables
      name            : "nominalOrOrdinalVariables"
      label           : "Nominal or Ordinal variable"
      addEmptyValue   : true
      placeholderText : qsTr("Select one variable")
      source          : [{isDataSetVariables: true, use: "type=nominal|ordinal" } ]
      info            : qsTr("Only nominal or ordinal variable are available. Choose one of them.")
    }

    Text
    {
      text          : qsTr("<b>Warning</b>: No nominal or ordinal variable in your dataset.<br>Either change a variable type from scale to nominal (or ordinal), or load another dataset")
      visible       : nominalOrOrdinalVariables.count === 1 // Empty value is already 1 element.
    }

    Group
    {
      visible       : nominalOrOrdinalVariables.value !== ""

      ComponentsList
      {
        id            : valuePerLevel
        title         : "Set value for each factor"
        name          : "values"
        source        : nominalOrOrdinalVariables.value !== "" ? [{values: [nominalOrOrdinalVariables.value], use: "levels" }] : []
        headerLabels  : [qsTr("Check"), qsTr("Value")]

        rowComponent: RowLayout
        {
          Text        { text: rowValue  ; Layout.preferredWidth: 100 * jaspTheme.uiScale  }
          CheckBox    { name: "check"   ; Layout.preferredWidth: 100 * jaspTheme.uiScale  }
          DoubleField { name: "double"                                                    }
        }
      }

      Text
      {
        text          : qsTr("The factors checked in the list above will be present in the dropdown below")
      }

      DropDown
      {
        label            : "Checked factors"
        name            : "checkedFactor"
        source          : [{ name: "values", condition: "check"}]
        addEmptyValue   : true
      }
    }
  }

}
