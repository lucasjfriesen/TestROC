
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"dependentVar","title":"Dependent Variable","type":"Variable"},{"name":"classVar","title":"Class Variable","type":"Variable"},{"name":"subGroup","title":"Group Variable","type":"Variable"},{"name":"method","title":"Method","type":"List","options":[{"name":"optionA","title":"optionA"}]},{"name":"specifyCutScore","title":"Specify cut score","type":"Number"},{"name":"metric","title":"Metric","type":"List","options":[{"name":"optionA","title":"optionA"}]},{"name":"boot_runs","title":"Bootstrap runs","type":"Number"},{"name":"use_midpoint","title":"Use midpoint","type":"Bool"},{"name":"break_ties","title":"Break Ties","type":"Bool"},{"name":"tol_metric","title":"Tolerance metric","type":"Number"},{"name":"ROC","title":"ROC","type":"Bool"}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "TestROC",
    jus: "2.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Dependent Variable",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "dependentVar",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Class Variable",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "classVar",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Group Variable",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "subGroup",
							maxItemCount: 1,
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.ComboBox,
					name: "method"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					name: "specifyCutScore",
					format: FormatDef.number
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.ComboBox,
					name: "metric"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					name: "boot_runs",
					format: FormatDef.number
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.CheckBox,
					name: "use_midpoint"
				},
				{
					type: DefaultControls.CheckBox,
					name: "break_ties"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					name: "tol_metric",
					format: FormatDef.number
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.CheckBox,
					name: "ROC"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
