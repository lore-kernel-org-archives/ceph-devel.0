From: Travis Rhoden <trhoden@redhat.com>
Subject: Re: Moving away from Yum/DNF repo priorities for Ceph and ceph-deploy
Date: Thu, 23 Jul 2015 22:24:18 -0700
Message-ID: <1BAB05C7-2E65-4070-AD5C-745590158C63@redhat.com>
References: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com> <CAFdRU71pu3npaQcUfVmOdraeLqmutyoREyKNj+aQ5bQuhGfKsw@mail.gmail.com> <5AC93C7F-1B2F-4103-AC91-4DC11E748DFB@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbbGXFYT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2015 01:24:19 -0400
In-Reply-To: <5AC93C7F-1B2F-4103-AC91-4DC11E748DFB@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shinobu@linux.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>, yum@lists.baseurl.org

<sorry for double-send =E2=80=94 forgot to make plain text for ceph-dev=
el>

Hi Shinobu,

Thanks for the response.


> On Jul 23, 2015, at 5:05 PM, Shinobu Kinjo <shinobu.kj@gmail.com> wro=
te:
>=20
> Hi Travis,
>=20
> Is this that you are talking about:
>=20
> ``dnf [options] list obsoletes [<package-name-specs>...]``
> ``dnf [options] repository-packages <repoid> info obsoletes [<package=
-name-spec>...]``
> ``dnf [options] repository-packages <repoid> list obsoletes [<package=
-name-spec>...]``

Partially.  Those queries either list packages already installed that a=
re obsoleted by packages available in any enabled repos, or list packag=
es in the repos that obsolete packages that are already installed (the =
man page says reposository-packages info/list are the same thing?).  Su=
ch commands would show the issue I am trying to solve - namely that for=
 certain releases of Ceph, older packages of Ceph from EPEL take priori=
ty over newer ones, due to package obsoletions.

The exact scenario we hit was a problem most commonly on CentOS - I hav=
e not confirmed whether it is an issue in Fedora.  But here is a specif=
ic example.  Starting with a CentOS 7 machine that has EPEL installed/e=
nabled, and Ceph rpm-firefly enabled by default, and the yum priorities=
 plugin installed (with check_obsoletes=3D0):

# yum info --disablerepo=3DCeph --disablerepo=3Depel --disableplugin=3D=
priorities ceph
Error: No matching Packages to list
^ Expected - ceph packages aren=E2=80=99t reachable

# yum info --disablerepo=3DCeph --disableplugin=3Dpriorities ceph
Available Packages
Name        : ceph
Arch        : x86_64
Epoch       : 1
Version     : 0.80.7
Release     : 0.4.el7
^ EPEL includes Ceph 0.80.7.

# yum info --disablerepo=3Depel --disableplugin=3Dpriorities ceph
Available Packages
Name        : ceph
Arch        : x86_64
Epoch       : 1
Version     : 0.80.10
^ Ceph repos have 0.80.10.

# yum info --disableplugin=3Dpriorities ceph
Available Packages
Name        : ceph
Arch        : x86_64
Epoch       : 1
Version     : 0.80.7
^ With priorities disabled, but both repos enabled, yum resolves the lo=
wer version number, 0.80.7 from EPEL.

# yum info ceph
24 packages excluded due to repository priority protections
Available Packages
Name        : ceph
Arch        : x86_64
Version     : 0.80.10
^ With priorities enabled, we now get 0.80.10.  The ceph.repo file has =
priority=3D1 in it.

Great!  With priorities enabled, we now see 0.80.10.  Let=E2=80=99s ins=
tall:

# yum install -v ceph
=E2=80=A6.
=E2=80=A6.
Error: Package: 1:python-rbd-0.80.7-2.el7.x86_64 (base)
           Requires: librbd1 =3D 1:0.80.7-2.el7
           Available: librbd1-0.80-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80-0.el7
           Available: librbd1-0.80.1-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.1-0.el7
           Available: librbd1-0.80.3-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.3-0.el7
           Available: librbd1-0.80.4-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.4-0.el7
           Available: librbd1-0.80.5-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.5-0.el7
           Available: librbd1-0.80.6-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.6-0.el7
           Available: librbd1-0.80.7-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.7-0.el7
           Available: librbd1-0.80.8-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.8-0.el7
           Available: librbd1-0.80.9-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.9-0.el7
           Installing: librbd1-0.80.10-0.el7.x86_64 (Ceph)
               librbd1 =3D 0.80.10-0.el7


So why did the install fail?  See [1] for full output, but the short ve=
rsion is at this step:

--> Processing Dependency: python-ceph for package: ceph-0.80.10-0.el7.=
x86_64
Searching pkgSack for dep: python-ceph
Not Updating Package that is obsoleted: python-ceph-0.80.10-0.el7.x86_6=
4
TSINFO: Marking 1:python-ceph-compat-0.80.7-0.4.el7.x86_64 as install f=
or ceph-0.80.10-0.el7.x86_64

When yum looks for python-ceph, it sees that it has been marked as obso=
leted by python-ceph-compat, which is available from EPEL.  Pulling in =
that python-ceph-compat causes all kinds of problems and the install ul=
timately fails.  The solution is set check_obsoletes =3D 1 in /etc/yum/=
pluginconf.d/priorities.conf, which forces Yum to override the the obso=
letion of a package from a lower priority repo.  This is what we are do=
ing today.

