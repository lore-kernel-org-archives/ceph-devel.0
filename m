From: Travis Rhoden <trhoden@redhat.com>
Subject: Moving away from Yum/DNF repo priorities for Ceph and ceph-deploy
Date: Thu, 23 Jul 2015 16:12:59 -0700
Message-ID: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbbGWXNA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jul 2015 19:13:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, yum@lists.baseurl.org

HI Everyone,

I=E2=80=99m working on ways to improve Ceph installation with ceph-depl=
oy, and a common hurdle we have hit involves dependency issues between =
ceph.com hosted RPM repos, and packages within EPEL.  For a while we we=
re able to managed this with the priorities plugin, but then EPEL shipp=
ed packages that included changes that weren=E2=80=99t available on the=
 ceph.com packages, and the EPEL packages =E2=80=9Cobsoleted=E2=80=9D t=
he ceph.com ones.  This caused EPEL packages to take priority over ceph=
=2Ecom packages even when ceph.com packages had greater version numbers=
=2E  The solution to this was to enable the =E2=80=9Ccheck_obsoletes=E2=
=80=9D feature of the priorities plugin.  That=E2=80=99s where we are t=
oday.

Recently when working with DNF, I observed that the priorities feature =
got pulled natively into DNF, but I cannot find anything about whether =
=E2=80=9Ccheck_obsoletes=E2=80=9D is still necessary or even an option.=
 Regardless, I would like move away from this workflow as it is general=
ly seen as poor. [1] [2]

What I=E2=80=99d like to propose instead of ceph-deploy=E2=80=99s curre=
nt workflow is to:

(1) install epel-release on nodes that need it
(2) disable EPEL by default (using yum-config-manager)
(3) When installing Ceph, break the install into two parts
(3)(a) Explicitly install Ceph=E2=80=99s dependencies from EPEL by name=
, using yum =E2=80=94enablerepo=3Depel
(3)(b) Proceed normally with Ceph installation, but adding a =E2=80=94d=
isablerepo=3Depel flag as well

Note: the disabling of EPEL in 3b seems redundant with 2, but it would =
cover cases when a user/admin chooses to enable EPEL by default.  We ar=
e mostly concerned with nodes that are dedicated to Ceph and therefore =
ceph-deploy is free to do things like disabling EPEL, but that=E2=80=99=
s certainly not always ideal.  We could disable it by default *only* if=
 we were the ones to install it.  If it=E2=80=99s already there, we lea=
ve it along but then still do our two-phase install and explicitly disa=
ble it when doing the second phase of install.

I think this workflow would allow us to no longer need to use repo prio=
rities, but I might be missing something.  A secondary motive to this i=
s to end up with systems that EPEL disabled by default because it has c=
aused issues with Calamari, where EPEL has newer packages of certain th=
ings than what gets installed initially and then breaks Calamari.  Havi=
ng EPEL disabled will prevent that, and will also prevent things like =E2=
=80=9Cyum update=E2=80=9D from breaking things.

Potential downsides I see are what happens when there are updates in EP=
EL that we want, say for a security fix?

 - Travis


[1] http://wiki.centos.org/PackageManagement/Yum/Priorities#head-38b914=
68cc607d0243f463489c2334bf40bfaaee
[2] http://wiki.centos.org/PackageManagement/Yum/Priorities#head-6601a4=
937d4b099e6d46eea0bdb54241d51c7277--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
