FactoryGirl.define do
  factory :book do
    title FFaker::Book.title
    price 15
    quantity 10
    year 2017
    dimensions H: 2.4, W: 1.3, D: 0.6
    materials 'paper, brick, hardcove'
    description FFaker::HealthcareIpsum.paragraph
  end

  trait :long_description do
    description 'Morbidity credentialing harge grievance policy
                year schedule of benefits and exclusions.
                Lifetime maximum free-look period underwriting
                full-time student appeal pre-certification.
                Eaps health care provider first dollar coverage
                pre-certification IPA. Pregnancy care claim referral
                ambulatory care coordinated care medicare supplement
                lifetime maximum. Independent practice associations
                appeal ancillary services self administered gag rule laws.'
  end
end
