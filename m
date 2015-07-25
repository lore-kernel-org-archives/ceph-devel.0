From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Moving away from Yum/DNF repo priorities for Ceph and ceph-deploy
Date: Fri, 24 Jul 2015 19:06:46 -0500
Message-ID: <55B2D316.9020204@redhat.com>
References: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbbGYAGt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Jul 2015 20:06:49 -0400
In-Reply-To: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, yum@lists.baseurl.org

On 07/23/2015 06:12 PM, Travis Rhoden wrote:
> HI Everyone,
>
> I=E2=80=99m working on ways to improve Ceph installation with ceph-de=
ploy, and a common hurdle we have hit involves dependency issues betwee=
n ceph.com hosted RPM repos, and packages within EPEL.  For a while we =
were able to managed this with the priorities plugin, but then EPEL shi=
pped packages that included changes that weren=E2=80=99t available on t=
he ceph.com packages, and the EPEL packages =E2=80=9Cobsoleted=E2=80=9D=
 the ceph.com ones.  This caused EPEL packages to take priority over ce=
ph.com packages even when ceph.com packages had greater version numbers=
=2E  The solution to this was to enable the =E2=80=9Ccheck_obsoletes=E2=
=80=9D feature of the priorities plugin.  That=E2=80=99s where we are t=
oday.
>
> Recently when working with DNF, I observed that the priorities featur=
e got pulled natively into DNF, but I cannot find anything about whethe=
r =E2=80=9Ccheck_obsoletes=E2=80=9D is still necessary or even an optio=
n. Regardless, I would like move away from this workflow as it is gener=
ally seen as poor. [1] [2]
>
> What I=E2=80=99d like to propose instead of ceph-deploy=E2=80=99s cur=
rent workflow is to:
>
> (1) install epel-release on nodes that need it
> (2) disable EPEL by default (using yum-config-manager)
> (3) When installing Ceph, break the install into two parts
> (3)(a) Explicitly install Ceph=E2=80=99s dependencies from EPEL by na=
me, using yum =E2=80=94enablerepo=3Depel
> (3)(b) Proceed normally with Ceph installation, but adding a =E2=80=94=
disablerepo=3Depel flag as well
>
> Note: the disabling of EPEL in 3b seems redundant with 2, but it woul=
d cover cases when a user/admin chooses to enable EPEL by default.  We =
are mostly concerned with nodes that are dedicated to Ceph and therefor=
e ceph-deploy is free to do things like disabling EPEL, but that=E2=80=99=
s certainly not always ideal.  We could disable it by default *only* if=
 we were the ones to install it.  If it=E2=80=99s already there, we lea=
ve it along but then still do our two-phase install and explicitly disa=
ble it when doing the second phase of install.
>
> I think this workflow would allow us to no longer need to use repo pr=
iorities, but I might be missing something.  A secondary motive to this=
 is to end up with systems that EPEL disabled by default because it has=
 caused issues with Calamari, where EPEL has newer packages of certain =
things than what gets installed initially and then breaks Calamari.  Ha=
ving EPEL disabled will prevent that, and will also prevent things like=
 =E2=80=9Cyum update=E2=80=9D from breaking things.
>
> Potential downsides I see are what happens when there are updates in =
EPEL that we want, say for a security fix?

Packaging issues have definitely been a pain.  I must admit I don't kno=
w=20
all of the ins and outs, so take my opinion with a grain of salt.  The=20
above, at least to me, seems like it's kind of trying to skirt around=20
the problem by making ceph-deploy jump through hoops to get ceph=20
installed (disabling epel yet installing packages from epel?).  These=20
are the kinds of hacks we did at the Supercomputing institute all the=20
time and they have a habit of building on themselves and leaking out in=
=20
strange ways. :)

If there's really no better way around this, I think we need to=20
communicate to the Yum/DMF team(s) what the problem is and that we need=
=20
to come up with some better way to control the priorities.  Given that=20
DMF is fairly new, it seems like a prime time to work with them no?

>
>   - Travis
>
>
> [1] http://wiki.centos.org/PackageManagement/Yum/Priorities#head-38b9=
1468cc607d0243f463489c2334bf40bfaaee
> [2] http://wiki.centos.org/PackageManagement/Yum/Priorities#head-6601=
a4937d4b099e6d46eea0bdb54241d51c7277--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
