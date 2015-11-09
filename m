From: Laurent GUERBY <laurent@guerby.net>
Subject: Help on ext4/xattr linux kernel stability issue / ceph xattr use?
Date: Mon, 09 Nov 2015 10:41:30 +0100
Message-ID: <1447062090.2019.557.camel@guerby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.tetaneutral.net ([91.224.149.83]:43209 "EHLO
	mx1.tetaneutral.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbKIJr1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 04:47:27 -0500
Received: from lgnuc (ip165-ipv6.tetaneutral.net [IPv6:2a01:6600:8081:a500::1])
	by mx1.tetaneutral.net (Postfix) with ESMTP id EB7698C140
	for <ceph-devel@vger.kernel.org>; Mon,  9 Nov 2015 10:41:30 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Part of our ceph cluster is using ext4 and we recently hit major kernel
instability in the form of kernel lockups every few hours, issues
opened:

http://tracker.ceph.com/issues/13662
https://bugzilla.kernel.org/show_bug.cgi?id=107301

On kernel.org kernel developpers are asking about ceph usage of xattr,
in particular wether there are lots of common xattr key/value or wether
they are all differents.

I attached a file with various xattr -l outputs:

https://bugzilla.kernel.org/show_bug.cgi?id=107301#c8
https://bugzilla.kernel.org/attachment.cgi?id=192491

Looks like the "big" xattr "user.ceph._" is always different, same for
the intermediate size "user.ceph.hinfo_key".

"user.cephos.spill_out" and "user.ceph.snapset" seem to have small
values, and within a small value set.

Our cluster is used exclusively for virtual machines block devices with
rbd, on replicated (3) and erasure coded pools (4+1 and 8+2).

Could someone knowledgeable add some information on ceph use of xattr in
the kernel.org bugzilla above?

Also I think it is necessary to warn ceph users to avoid ext4 at all
costs until this kernel/ceph issue is sorted out: we went from
relatively stable production for more than a year to crashes everywhere
all the time since two weeks ago, probably after hitting some magic
limit. We migrated our machines to ubuntu trusty, our SSD based
filesystem to XFS but our HDD are still mostly on ext4 (60 TB
of data to move so not that easy...).

Thanks in advance for your help,

Sincerely,

Laurent GUERBY
http://tetaneutral.net


