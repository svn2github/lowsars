Name: lowsars
Summary: Lightweight OI Wonderful Scroing and Ranking System
Summary(zh): 轻量级OI奇妙的评测系统
Version: 0.2.0
Release: 0
BuildArch: noarch
Source0: %{name}-%{version}.tar.gz
License: GPL
Vendor: Lowsars Developing Team
URL: http://lowsars.sourceforge.net
Group: Development/Tools
Autoreq: 0
Requires: bash >= 3.0, libxslt-proc >= 1.1, bc >= 1.0, gettext-base >= 0.12
BuildRequires: gettext >= 0.12
%description
Lowsars is short for "Lightweight OI Wonderful Scoring and Ranking System".
It is a GPL software used for testing Olympiad in Informatics (OI) programs,
and give the scores and rankings.
Lowsars is written in bash and xslt, and mainly works on GNU/Linux.
Recommended Packages: gcc >= 3.3, g++ >= 3.3, fpc >= 2.0.0, libxslt-proc >= 1.1
%description -l zh
Lowsars是“轻量级OI奇妙的评测系统”的简称。它是用来测试信息学奥林匹克竞赛(OI)程序，并能够给出成绩和排名的GPL自由软件。
Lowsars 由 bash 和 xslt 写成，主要在GNU/Linux系统上运行。
建议安装: gcc >= 3.3, g++ >= 3.3, fpc >= 2.0.0, libxslt-proc >= 1.1
%prep
%setup
%build
./configure --prefix=/usr
make
%install
make install DESTDIR=$RPM_BUILD_ROOT
%files
%defattr(-,root,root)
%config /bin/bash_by_lowsars
/usr/bin/lowsars
/usr/bin/lowsars-test
/usr/bin/lowsars-cena
/usr/share/lowsars
/usr/share/locale/zh_CN/LC_MESSAGES/lowsars.mo
%doc /usr/share/doc/lowsars
%changelog
* Sat Apr 26 2008 Liu Sizhuang <oldherl@gmail.com>
- intitial rpm. version 0.2.0

