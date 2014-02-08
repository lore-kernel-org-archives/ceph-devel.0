From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: wip-libcephfs-firefly-rb
Date: Fri, 7 Feb 2014 19:02:10 -0500 (EST)
Message-ID: <256713015.152.1391817730841.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2549 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbaBHACN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Feb 2014 19:02:13 -0500
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by aa.linuxbox.com (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id s1802CPV013708
	for <ceph-devel@vger.kernel.org>; Fri, 7 Feb 2014 19:02:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id 20EC23FC8497
	for <ceph-devel@vger.kernel.org>; Fri,  7 Feb 2014 19:02:12 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com ([127.0.0.1])
	by localhost (thunderbeast.private.linuxbox.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9ohAXfM5JGT for <ceph-devel@vger.kernel.org>;
	Fri,  7 Feb 2014 19:02:11 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id 058103FC848B
	for <ceph-devel@vger.kernel.org>; Fri,  7 Feb 2014 19:02:11 -0500 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage and Ceph devs,

Casey over here root-caused and we believe fixed the refcounting problem on our wip-libcephfs branch, and
a rebase to firefly is in progress.

The fix is on wip-libcephfs-firefly-rb :

"""
fuse: fix for missing ll_ref on create
when the 'Inode **outp' argument was added to ll_create(), it was
changed to only take the ll_ref if outp was not NULL. fuse_ll_create()
was calling ll_create() with outp=NULL, and subsequently calling
fuse_reply_create() (which causes fuse to increment the lookup count)
without registering the initial ll_ref

this patch adds a dummy inode pointer i2 to the ll_create() call to
claim our initial reference

Signed-off-by: Casey Bodley <casey@linuxbox.com>
"""

We're still finishing up the rebase, but I expect to have one tested by some time tomorrow am.

Thanks,

Matt

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
