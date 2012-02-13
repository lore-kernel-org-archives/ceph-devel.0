From: <Eric_YH_Chen@wistron.com>
Subject: OSD id in configuration file
Date: Mon, 13 Feb 2012 16:05:26 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49DE23C32@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:52200 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2BMIPa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 03:15:30 -0500
Received: from TWNHUFE4.whq.wistron (unverified [10.37.31.104]) by TWNHUMSW3.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta283e0eba8c0a816711694@TWNHUMSW3.wistron.com> for <ceph-devel@vger.kernel.org>;
 Mon, 13 Feb 2012 16:07:37 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all:

For the scalability consideration, we would like to name the first
harddisk as "00101" on first server.

And named the first harddisk as "00201" on second server. The ceph.conf
seems like this:

[osd]
osd data = /srv/osd.$id
osd journal = /srv/osd.$id.journal
osd journal size = 1000

[osd.00101]
host = server-001
btrfs dev= /dev/sda

[osd.00102]
host = server-001
btrfs dev= /dev/sdb

[osd.00103]
host = server-001
btrfs dev= /dev/sdc

[osd.00201]
host = server-002
btrfs dev= /dev/sda

[osd.00202]
host = server-002
btrfs dev= /dev/sdb

[osd.00203]
host = server-002
btrfs dev= /dev/sdc

[osd.00301]
host = server-003
btrfs dev= /dev/sda

[osd.00302]
host = server-003
btrfs dev= /dev/sdb

[osd.00303]
host = server-003
btrfs dev= /dev/sdc

But we are worried about if it is an acceptable configuration for ceph.

As I see, the maximum osd is 304 now, although there are only 9 osds in
the cluster. 
Will this configuration influence about the performance? 
And what if we add osd.00204 in the future?

Thanks!


