defmodule DebtManager.Mailer do
  use Mailgun.Client,
    domain: Application.fetch_env!(:debt_manager, :mailgun_domain),
    key: Application.fetch_env!(:debt_manager, :mailgun_key)

  @from "info@debtmanager.app"

  def send_urge_emails(creditor_name, emails_list) do
    res_list =
      for address <- emails_list do
        case send_email(
               to: address,
               from: @from,
               subject: "Ask from #{creditor_name}",
               text:
                 "Hey mate! Could you please pay back these few dolars you owe me?\nI would really appreciate that. Thanks in advance!"
             ) do
          {:ok, _} ->
            :ok

          {:error, _, _} ->
            :error
        end
      end

    if Enum.all?(res_list, &(&1 == :ok)) do
      :ok
    else
      :error
    end
  end
end
