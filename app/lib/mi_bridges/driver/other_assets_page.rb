module MiBridges
  class Driver
    class OtherAssetsPage < FillInAndClickNextPage
      def self.title
        "Other Assets"
      end

      delegate(
        :financial_accounts,
        :primary_member,
        :real_estate_income?,
        :vehicle_income?,
        to: :snap_application,
      )

      def fill_in_required_fields
        check_vehicles
        check_real_estate
        check_burial_assets
        check_life_insurance
        check_additional_assets
        check_selling_or_giving_away
      end

      private

      def check_vehicles
        check_in_section(
          "starVehicles",
          condition: vehicle_income?,
          for_label: primary_member.mi_bridges_formatted_name,
        )
      end

      def check_real_estate
        check_in_section(
          "starRealEstate",
          condition: real_estate_income?,
          for_label: primary_member.mi_bridges_formatted_name,
        )
      end

      def check_burial_assets
        check_no_one_in_section "starBurialAssets"
      end

      def check_life_insurance
        check_in_section(
          "starLifeInsurance",
          condition: financial_accounts.include?("life_insurance"),
          for_label: primary_member.mi_bridges_formatted_name,
        )
      end

      def check_additional_assets
        check_no_one_in_section "starAdditionalAssets"
      end

      def check_selling_or_giving_away
        check_no_one_in_section "starSellingorGivingAwayAssets"
      end
    end
  end
end
