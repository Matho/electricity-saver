# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

## Network
network = Network.find_or_initialize_by( title: 'Chaty Kalnica Network' )
network.assign_attributes({
                            description: '',
                            active: true
                          })
network.save!

## Smart Plug Device
smart_plug_device = SmartPlugDevice.find_or_initialize_by(title: 'Zasuvka 1090')
smart_plug_device.assign_attributes({
                                      api_title: 'switch.smart_zasuvka_1090',
                                      api_status_url: 'http://10.0.2.152:8123/api/states/switch.smart_zasuvka_1090',
                                      api_turn_on_url: 'http://10.0.2.152:8123/api/services/switch/turn_on',
                                      api_turn_off_url: 'http://10.0.2.152:8123/api/services/switch/turn_off',
                                      energy_price_for_kwh: 0.23,
                                      avg_energy_consumption: 50,
                                      token: 'token',
                                      off_timeout: 60,
                                      network_id: network.id
                                    })
smart_plug_device.save!

## Endpoint Devices
endpoint_device_1 = EndpointDevice.find_or_initialize_by(title: 'Wifi router')
endpoint_device_1.assign_attributes({
                                      ip_address: '10.0.2.1',
                                      active_monitoring: true,
                                      network_id: network.id
                                    })
endpoint_device_1.save!

endpoint_device_2 = EndpointDevice.find_or_initialize_by(title: 'Chaty AP1')
endpoint_device_2.assign_attributes({
                                      ip_address: '10.0.3.10',
                                      active_monitoring: false,
                                      network_id: network.id
                                    })
endpoint_device_2.save!

endpoint_device_3 = EndpointDevice.find_or_initialize_by(title: 'Chaty ST1')
endpoint_device_3.assign_attributes({
                                      ip_address: '10.0.3.11',
                                      active_monitoring: true,
                                      network_id: network.id
                                    })
endpoint_device_3.save!

## Custom rules
rule_on = Rule.find_or_initialize_by({smart_plug_device_id: smart_plug_device.id, action: :turn_on})
rule_on.assign_attributes({
                                      title: 'rule #1',
                                      cron_monday: '*/10 * * * *',
                                      cron_tuesday: '*/5 * * * *',
                                      network_id: network.id
                                    })
rule_on.save!

rule_off = Rule.find_or_initialize_by({smart_plug_device_id: smart_plug_device.id, action: :turn_off})
rule_off.assign_attributes({
                            title: 'rule #2',
                            cron_monday: '* 22 * * *',
                            cron_tuesday: '* 22 * * *',
                            network_id: network.id
                          })
rule_off.save!

## Ping Stats
PingStatJob.perform_now

## Plug states
plug_state1 = CurrentState.find_or_initialize_by({created_at: '2022-12-24 16:48:43 +0100'})
plug_state1.assign_attributes({
                                state: :turned_on,
                                smart_plug_device_id: smart_plug_device.id,
                                network_id: network.id
                              })
plug_state1.save!

plug_state2 = CurrentState.find_or_initialize_by({created_at: '2022-12-24 16:49:56 +0100'})
plug_state2.assign_attributes({
                                state: :turned_off,
                                smart_plug_device_id: smart_plug_device.id,
                                network_id: network.id
                              })
plug_state2.save!

plug_state3 = CurrentState.find_or_initialize_by({created_at: '2022-12-24 16:59:10 +0100'})
plug_state3.assign_attributes({
                                state: :turned_on,
                                smart_plug_device_id: smart_plug_device.id,
                                network_id: network.id
                              })
plug_state3.save!

plug_state4 = CurrentState.find_or_initialize_by({created_at: '2022-12-25 19:15:22 +0100'})
plug_state4.assign_attributes({
                                state: :unknown,
                                smart_plug_device_id: smart_plug_device.id,
                                network_id: network.id
                              })
plug_state4.save!

plug_state5 = CurrentState.find_or_initialize_by({created_at: '2022-12-25 19:16:24 +0100'})
plug_state5.assign_attributes({
                                state: :turned_off,
                                smart_plug_device_id: smart_plug_device.id,
                                network_id: network.id
                              })
plug_state5.save!

plug_state6 = CurrentState.find_or_initialize_by({created_at: '2022-12-25 19:17:49 +0100'})
plug_state6.assign_attributes({
                                state: :turned_off,
                                smart_plug_device_id: smart_plug_device.id,
                                network_id: network.id
                              })
plug_state6.save!

plug_state7 = CurrentState.find_or_initialize_by({created_at: '2022-12-26 15:02:51 +0100'})
plug_state7.assign_attributes({
                                state: :unknown,
                                smart_plug_device_id: smart_plug_device.id,
                                network_id: network.id
                              })
plug_state7.save!

## Saved energies
SavedEnergyRecomputeJob.perform_now

