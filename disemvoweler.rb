string = "Once upon a midnight dreary, while I pondered, weak and weary"
p string.delete("aeiou").delete(" ").delete(",")
p string.delete("^aeiou").delete(" ")
