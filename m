From: Wido den Hollander <wido@42on.com>
Subject: CephFS hangs when writing 10GB files in loop
Date: Wed, 17 Dec 2014 17:35:45 +0100
Message-ID: <5491B0E1.7050203@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:52354 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbaLQQft (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Dec 2014 11:35:49 -0500
Received: from [IPv6:2001:610:b10:1d8:fced:3f2e:64f3:6edd] (unknown [IPv6:2001:610:b10:1d8:fced:3f2e:64f3:6edd])
	by websrv.42on.com (Postfix) with ESMTPSA id 6F885D2B8A
	for <ceph-devel@vger.kernel.org>; Wed, 17 Dec 2014 17:35:47 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Today I've been playing with CephFS and the morning started great with
CephFS playing along just fine.

Some information first:
- Ceph 0.89
- Linux kernel 3.18
- Ceph fuse 0.89
- One Active MDS, one Standby

This morning I could write a 10GB file like this using the kclient:
$ dd if=/dev/zero of=10GB.bin bs=1M count=10240 conv=fsync

That gave me 850MB/sec (all 10G network) and I could read the same file
again with 610MB/sec.

After writing to it multiple times it suddenly started to hang.

No real evidence on the MDS (debug mds set to 20) or anything on the
client. That specific operation just blocked, but I could still 'ls' the
filesystem in a second terminal.

The MDS was showing in it's log that it was checking active sessions of
clients. It showed the active session of my single client.

The client renewed it's caps and proceeded.

I currently don't have any logs, but I'm just looking for a direction to
be pointed towards.

Any ideas?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
