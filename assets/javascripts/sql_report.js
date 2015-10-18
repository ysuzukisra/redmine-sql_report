// Grid表示 by HANDSONTABLE
$(function() {
  var container = $("#grid");
  var grid_data = container.data("data");
  // HANDSONTABLE でグリッド表示
  container.handsontable({
    data: grid_data,
    language: 'ja',
    readOnly: true,
    fillHandle: false,
    rowHeaders: false,
    colHeaders: Object.keys(grid_data[0]),
    columnSorting: true,
    search: true,
    sortIndicator: true,
    manualColumnMove: true,
    manualColumnResize: true,
    manualRowResize: true,
    contextMenu: ['alignment']
  });
  var hot = container.handsontable('getInstance');
  //hot.render();
})
