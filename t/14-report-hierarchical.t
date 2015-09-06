#!/usr/bin/perl

use Test::More (tests => 5);
use strict;
use warnings;

use Data::Dumper;

use LedgerSMB::Report::Hierarchical;

my $report = LedgerSMB::Report::Hierarchical->new;

# all we need to test now is the addition of comparisons, the rest
# requires a database connection

my $col_id = $report->cheads->map_path([1]);
my $row1_id = $report->rheads->map_path([1]);
my $row2_id = $report->rheads->map_path([2]);

$report->cell_value($row1_id, $col_id, 15);
$report->cell_value($row2_id, $col_id, 3);
$report->rheads->id_props($row1_id, { test => "ok" });

is_deeply($report->cells, {'1' => { '1' => 15 },
                           '2' => { '1' => 3 },
          }, 'report has 1 column and 2 rows, with 2 values');

my $compared = LedgerSMB::Report::Hierarchical->new;

# all we need to test now is the addition of comparisons, the rest
# requires a database connection

$col_id = $compared->cheads->map_path([1]);
$row1_id = $compared->rheads->map_path([1]);
$row2_id = $compared->rheads->map_path([2]);

$compared->cell_value($row1_id, $col_id, 2);
$compared->cell_value($row2_id, $col_id, 7);
$compared->rheads->id_props($row1_id, { test => "ok2" });
$compared->rheads->id_props($row2_id, { test => "ok2" });

is_deeply($compared->cells, {'1' => { '1' => 2 },
                             '2' => { '1' => 7 },
          }, 'comparison has 1 column and 2 rows, with 2 values');

$report->add_comparison($compared, col_path_prefix => [ 'comp1' ]);

is_deeply($report->cells, {'1' => { '1' => 15,
                                    '3' => 2 },
                           '2' => { '1' => 3,
                                    '3' => 7 },
          }, 'report after merge has 2 columns');
is_deeply($report->rheads->id_props('1'), { test => "ok" },
          'props of row 1 have not been overwritten');
is_deeply($report->rheads->id_props('2'), { test => "ok2" },
          'props of row 2 have been merged from the comparison');


