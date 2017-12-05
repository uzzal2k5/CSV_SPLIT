#!/usr/bin/perl -w
use strict;
use warnings;
#print "\nEnter your DB file[CSV] format with tab:";
my $datafile='data.txt';
#print "\nEnter Template:";
my $template='localhost.cfg';
print "\nEnter First Param [e,g: ip address]:";
my $_ip=<STDIN>;
print "\nEnter Second Param [e,g: Host Name]";
my $_host=<STDIN>;
#my $new_line='\n';
# my $blank='';
data_file($datafile);
# To read a data file and split() theminto variable
sub data_file{
	my ($datafile)=@_;
	open(my $fh,'<:',$datafile) or die "Could not get '$datafile' $!";
	while(my $row = <$fh>){
		chomp $row;
	if($row eq ''){ # If row  is balank on no data 
               print "\nYour Task is Complete!\n";
	      	exit;
               }else{

	unless(!'\n'){
		my ($ip, $host)=split('\t',$row);

		my $data = read_file($template);
		print $ip;
		print $data;
		$data =~ s/$_ip/$ip/g;
		$data=~ s/$_host/$host/g;
		my ($filename)="$host.cfg";
		write_file($filename,$data); # Create new file hera based on data file 
		print $data;	
		}
	}

}
	close($fh);
	return;
	}

# Read a template File to create .cfg
sub read_file{
	my ($template)= @_;
	open my $in, '<:',$template or die "Could not open '$template' for reading. $! ";
	local $/=undef;
	my $all = <$in>;
	close $in;
	return $all; 
	}

# Write to Create a .cfg 
sub write_file{
	my ($filename, $content) = @_;
 	open my $out,'>:', $filename or die "Could not open '$filename' for writing $!";
 	print $out $content;
 	close $out;
 	return;
	}																					
