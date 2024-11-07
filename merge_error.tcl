load -run test_error
report_metrics -detail -out coverage_error.rpt  -metrics all -source on
merge test_error -out merge_wre -initial_model test_write_read
load -run merge_wre
report_metrics -detail -out coverage_wre.rpt -metrics all -source on
# quit
