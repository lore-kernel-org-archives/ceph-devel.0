From: "xan.peng" <xanpeng@gmail.com>
Subject: A problem with ceph-disk and ceph-deploy
Date: Sat, 26 Oct 2013 00:44:46 +0800
Message-ID: <CA+8ZFngUzk1_koBBkJjdrRje--0SJ_K0=xZ4SrnTL4GTiBTuKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:38972 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab3JYQoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Oct 2013 12:44:46 -0400
Received: by mail-ie0-f172.google.com with SMTP id tp5so7002570ieb.17
        for <ceph-devel@vger.kernel.org>; Fri, 25 Oct 2013 09:44:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I ran into a little problem when trying ceph-deploy, and I'm wondering
it's a bug?

steps:
1) ./ceph-deploy -v osd prepare --fs-type ext4
mon02:sdb:/mnt/cephjournal/journal0
2) ./ceph-deploy -v osd activate --fs-type ext4
mon02:/dev/sdb1:/mnt/cephjournal/journal0
"ERROR:ceph-disk:Failed to activate" shown.

solution:
go to target node, run `ceph-disk -v activate --mark-init sysvinit
--mount /dev/sdb1`, find that in maybe_mkdir()@/usr/sbin/ceph-disk,
os.mkdir("/var/lib/ceph/osd/osd-1") is called.
Right here should we use os.makedirs() instead of os.mkdir()? As
makedirs will create all intermediate directories but mkdir will not.
-- 
Best,
xan
