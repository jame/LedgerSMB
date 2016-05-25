#!perl


requires 'perl', '5.10.1';

requires 'App::LedgerSMB::Admin', '0.04';
requires 'CGI::Emulate::PSGI';
requires 'CGI::Simple';
requires 'Config::IniFiles';
requires 'DBD::Pg', '3.3.0';
requires 'DBI';
requires 'Data::Dumper';
requires 'DateTime';
requires 'DateTime::Format::Strptime';
requires 'Digest::MD5';
requires 'File::MimeInfo';
requires 'JSON';
requires 'Locale::Maketext';
requires 'Locale::Maketext::Lexicon', '0.62';
requires 'Log::Log4perl';
requires 'MIME::Base64';
requires 'MIME::Lite';
requires 'Math::BigFloat';
requires 'Moose';
requires 'Number::Format';
requires 'PGObject';
requires 'PGObject::Simple';
requires 'PGObject::Simple::Role';
requires 'PGObject::Type::BigFloat';
requires 'PGObject::Type::DateTime';
requires 'PGObject::Util::DBMethod';
requires 'PGObject::Util::DBAdmin', '0.08';
requires 'Plack::App::File';
requires 'Plack::Builder';
requires 'Template', '2.14';
requires 'namespace::autoclean';

recommends 'Math::BigInt::GMP';

feature 'rest', "RESTful Web Service XML support" =>
    sub {
        requires "XML::Simple";
};

feature 'starman', "Standalone Server w/Starman" =>
    sub {
        requires "Starman";
};

feature 'latex-pdf-images',
    "Size detection for images for embedding in LaTeX templates" =>
    sub {
        requires "Image::Size";
};

feature 'edi', "X12 EDI support" =>
    sub {
        requires 'X12::Parser';
        requires 'Path::Class';
        requires 'Module::Runtime';
};

feature 'latex-pdf-ps', "PDF and PostScript output" =>
    sub {
        requires 'LaTeX::Driver', '0.300.2';
        requires 'Template::Plugin::Latex';
        requires 'TeX::Encode';
};

feature 'openoffice', "OpenOffice.org output" =>
    sub {
        requires "XML::Twig";
        requires "OpenOffice::OODoc";
};

# Even with cpanm --notest, 'test' target of --installdeps
# will be included, so put our testing requirements in develop...
on 'develop' => sub {
    requires 'Test::More';
    requires 'Test::Trap';
    requires 'Test::Exception';
    requires 'Test::BDD::Cucumber', '0.49';
    requires 'Perl::Critic';
    requires 'Selenium::Remote::Driver';
};
