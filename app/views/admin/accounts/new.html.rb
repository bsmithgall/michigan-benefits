class Views::Admin::Accounts::New < Views::Base
  def content
    h1("New account")

    render 'form'
text " "
    link_to 'Back', admin_accounts_path
  end
end