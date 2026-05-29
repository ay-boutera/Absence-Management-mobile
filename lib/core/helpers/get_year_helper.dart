// features/home/pages/home_page.dart

String getYearHelper(String level) {
  switch (level) {
    case 'L1':
      return '1CP';
    case 'L2':
      return '2CP';
    case 'L3':
      return '3CS';
    case 'L4':
      return '4CS';
    case 'L5':
      return '5CS';
    default:
      return '';
  }
}
