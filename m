From: Wido den Hollander <wido@42on.com>
Subject: Pool creation fails: 'failed run crushtool: fork failed: (12)
 Cannot allocate memory'
Date: Thu, 21 Jul 2016 17:49:57 +0200 (CEST)
Message-ID: <976529875.1339.1469116197418@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:56133 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbcGUPuA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 11:50:00 -0400
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 7E0314091C
	for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 17:49:57 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On a CentOS 7 system with a Jewel 10.2.2 cluster I'm trying to create a pool which fails.

Any pool I try to create, with or without a ruleset applied to it fails with this error:

"Error ENOMEM: crushtool check failed with -12: failed run crushtool: fork failed: (12) Cannot allocate memory"

At first I thought it was a package version mismatch, but it doesn't seem to be the case.

There are other commands like 'radosgw-admin' I see fail with -12 error codes as well.

Any ideas what might be going on here? The system has roughly 29GB of free memory, so that should be sufficient.

Wido

LSB Version:	:core-4.1-amd64:core-4.1-noarch
Distributor ID:	CentOS
Description:	CentOS Linux release 7.1.1503 (Core) 
Release:	7.1.1503
Codename:	Core

[root@srv-zmb16-21 ~]# rpm -qa|grep -E "rados|ceph"
librados2-10.2.2-0.el7.x86_64
python-cephfs-10.2.2-0.el7.x86_64
ceph-base-10.2.2-0.el7.x86_64
ceph-osd-10.2.2-0.el7.x86_64
libcephfs1-10.2.2-0.el7.x86_64
python-rados-10.2.2-0.el7.x86_64
ceph-selinux-10.2.2-0.el7.x86_64
ceph-mon-10.2.2-0.el7.x86_64
ceph-10.2.2-0.el7.x86_64
libradosstriper1-10.2.2-0.el7.x86_64
ceph-common-10.2.2-0.el7.x86_64
ceph-mds-10.2.2-0.el7.x86_64
ceph-radosgw-10.2.2-0.el7.x86_64
[root@srv-zmb16-21 ~]#

[root@srv-zmb16-21 wido]# ceph osd pool create .zm1.rgw.meta 512 512 prd-zm1-hdd
2016-07-21 17:46:24.408700 7fd45998c700  1 librados: starting msgr at :/0
2016-07-21 17:46:24.408705 7fd45998c700  1 librados: starting objecter
2016-07-21 17:46:24.408871 7fd45998c700  1 librados: setting wanted keys
2016-07-21 17:46:24.408873 7fd45998c700  1 librados: calling monclient init
2016-07-21 17:46:24.411332 7fd45998c700  1 librados: init done
Error ENOMEM: crushtool check failed with -12: failed run crushtool: fork failed: (12) Cannot allocate memory
2016-07-21 17:46:24.495467 7fd45998c700 10 librados: watch_flush enter
2016-07-21 17:46:24.495494 7fd45998c700 10 librados: watch_flush exit
2016-07-21 17:46:24.495970 7fd45998c700  1 librados: shutdown
[root@srv-zmb16-21 wido]#
