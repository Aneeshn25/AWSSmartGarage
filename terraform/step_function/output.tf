#OUTPUT arn of the state machine
output "arn" {
  value = "${aws_sfn_state_machine.sfn_state_machine.id}"
}