defmodule DebtManager.Mailer do
  use Mailgun.Client,
    domain: Application.fetch_env!(:debt_manager, :mailgun_domain),
    key: Application.fetch_env!(:debt_manager, :mailgun_key)

  @from "info@debtmanager.app"

  def send_urge_email(creditor_name, debtor_address_email) do
    IO.puts(creditor_name)
    IO.puts(debtor_address_email)

    send_email(
      to: debtor_address_email,
      from: @from,
      subject: "Ask from #{creditor_name}",
      text:
        "Hey mate! Could you please pay back these few dolars you owe me?\nI would really appreciate that. Thanks in advance!"
    )
  end
end