This problem still exists for our Firefly and Giant packages, even thou=
gh the EPEL package added versions to their obsoletes over 4 months ago=
: [2].  It is this =E2=80=9Ccheck_obsoletes=E2=80=9D behavior that I am=
 unsure of in DNF.  Granted, I haven=E2=80=99t tried it.  It may be tha=
t it will read the same config file, even (/etc/yum/pluginconf.d/priori=
ties.conf).  I=E2=80=99d have to install DNF in a Fedora 20 VM (the las=
t Fedora we built production packages of Firefly on) to see how DNF beh=
aves here.

Even if check_obsoletes wasn=E2=80=99t a consideration, I=E2=80=99d rea=
lly like to get away from setting priority values in repo files and ins=
talling an additional plugin for Yum to make things work.  It feels lik=
e it is using magic numbers to make things resolve correctly.  Maybe th=
is is entirely invalid, since having the priorities plugin rolled into =
DNF gives it an air of legitimacy.  I wanted to reach out to the Ceph c=
ommunity to see if a two phased install with a disabled-by-default EPEL=
 made sense.  I also wanted to see if any Yum/DNF experts said I was cr=
azy. :)

As the yum examples in here show, having EPEL enabled can lead to unexp=
ected resolutions. It is not immediately obvious to most people why 0.8=
0.7 from EPEL would be picked by Yum instead of 0.80.10 that=E2=80=99s =
on ceph.com.  And even when the resolution of a top-level package produ=
ces the correction version, that doesn=E2=80=99t mean that all the depe=
ndencies are going to resolve well.

[1] http://fpaste.org/247700/14377137/
[2] http://pkgs.fedoraproject.org/cgit/ceph.git/commit/?h=3Depel7&id=3D=
c9a91bad2f3c3083b8dad7a1feb9f84994c2f35c

 - Travis

>=20
>  - Shinobu
>=20
>=20
> On Fri, Jul 24, 2015 at 8:12 AM, Travis Rhoden <trhoden@redhat.com> w=
rote:
>> HI Everyone,
>>=20
>> I=E2=80=99m working on ways to improve Ceph installation with ceph-d=
eploy, and a common hurdle we have hit involves dependency issues betwe=
en ceph.com hosted RPM repos, and packages within EPEL.  For a while we=
 were able to managed this with the priorities plugin, but then EPEL sh=
ipped packages that included changes that weren=E2=80=99t available on =
the ceph.com packages, and the EPEL packages =E2=80=9Cobsoleted=E2=80=9D=
 the ceph.com ones.  This caused EPEL packages to take priority over ce=
ph.com packages even when ceph.com packages had greater version numbers=
=2E  The solution to this was to enable the =E2=80=9Ccheck_obsoletes=E2=
=80=9D feature of the priorities plugin.  That=E2=80=99s where we are t=
oday.
>>=20
>> Recently when working with DNF, I observed that the priorities featu=
re got pulled natively into DNF, but I cannot find anything about wheth=
er =E2=80=9Ccheck_obsoletes=E2=80=9D is still necessary or even an opti=
on. Regardless, I would like move away from this workflow as it is gene=
rally seen as poor. [1] [2]
>>=20
>> What I=E2=80=99d like to propose instead of ceph-deploy=E2=80=99s cu=
rrent workflow is to:
>>=20
>> (1) install epel-release on nodes that need it
>> (2) disable EPEL by default (using yum-config-manager)
>> (3) When installing Ceph, break the install into two parts
>> (3)(a) Explicitly install Ceph=E2=80=99s dependencies from EPEL by n=
ame, using yum =E2=80=94enablerepo=3Depel
>> (3)(b) Proceed normally with Ceph installation, but adding a =E2=80=94=
disablerepo=3Depel flag as well
>>=20
>> Note: the disabling of EPEL in 3b seems redundant with 2, but it wou=
ld cover cases when a user/admin chooses to enable EPEL by default.  We=
 are mostly concerned with nodes that are dedicated to Ceph and therefo=
re ceph-deploy is free to do things like disabling EPEL, but that=E2=80=
=99s certainly not always ideal.  We could disable it by default *only*=
 if we were the ones to install it.  If it=E2=80=99s already there, we =
leave it along but then still do our two-phase install and explicitly d=
isable it when doing the second phase of install.
>>=20
>> I think this workflow would allow us to no longer need to use repo p=
riorities, but I might be missing something.  A secondary motive to thi=
s is to end up with systems that EPEL disabled by default because it ha=
s caused issues with Calamari, where EPEL has newer packages of certain=
 things than what gets installed initially and then breaks Calamari.  H=
aving EPEL disabled will prevent that, and will also prevent things lik=
e =E2=80=9Cyum update=E2=80=9D from breaking things.
>>=20
>> Potential downsides I see are what happens when there are updates in=
 EPEL that we want, say for a security fix?
>>=20
>>  - Travis
>>=20
>>=20
>> [1] http://wiki.centos.org/PackageManagement/Yum/Priorities#head-38b=
91468cc607d0243f463489c2334bf40bfaaee
>> [2] http://wiki.centos.org/PackageManagement/Yum/Priorities#head-660=
1a4937d4b099e6d46eea0bdb54241d51c7277
>=20
>=20
>=20
> --=20
>>=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Life w/ Linux
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
