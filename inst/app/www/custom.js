$(document).ready(function() {
  // Use event delegation for dynamically created elements
  $(document).on('click', '.card-header', function(e) {
    // Don't trigger if clicking on the actual collapse button
    if (!$(e.target).closest('.card-tools').length) {
      // Find the collapse button in this header and trigger click
      var collapseBtn = $(this).find('[data-card-widget="collapse"]');
      if (collapseBtn.length > 0) {
        collapseBtn.trigger('click');
      }
    }
  });
  // Cursor styles for card headers are handled in custom.css

  // Tab script - Apply to ALL tabsetPanels
  $('.nav-tabs li.active > a').addClass('active');

  $(document).on('shown.bs.tab', '.nav-tabs a[data-toggle="tab"]', function(e) {
    $('.nav-tabs a[data-toggle="tab"]').removeClass('active');
    $(e.target).addClass('active');
  });
  
  // Legacy specific tab script (kept for backwards compatibility)
  $('#cnv_1-sample_select_tabs li.active > a').addClass('active');

  $(document).on('shown.bs.tab', '#cnv_1-sample_select_tabs a[data-toggle="tab"]', function(e) {
    $('#cnv_1-sample_select_tabs a[data-toggle="tab"]').removeClass('active');
    $(e.target).addClass('active');
  });
});