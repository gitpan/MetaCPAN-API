
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'Test::Fatal' => '0',
    'Test::More' => '0',
    'Test::TinyMocker' => '0'
  },
  'configure_requires' => {
    'ExtUtils::MakeMaker' => '6.30',
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'A comprehensive, DWIM-featured API to MetaCPAN',
  'dist_author' => [
    'Sawyer X <xsawyerx@cpan.org>'
  ],
  'dist_name' => 'MetaCPAN-API',
  'dist_version' => '0.34',
  'license' => 'perl',
  'module_name' => 'MetaCPAN::API',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Any::Moose' => '0',
    'Carp' => '0',
    'HTTP::Tiny' => '0',
    'JSON' => '0',
    'Try::Tiny' => '0',
    'URI::Escape' => '0'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
