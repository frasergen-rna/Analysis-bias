#! /usr/bin/perl -w
use strict;

my $file=shift;


my @snp_site=();
my $allele1_count=0;
my $allele2_count=0;

open (OUT,">$file.filter_snp");

open (IN,"<$file") or die "can not open file $file";
while (<IN>) {
	chomp;
	if (/^##/) {
		if ($.!=1) {
			my $all_snp=join(";",@snp_site);
			if (scalar(@snp_site)==0) {
				$all_snp="-";
			}
			print "$all_snp\t$allele1_count\t$allele2_count\n";
		}	
		print "$_\t";
		
		@snp_site=();
		$allele1_count=0;
		$allele2_count=0;
	}
	else {
		my @line=split("\t",$_);
		
		my %base_count;
		
		$base_count{'A'}=$line[5];
		$base_count{'T'}=$line[6];
		$base_count{'C'}=$line[7];
		$base_count{'G'}=$line[8];
		
		if ($line[2]!~/[ATCG]/ || $line[3]!~/[ATCG]/) {
			next;
		}
		
		if ( $base_count{$line[2]}+$base_count{$line[3]}<10 || ($base_count{$line[2]}+$base_count{$line[3]})/$line[4]<0.95 ) {
			print OUT "$_\n";
		}
		else {
			push (@snp_site,$line[0].":".$line[1].":".$base_count{$line[2]}.$line[2].",".$base_count{$line[3]}.$line[3]);
			$allele1_count+=$base_count{$line[2]};
			$allele2_count+=$base_count{$line[3]};
		}
		
	}
}
close IN;

my $last_all_snp=join(";",@snp_site);
if (scalar(@snp_site)==0) {
	$last_all_snp="-";
}

print "$last_all_snp\t$allele1_count\t$allele2_count\n";
