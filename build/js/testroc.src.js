
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"dependentVar","title":"Dependent Variable","type":"Variable"},{"name":"classVar","title":"Class Variable","type":"Variable"},{"name":"subGroup","title":"Group Variable","type":"Variable"},{"name":"method","title":"Method","type":"List","options":[{"name":"maximize_metric","title":"Maximize metric"},{"name":"minimise_metric","title":"Minimize metric"},{"name":"maximize_loess_metric","title":"Maximize LOESS metric"},{"name":"minimize_loess_metric","title":"Minimize LOESS metric"},{"name":"maximize_spline_metric","title":"Maximize spline metric"},{"name":"minimize_spline_metric","title":"Minimize spline metric"},{"name":"maximize_boot_metric","title":"Maximize boot metric"},{"name":"minimize_boot_metric","title":"Minimize boot metric"},{"name":"oc_youden_kernel","title":"Maximize Youden-Index | Kernel smoothed"},{"name":"oc_youden_normal","title":"Maximize Youden-Index | Parametric normal"},{"name":"oc_manual","title":"Custom cut score"}]},{"name":"allObserved","title":"All observed scores","type":"Bool"},{"name":"specifyCutScore","title":"Specify cut score","type":"String"},{"name":"metric","title":"Metric","type":"List","options":[{"name":"sum_sens_spec","title":"Sum Sens-Spec"},{"name":"accuracy","title":"Accuracy"},{"name":"youden","title":"Youden-Index"},{"name":"sum_sens_spec","title":"Sum: Sens/Spec"},{"name":"sum_ppv_npv","title":"Sum: PPV/NPV"},{"name":"prod_sens_spec","title":"Prod: Sens/Spec"},{"name":"prod_ppv_npv","title":"Prod: PPV/NPV"},{"name":"cohens_kappa","title":"Cohen's Kappa"},{"name":"abs_d_sens_spec","title":"Abs. d: Sens/Spec"},{"name":"roc01","title":"ROC"},{"name":"abs_d_ppv_npv","title":"Abs. d: PPV/NPV"},{"name":"p_chisquared","title":"Chi-squared"},{"name":"odds_ratio","title":"Odds Ratio"},{"name":"risk_ratio","title":"Risk Ratio"},{"name":"misclassification_cost","title":"Misclassification Cost"},{"name":"total_utility","title":"Total Utility"},{"name":"F1_score","title":"F1 score"}]},{"name":"boot_runs","title":"Bootstrap runs","type":"Number"},{"name":"use_midpoint","title":"Use midpoint","type":"Bool"},{"name":"break_ties","title":"Break Ties","type":"List","options":[{"name":"c","title":"All"},{"name":"mean","title":"Mean"},{"name":"median","title":"Median"}]},{"name":"tol_metric","title":"Tolerance metric","type":"Number"},{"name":"direction","title":"Direction","type":"List","options":[{"name":">=","title":">="},{"name":"<=","title":"<="}]},{"name":"plotROC","title":"ROC","type":"Bool","default":true}];

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
				},
				{
					type: DefaultControls.ComboBox,
					name: "metric"
				},
				{
					type: DefaultControls.ComboBox,
					name: "break_ties"
				},
				{
					type: DefaultControls.ComboBox,
					name: "direction"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.CheckBox,
					name: "allObserved"
				},
				{
					type: DefaultControls.CheckBox,
					name: "use_midpoint"
				},
				{
					type: DefaultControls.CheckBox,
					name: "plotROC"
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
					format: FormatDef.string
				},
				{
					type: DefaultControls.TextBox,
					name: "boot_runs",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					name: "tol_metric",
					format: FormatDef.number
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
