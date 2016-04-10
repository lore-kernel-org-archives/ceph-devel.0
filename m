From: Loic Dachary <loic@dachary.org>
Subject: Re: smoke suite partial pass for ARMv8 on v10.1.1
Date: Sun, 10 Apr 2016 13:58:02 +0200
Message-ID: <570A3FCA.1040308@dachary.org>
References: <570A0AF7.3080001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54475 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbcDJL6J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Apr 2016 07:58:09 -0400
Received: from mfilter28-d.gandi.net (mfilter28-d.gandi.net [217.70.178.159])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 1039E17209A
	for <ceph-devel@vger.kernel.org>; Sun, 10 Apr 2016 13:58:07 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter28-d.gandi.net (mfilter28-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Jg7EfQejD2Mn for <ceph-devel@vger.kernel.org>;
	Sun, 10 Apr 2016 13:58:05 +0200 (CEST)
Received: from [192.168.1.11] (unknown [80.12.43.163])
	(Authenticated sender: loic@dachary.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C9469172095
	for <ceph-devel@vger.kernel.org>; Sun, 10 Apr 2016 13:58:04 +0200 (CEST)
In-Reply-To: <570A0AF7.3080001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I forgot the link for the smon mon thrash job that also passes

http://teuthology-logs.public.ceph.com/ubuntu-2016-04-10_08:04:08-smoke=
:basic-v10.1.1---basic-openstack/

On 10/04/2016 10:12, Loic Dachary wrote:
> Hi,
>=20
> Part of the smoke suite for the jewel RC passes[1] on ARMv8 for rados=
 and rbd with
>=20
> ceph-workbench[2] --verbose ceph-qa-suite --simultaneous-jobs 11 \
>    --ceph v10.1.1 --suite smoke/basic \
>    --filter 'rbd_api_tests,rbd_cli_import_export,rbd_fsx,rbd_python_a=
pi_tests,rados_' --upload
>=20
> It would be great to have it pass for the other jobs as well[3] but I=
'm not sure if it can:
>=20
> * kclient_* and cfuse_* presumably need a specific kernel ?
> * libcephfs_* did not try
> * rados_workunit_loadgen_mix failed because it could not load the rbd=
 module from the 4.2 kernel
> * rgw_* would fail because https://github.com/ceph/s3-tests/pull/104 =
which is the fix for http://tracker.ceph.com/issues/13885 is not merged=
 yet
>=20
> Even if there only are a few jobs, this is better than nothing and at=
 the very least we can run them before a jewel tentative backport is me=
rged.
> Unless someone has a better idea, I'll add instructions in the backpo=
rter HOWTO [4] to explain how to provision an OpenStack cluster at clou=
lab[5] and the command line above for convenient copy/paste. I also thi=
nk this is an acceptable use of the cloudlab resources because it prote=
cts (to some extent) cloudlab users from ARMv8 regressions in Ceph when=
 they try to use the OpenStackTeuthology profile to try new ideas.
>=20
> Cheers
>=20
> [1] smoke rados jobs http://teuthology-logs.public.ceph.com/ubuntu-20=
16-04-09_16:13:05-smoke-v10.1.1---basic-openstack/ and rbd jobs http://=
teuthology-logs.public.ceph.com/ubuntu-2016-04-09_21:15:46-smoke-v10.1.=
1---basic-openstack/
> [2] ceph-workbench http://ceph-workbench.readthedocs.org/
> [3] https://github.com/ceph/ceph-qa-suite/tree/master/suites/smoke/ba=
sic/tasks
> [4] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_run_int=
egration_and_upgrade_tests
> [5] Testing Ceph with ARMv8 OpenStack instances http://dachary.org/?p=
=3D3939
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
