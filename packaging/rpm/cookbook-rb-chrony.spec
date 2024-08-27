Name: cookbook-rb-chrony
Version: %{__version}
Release: %{__release}%{?dist}
BuildArch: noarch
Summary: Chrony cookbook to install and configure it in redborder environments

License: AGPL 3.0
URL: https://github.com/redBorder/cookbook-chrony
Source0: %{name}-%{version}.tar.gz

%description
%{summary}

%prep
%setup -qn %{name}-%{version}

%build

%install
mkdir -p %{buildroot}/var/chef/cookbooks/rb-chrony
cp -f -r  resources/* %{buildroot}/var/chef/cookbooks/rb-chrony
chmod -R 0755 %{buildroot}/var/chef/cookbooks/rb-chrony
install -D -m 0644 README.md %{buildroot}/var/chef/cookbooks/rb-chrony/README.md

%pre

%post
case "$1" in
  1)
    # This is an initial install.
    :
  ;;
  2)
    # This is an upgrade.
    su - -s /bin/bash -c 'source /etc/profile && rvm gemset use default && env knife cookbook upload rb-chrony'
  ;;
esac

%files
%defattr(0755,root,root)
/var/chef/cookbooks/rb-chrony
%defattr(0644,root,root)
/var/chef/cookbooks/rb-chrony/README.md


%doc

%changelog
* Fri Jul 29 2024 Miguel Álvarez <malvarez@redborder.com>
- first spec version
