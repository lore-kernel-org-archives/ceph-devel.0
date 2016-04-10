From: Loic Dachary <loic@dachary.org>
Subject: smoke suite partial pass for ARMv8 on v10.1.1
Date: Sun, 10 Apr 2016 10:12:39 +0200
Message-ID: <570A0AF7.3080001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41131 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbcDJIMo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Apr 2016 04:12:44 -0400
Received: from mfilter42-d.gandi.net (mfilter42-d.gandi.net [217.70.178.172])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id DF42F1720AE
	for <ceph-devel@vger.kernel.org>; Sun, 10 Apr 2016 10:12:41 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter42-d.gandi.net (mfilter42-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id JLRwC-SJM3Km for <ceph-devel@vger.kernel.org>;
	Sun, 10 Apr 2016 10:12:40 +0200 (CEST)
Received: from [192.168.17.17] (bad56-2-78-197-252-22.fbx.proxad.net [78.197.252.22])
	(Authenticated sender: loic@dachary.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D90F9172095
	for <ceph-devel@vger.kernel.org>; Sun, 10 Apr 2016 10:12:39 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Part of the smoke suite for the jewel RC passes[1] on ARMv8 for rados a=
nd rbd with

ceph-workbench[2] --verbose ceph-qa-suite --simultaneous-jobs 11 \
   --ceph v10.1.1 --suite smoke/basic \
   --filter 'rbd_api_tests,rbd_cli_import_export,rbd_fsx,rbd_python_api=
_tests,rados_' --upload

It would be great to have it pass for the other jobs as well[3] but I'm=
 not sure if it can:

* kclient_* and cfuse_* presumably need a specific kernel ?
* libcephfs_* did not try
* rados_workunit_loadgen_mix failed because it could not load the rbd m=
odule from the 4.2 kernel
* rgw_* would fail because https://github.com/ceph/s3-tests/pull/104 wh=
ich is the fix for http://tracker.ceph.com/issues/13885 is not merged y=
et

Even if there only are a few jobs, this is better than nothing and at t=
he very least we can run them before a jewel tentative backport is merg=
ed.
Unless someone has a better idea, I'll add instructions in the backport=
er HOWTO [4] to explain how to provision an OpenStack cluster at cloula=
b[5] and the command line above for convenient copy/paste. I also think=
 this is an acceptable use of the cloudlab resources because it protect=
s (to some extent) cloudlab users from ARMv8 regressions in Ceph when t=
hey try to use the OpenStackTeuthology profile to try new ideas.

Cheers

[1] smoke rados jobs http://teuthology-logs.public.ceph.com/ubuntu-2016=
-04-09_16:13:05-smoke-v10.1.1---basic-openstack/ and rbd jobs http://te=
uthology-logs.public.ceph.com/ubuntu-2016-04-09_21:15:46-smoke-v10.1.1-=
--basic-openstack/
[2] ceph-workbench http://ceph-workbench.readthedocs.org/
[3] https://github.com/ceph/ceph-qa-suite/tree/master/suites/smoke/basi=
c/tasks
[4] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_run_integ=
ration_and_upgrade_tests
[5] Testing Ceph with ARMv8 OpenStack instances http://dachary.org/?p=3D=
3939

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
