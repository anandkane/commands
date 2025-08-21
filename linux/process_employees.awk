#!/usr/bin/awk -f

BEGIN {
FS = ","
print "Prcessing employees..."
}

NR == 1 {
	printf("%-15s%-15s%-15s%-15s\n", $1, $2, $3, "Salary bracket")
}

NR > 1 {
	bracket = $4 > 70000 ? "High" : "Normal"
	printf("%-15s%-15s%-15s%-15s\n", $1, $2, $3, bracket)
}
