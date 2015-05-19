From: CSa <salzmann@mi.fu-berlin.de>
Subject: kernel BUG at .../fs/ceph/xattr.c:287!
Date: Tue, 19 May 2015 14:39:19 +0200
Message-ID: <mjfatn$c1e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46084 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932284AbbESMpG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 May 2015 08:45:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YugtM-0006Eq-3q
	for ceph-devel@vger.kernel.org; Tue, 19 May 2015 14:45:04 +0200
Received: from mintzer.imp.fu-berlin.de ([160.45.113.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 14:45:04 +0200
Received: from salzmann by mintzer.imp.fu-berlin.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 14:45:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we are encountering a bug in the cephfs client kernel module:


May 18 11:02:04 allegro kernel: [1020094.145209] ------------[ cut here 
]------------
May 18 11:02:04 allegro kernel: [1020094.149127] kernel BUG at /build/linux-
RGM_Ed/linux-3.16.7-ckt9/fs/ceph/xattr.c:287!
May 18 11:02:04 allegro kernel: [1020094.149127] invalid opcode: 0000 [#1] 
SMP 
[...]
May 18 11:02:04 allegro kernel: [1020094.149127] CPU: 2 PID: 1359 Comm: mv 
Not tainted 3.16.0-4-amd64 #1 Debian 3.16.7-ckt9-3~deb8u1
[...]

(see full log at http://paste.debian.net/180292)


has anybody been hit by this so far?

ciao
Christian

