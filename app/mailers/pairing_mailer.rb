class PairingMailer < ApplicationMailer
  def creation_confirmation(pairing)
    @pairing = pairing

    mail(
      to:       "lorenzofermi@gmail.com",
      subject:  "You're going to the movies!"
    )
  end
end
