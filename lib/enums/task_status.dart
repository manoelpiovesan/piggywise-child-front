///
///
///
enum TaskStatus {
  pending,
  in_progress,
  waiting_approval,
  done;

  ///
  ///
  ///
  static TaskStatus fromString(final String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return TaskStatus.pending;
      case 'in_progress':
        return TaskStatus.in_progress;
      case 'waiting_approval':
        return TaskStatus.waiting_approval;
      case 'done':
        return TaskStatus.done;
      default:
        return TaskStatus.pending;
    }
  }
}
