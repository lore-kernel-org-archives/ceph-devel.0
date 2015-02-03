From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: using ceph-deploy on build after make install
Date: Tue, 3 Feb 2015 23:58:01 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91555455F4@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0119.outbound.protection.outlook.com ([157.56.110.119]:20544
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753857AbbBCX6I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 18:58:08 -0500
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2D66812C0002
	for <ceph-devel@vger.kernel.org>; Tue,  3 Feb 2015 17:58:02 -0600 (CST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

New to ceph building but here is my situation...

I have been successfully able to build ceph starting from
   git checkout firefly
(also successful from git checkout master).  After building, I am able
to run vstarth.sh from the source directory as ./vstart.sh -d -n -x
(or with -X).  I can then do rados commands such as rados bench.

I should also add that when I have installed binaries from rpms (this
is a fedora21 aarch64 system), I have been successfully able to deploy
a cluster using various ceph-deploy commands.

Now I would like to do make install to install my built version and
then use the installed version with my ceph-deploy commands.  In this
case I installed ceph-deploy with pip install ceph-deploy which gives
me 5.21.

The first ceph-deploy command I use is:

    ceph-deploy new myhost

which seems to work fine.

The next command however is

     ceph-deploy mon create-initial

which ends up failing with

[INFO  ] Running command: /usr/sbin/service ceph -c /etc/ceph/ceph.conf start mon.hostname
[WARNIN] The service command supports only basic LSB actions (start, stop, restart, try-rest\
art, reload, force-reload, status). For other actions, please try to use systemctl.
[ERROR ] RuntimeError: command returned non-zero exit status: 2
[ERROR ] Failed to execute command: /usr/sbin/service ceph -c /etc/ceph/ceph.conf start mon.seattle-tdeneau
[ERROR ] GenericError: Failed to create 1 monitors

and even the ceph status command fails

#  ceph -c ./ceph.conf status
 -1 monclient(hunting): ERROR: missing keyring, cannot use cephx for authentication
  0 librados: client.admin initialization error (2) No such file or directory
Error connecting to cluster: ObjectNotFound

Whereas this all worked fine when I used binaries from rpms.
Is there some install step that I am missing?

-- Tom Deneau, AMD  

