require "rails_helper"

RSpec.feature "Medicaid app" do
  scenario "with multiple members", :js do
    visit medicaid_root_path

    within(".slab--hero") do
      click_on "Apply for Medicaid"
    end

    on_pages "Introduction" do
      expect(page).to have_content("Welcome to the Medicaid application")
      click_on "Next"

      click_on "Yes"

      fill_in "What is your first name?", with: "Jessie"
      fill_in "What is your last name?", with: "Tester"
      select_radio(question: "What is your gender?", answer: "Female")
      click_on "Next"

      click_on "Add a member"

      fill_in "What is their first name?", with: "Christa"
      fill_in "What is their last name?", with: "Tester"
      select_radio(question: "What is their gender?", answer: "Female")
      click_on "Next"

      click_on "Add a member"

      fill_in "What is their first name?", with: "Joel"
      fill_in "What is their last name?", with: "Tester"
      select_radio(question: "What is their gender?", answer: "Male")
      click_on "Next"
    end

    expect(page).to have_content("Jessie Tester")
    expect(page).to have_content("Christa Tester")
    expect(page).to have_content("Joel Tester")
    click_on "Next"

    on_page "Introduction" do
      expect(page).to have_content(
        "Is anyone in your household currently married?",
      )
      click_on "Yes"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        t("medicaid.intro_marital_status_member.edit.title"),
      )
      check "Jessie Tester"
      check "Christa Tester"
      check "Joel Tester"
      click_on "Next"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        "Tell us who Jessie Tester is currently married to",
      )
      choose "Christa Tester"
      click_on "Next"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        "Tell us who Joel Tester is currently married to",
      )
      choose "Other - not listed"
      click_on "Next"
    end

    on_page "Introduction" do
      expect(page).to have_content("Is anyone currently a college student?")
      click_on "Yes"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        t("medicaid.intro_college_member.edit.title"),
      )
      check "Jessie Tester"
      click_on "Next"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        "Is everyone in your household currently a US citizen",
      )
      click_on "No"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        t("medicaid.intro_citizen_member.edit.title"),
      )
      check "Jessie Tester"
      click_on "Next"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        "Is anyone a caretaker or parent of other people in the household?",
      )
      click_on "Yes"
    end

    on_page "Introduction" do
      expect(page).to have_content(
        t("medicaid.intro_caretaker_member.edit.title"),
      )
      check "Joel Tester"
      check "Jessie Tester"
      click_on "Next"
    end

    on_page "Health Coverage Needs" do
      expect(page).to have_content(
        "Next, describe your health coverage and status.",
      )

      click_on "Next"
      expect(page).to have_content(
        t("medicaid.insurance_needed.edit.title"),
      )
      uncheck "Jessie Tester"
      uncheck "Christa Tester"
      uncheck "Joel Tester"
      click_on "Next"
    end

    on_page "Health Coverage Needs" do
      expect(page).to have_content("Make sure you select at least one person")
      check "Jessie Tester"
      check "Christa Tester"
      uncheck "Joel Tester"
      click_on "Next"
    end

    on_pages "Health Coverage Needs" do
      expect(page).to have_content(
        "Is anyone currently enrolled in a health insurance plan?",
      )
      click_on "Yes"
    end

    on_page "Health Coverage Needs" do
      expect(page).to have_content(
        I18n.t("medicaid.insurance_current_member.edit.title"),
      )
      expect(page).to have_content("Jessie Tester")
      expect(page).to have_content("Christa Tester")
      expect(page).to have_content(
        "You've already indicated that Joel Tester is not in need of" \
        " additional health coverage.",
      )
      click_on "Next"

      expect(page).to have_content("Make sure you select a person")
      check "Jessie Tester"
      click_on "Next"
    end

    on_page "Health Coverage Needs" do
      expect(page).to have_content(
        "What type of insurance plan is Jessie Tester currently enrolled in",
      )
      choose("Medicaid")
      click_on "Next"
    end

    on_page "Health Coverage Needs" do
      expect(page).to have_content(
        "Do you need help paying for medical expenses from the last 3 months?",
      )
    end

    on_pages "Health Coverage Needs" do
      expect(page).to have_content(
        "Do you need help paying for medical expenses from the last 3 months?",
      )
      click_on "Yes"
    end

    on_pages "Quick Health Questions" do
      expect(page).to have_content(
        "Does anyone in your household have a disability?",
      )
      click_on "Yes"

      expect(page).to have_content(
        t("medicaid.health_disability_member.edit.title"),
      )
      check "Jessie Tester"
      click_on "Next"

      expect(page).to have_content(
        "Has anyone been pregnant recently?",
      )
      click_on "Yes"

      expect(page).to have_content(
        t("medicaid.health_pregnancy_member.edit.title"),
      )
      check "Jessie Tester"
      click_on "Next"

      expect(page).to have_content(
        "Have you or someone in your household been affected "\
        "by the Flint Water Crisis",
      )
      click_on "Yes"

      expect(page).to have_content("We’ve noted this on your application.")
      click_on "Next"
    end

    on_pages "Quick Tax Questions" do
      expect(page).to have_content(
        "Now describe how you file your taxes.",
      )
      click_on "Next"

      expect(page).to have_content(
        "Are you planning on filing taxes?",
      )

      click_on "Yes"

      expect(page).to have_content(
        "Do you plan on filing taxes with any family members "\
        "in your household?",
      )

      click_on "Yes"

      expect(page).to have_content(
        t("medicaid.tax_filing_with_household_members_member.edit.title"),
      )
      check "Joel Tester"
      click_on "Next"

      expect(page).to have_content(
        I18n.t(
          "medicaid.tax_filing_with_household_members_relationship.edit.title",
        ),
      )

      click_on "Next"
      expect(page).to have_content("Make sure you select one option")

      select "Joint"
      click_on "Next"

      expect(page).to have_content("Great! Let's review your tax info:")
      expect(page).to have_content("Joel Tester - Joint")
      click_on "Next"
    end

    on_page "Income & Expenses" do
      expect(page).to have_content("Next, describe your income and expenses.")

      click_on "Next"
    end

    on_pages "Current Income" do
      expect(page).to have_content(
        "Does anyone in your household currently have a job?",
      )
      click_on "Yes"

      expect(page).to have_content(
        "Tell us who in your household has one or more jobs.",
      )
      select_job_number(display_name: "Christa Tester", job_number: "2 jobs")
      click_on "Next"

      expect(page).to have_content("Is anyone in the household self-employed?")
      click_on "Yes"

      expect(page).to have_content(
        t("medicaid.income_self_employment_member.edit.title"),
      )
      check "Jessie Tester"
      click_on "Next"

      expect(page).to have_content(
        "Does anyone in the household get income that’s not from a job?",
      )
      click_on "Yes"

      expect(page).to have_content(
        t("medicaid.income_other_income_member.edit.title"),
      )
      check "Jessie Tester"
      check "Christa Tester"
      click_on "Next"

      expect(page).to have_content(
        "What type of income does Jessie Tester receive that’s not from a job?",
      )
      check "Unemployment"
      click_on "Next"

      expect(page).to have_content(
        "What type of income does Christa Tester receive that’s not from a" +
        " job?",
      )
      check "Other"
      click_on "Next"
    end

    on_pages "Current Expenses" do
      expect(page).to have_content(
        "Does anyone in your household pay child support, alimony, or arrears?",
      )
      click_on "Yes"

      expect(page).to have_content(
        t("medicaid.expenses_alimony_member.edit.title"),
      )
      check "Jessie Tester"
      check "Christa Tester"
      click_on "Next"

      expect(page).to have_content(
        "Does anyone in your household pay student loan interest?",
      )
      click_on "Yes"

      expect(page).to have_content(
        t("medicaid.expenses_student_loan_member.edit.title"),
      )
      check "Jessie Tester"
      click_on "Next"
    end

    on_page "Income & Expense Amounts" do
      expect(page).to have_content("You're almost done!")
      click_on "Next"
    end

    on_page "Income & Expense Amounts" do
      expect(page).to have_content(
        "Tell us Jessie Tester’s specific income received",
      )
      fill_in "step_self_employed_monthly_income", with: 100
      fill_in "step_unemployment_income", with: 100
      click_on "Next"
    end

    on_page "Income & Expense Amounts" do
      expect(page).to have_content(
        "Tell us Christa Tester’s specific income received",
      )

      within(find("fieldset", text: "Job #1")) do
        fill_in "Employer name", with: "CfA"
        fill_in "Average amount / paycheck", with: 100
        select "Monthly", from: "How often are you paid that amount?"
      end

      within(find("fieldset", text: "Job #2")) do
        fill_in "Employer name", with: "Cylinder"
        fill_in "Average amount / paycheck", with: 100
        select "Monthly", from: "How often are you paid that amount?"
      end

      click_on "Next"

      expect(page).to have_content("Tell us Jessie Tester’s specific expenses")
      fill_in(
        "step_child_support_alimony_arrears_expenses",
        with: "100",
      )
      fill_in "step_self_employed_monthly_expenses", with: "100"
      click_on "Next"

      expect(page).to have_content("Tell us Christa Tester’s specific expenses")

      fill_in(
        "step_child_support_alimony_arrears_expenses",
        with: "100",
      )
      click_on "Next"
    end

    on_page "Contact Information & Followup" do
      expect(page).to have_content(
        "Now, let's get your contact and followup information.",
      )
      click_on "Next"

      expect(page).to have_content(
        "Do you have stable housing right now?",
      )
      click_on "No"
    end

    on_page "Contact Information & Followup" do
      expect(page).to have_content(
        "Is there a reliable place to send you mail?",
      )
      click_on "No"
    end

    on_page "Contact Information & Followup" do
      expect(page).to have_content(
        "What is the best number for you to receive phone calls?",
      )
      fill_in "Phone number", with: "5555555555"
      click_on "Next"
    end

    on_page "Contact Information & Followup" do
      expect(page).to have_content(
        "What is the best number for you to receive text messages?",
      )
      click_on "Next"
    end

    on_page "Contact Information & Followup" do
      expect(page).to have_content(
        "What is the best email address at which to contact you?",
      )
      click_on "Next"
    end

    on_page "Contact Information & Followup" do
      expect(page).to have_content(
        "Provide the Social Security Numbers and Dates of Birth "\
        "for your household members if you’re ready",
      )
      click_on "Yes"
    end

    on_page "Contact Information & Followup" do
      expect(page).to have_content(
        "Tell us your Social Security Number and Date of Birth",
      )
      enter_dob_and_ssn(display_name: "Jessie Tester", ssn: "123456789")
      enter_dob_and_ssn(display_name: "Christa Tester", ssn: "011100000")

      click_on "Next"
    end

    on_page "Submit Paperwork & Sign" do
      expect(page).to have_content(
        "Lastly, we need to review your paperwork and get your signature.",
      )
      click_on "Next"
    end

    on_pages "Documents" do
      expect(page).to have_content(
        "Upload some paperwork if you can right now.",
      )
      click_on "Submit paperwork now"
      upload_paperwork
      click_on "Done uploading paperwork"
    end

    on_page "Rights and Responsibilities" do
      expect(page).to have_content(
        "Before you finish, read and agree to the legal terms.",
      )
      choose "I agree"
      click_on "Next"
    end

    on_page "Sign and Submit" do
      fill_in "Sign by typing your full legal name", with: "Jessie Tester"
      click_on "Sign and submit"
    end

    on_pages "Application Submitted" do
      expect(page).to have_content(
        "Your application has been successfully submitted",
      )
    end
  end

  def upload_paperwork
    add_paperwork_photo "https://example.com/images/drivers_license.jpg"
    add_paperwork_photo "https://example.com/images/proof_of_income.jpg"
  end

  def add_paperwork_photo(url)
    input = %(<input type="hidden" name="step[paperwork][]" value="#{url}">)
    page.execute_script(
      <<~JAVASCRIPT
        document.querySelector('[data-uploadables-form]').
          insertAdjacentHTML('beforeend', '#{input}')
      JAVASCRIPT
    )
  end
end
