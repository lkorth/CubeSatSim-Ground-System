# Script Runner test script
cmd("AMSAT EXAMPLE")
wait_check("AMSAT STATUS BOOL == 'FALSE'", 5)
