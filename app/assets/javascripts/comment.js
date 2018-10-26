$(function() {
  return $('.infinite-table').infinitePages({
    loading: function() {
      return $(this).text(I18n.t('flash.loading'));
    },
    error: function() {
      return $(this).button(I18n.t('flash.loading_error'));
    }
  });
});