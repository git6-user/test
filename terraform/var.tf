variable "list" {
    description = "value of ami"
    type        = list(string)
    default     = ["t2.micro", "t3.micro"]  
}
variable "map" {
    description = "value of ami"
    type        = map(string)
    default     = {
        dev = "t2.micro"
        prod = "t3.micro"
    }
  
}