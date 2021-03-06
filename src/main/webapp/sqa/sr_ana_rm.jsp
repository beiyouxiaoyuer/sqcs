<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//en" "http://www.w3. org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>质量技术支持平台</title>
</head>

<%@ include file="../pub_root.jsp"%>
<%@ include file="../gragh_pub_version.jsp"%>

<body>
	<div class="gragh-title">
		<b>版本需求开发过程分布(SR数)</b>
	</div>
	<div id="container" style="min-width: 100%; height: 400px;" align="center"></div>
</body>

<script type="text/javascript">
	function list_data() {

		var myChart = echarts.init($('#container').get(0));
		var Msg = '';
		var itemStyle = {
			normal : {
				color : function(params) {
					if (params.dataIndex < 0) {
						return zrColor.lift(colorList[colorList.length - 1], params.seriesIndex * 0.1);
					} else {
						return zrColor.lift(colorList[params.dataIndex], params.seriesIndex * 0.1);
					}
				}
			}
		};

		$.ajax({
			async : true,
			type : 'POST',
			dataType : 'JSON',
			contentType : "application/x-www-form-urlencoded",
			url : '/sqcs/sr_ana_rm',
			data : {
				"system_version" : $("#version").val(),
			},
			success : function(result) {
				result = result[0];
				var barLegend = [];
				$.each(result.listYdata, function() {
					barLegend.push(this.name);
				});
				var y_series;
				if (result.listYdata.length == 0 || result.listXdata.length == 0) {
					y_series = result.listYdata;
				} else {
					y_series = [ {
						data : result.listYdata[0].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{c}"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[0].name,
						type : result.listYdata[0].type,
						yAxis : result.listYdata[0].yAxis
					},{
						data : result.listYdata[1].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{c}"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[1].name,
						type : result.listYdata[1].type,
						yAxis : result.listYdata[1].yAxis
					},{
						data : result.listYdata[2].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{c}"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[2].name,
						type : result.listYdata[2].type,
						yAxis : result.listYdata[2].yAxis
					},{
						data : result.listYdata[3].data,
						itemStyle : {
							normal : {
								label : {
									show : true,
									formatter : "{c}"
								},
								labelLine : {
									show : true
								}
							}
						},
						name : result.listYdata[3].name,
						type : result.listYdata[3].type,
						yAxis : result.listYdata[3].yAxis
					} ];
				}
				myChart.setTheme(theme);
				myChart.setOption({

					tooltip : {
						trigger : 'axis'
					},

					legend : {
						orient : 'horizontal',
						x : 'left',
						y : 'top',
						itemGap : 10,
						padding : 0,
						textStyle : {
							color : 'auto'
						},
						data : barLegend
					},

					toolbox : {
						show : true,
						itemGap : 10,
						padding : 0,
						orient : 'horizontal',
						x : 'right',
						y : 'top',
						feature : {
		                    'mark':{'show':true},
		                    'dataView':{'show':true,'readOnly':false},
		                    'magicType':{'show':true,'type':['line','bar','stack','tiled']},
		                    'restore':{'show':true},
		                    'saveAsImage':{'show':true}
						}
					},
					grid : {
						'y' : 40,
						'y2' : 100
					},
					xAxis : [ {
						axisLabel : {
							rotate : 30
						},
						type : 'category',
						data : result.listXdata,
						splitLine : {
							show : false
						}
					} ],

					yAxis : [ {
						type : 'value',
						name : 'SR数',
						boundaryGap : [ 0, 0.5 ]
					} ],
					series : y_series
				});
			}
		});
	}

	$(function() {
		get_test_team('养老险测试组');
		get_version();
		list_data();
	});
</script>
</html>