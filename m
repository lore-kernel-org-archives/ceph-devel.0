From: Dennis Chen <kernel.org.gnu@gmail.com>
Subject: The project of ceph client file system porting from Linux to AIX
Date: Wed, 4 Mar 2015 17:59:45 +0800
Message-ID: <CA+U0gVhWKjxMUBAw91B1vkYrF9s=pna1eZ3HfV+vBJ5aMhKWQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37643 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758428AbbCDKAG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 05:00:06 -0500
Received: by pdbnh10 with SMTP id nh10so30349914pdb.4
        for <ceph-devel@vger.kernel.org>; Wed, 04 Mar 2015 02:00:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>

Hello,

The ceph cluster now can only be used by Linux system AFAICT, so I
planed to port the ceph client file system from Linux to AIX as a
tiered storage solution in that platform. Below is the source code
repository I've done, which is still in progress. 3 important modules:

1. aixker: maintain a uniform kernel API beteween the Linux and AIX
2. net: as a data transfering layer between the client and cluster
3. fs: as an adaptor to make the AIX can recognize the Linux file system.

https://github.com/Dennis-Chen1977/aix-cephfs

Welcome any comments or anything...

-- 
Den
