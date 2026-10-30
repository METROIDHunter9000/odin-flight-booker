# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
["RDU", "RIC", "ZRH", "SHE", "AAL", "SEX", "SSH", "KRR", "WRO", "TYL"].each do |code|
  Airport.find_or_create_by!(code: code)
end

rdu = Airport.find_by(code: "RDU")
ric = Airport.find_by(code: "RIC")
zrh = Airport.find_by(code: "ZRH")
aal = Airport.find_by(code: "AAL")
she = Airport.find_by(code: "SHE")
wro = Airport.find_by(code: "WRO")
tyl = Airport.find_by(code: "TYL")
sex = Airport.find_by(code: "SEX")
ssh = Airport.find_by(code: "SSH")
krr = Airport.find_by(code: "KRR")

[
  {
    origin: rdu,
    destination: aal,
    departure: '2026-10-10 22:15:00',
    arrival: '2026-10-11 04:30:00'
  },
  {
    origin: zrh,
    destination: aal,
    departure: '2026-04-30 05:00:00',
    arrival: '2026-04-30 10:45:00'
  },
  {
    origin: tyl,
    destination: aal,
    departure: '2026-10-20 11:30:00',
    arrival: '2026-10-21 00:15:00'
  },
  {
    origin: aal,
    destination: tyl,
    departure: '2026-10-23 15:45:00',
    arrival: '2026-10-23 18:15:00'
  },
  {
    origin: zrh,
    destination: sex,
    departure: '2026-10-11 12:00:00',
    arrival: '2026-10-11 13:30:00'
  },
  {
    origin: sex,
    destination: ssh,
    departure: '2026-10-30 01:00:00',
    arrival: '2026-10-30 09:30:00'
  },
  {
    origin: ssh,
    destination: ric,
    departure: '2026-10-28 01:00:00',
    arrival: '2026-10-28 09:30:00'
  },
  {
    origin: ssh,
    destination: tyl,
    departure: '2026-10-28 02:00:00',
    arrival: '2026-10-28 08:30:00'
  }
].each do |flight|
  Flight.find_or_create_by!(flight)
end

aal_to_tyl = Flight.find_or_create_by!({
  origin: aal,
  destination: tyl,
  departure: '2026-10-22 15:45:00',
  arrival: '2026-10-22 18:15:00'
})
zrh_to_sex = Flight.find_or_create_by!({
  origin: zrh,
  destination: sex,
  departure: '2026-10-14 12:00:00',
  arrival: '2026-10-14 13:30:00'
})
sex_to_ssh = Flight.find_or_create_by!({
  origin: sex,
  destination: ssh,
  departure: '2026-10-03 01:00:00',
  arrival: '2026-10-03 09:30:00'
})
ssh_to_sex = Flight.find_or_create_by!({
  origin: ssh,
  destination: sex,
  departure: '2026-10-24 01:00:00',
  arrival: '2026-10-24 09:30:00'
})
