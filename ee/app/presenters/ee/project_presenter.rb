# frozen_string_literal: true

module EE
  module ProjectPresenter
    extend ::Gitlab::Utils::Override

    override :statistics_anchors
    def statistics_anchors(show_auto_devops_callout:)
      super + extra_statistics_anchors
    end

    def extra_statistics_anchors
      anchors = []

      if can?(current_user, :read_project_security_dashboard, project)
        anchors << security_dashboard_data
      end

      anchors
    end

    def approver_groups
      ::ApproverGroup.filtered_approver_groups(project.approver_groups, current_user)
    end

    private

    def security_dashboard_data
      OpenStruct.new(enabled: true,
                     label: _('Security Dashboard'),
                     link: project_security_dashboard_path(project))
    end
  end
end