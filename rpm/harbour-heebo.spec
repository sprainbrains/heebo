Name:       harbour-heebo

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}

Summary:    Heebo for jolla
Version:    0.3.0
Release:    0
Group:      Qt/Qt
License:    GPLv3
URL:        https://github.com/kimmoli/heebo
Source0:    %{name}-%{version}.tar.bz2
Requires:   qt5-qtdeclarative-import-particles2
Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(sailfishapp) >= 0.0.10
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

%description
Simple and addictive Match 3 game with quirky characters.

Categories:
  - Game
Icon: https://raw.githubusercontent.com/kimmoli/heebo/sailfishonly/harbour-heebo.png

%prep
%setup -q -n %{name}-%{version}

%build

%qtc_qmake5 

%qtc_make %{?_smp_mflags}

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_datadir}/%{name}/qml/
%{_datadir}/%{name}/data/
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
