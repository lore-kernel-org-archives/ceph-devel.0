From: Chris Dunlop <chris@onthe.net.au>
Subject: OSD repair: on disk size does not match object info size
Date: Tue, 10 Sep 2013 09:16:43 +1000
Message-ID: <20130909231643.GA31877@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:36068 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab3IIXQ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 19:16:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 49BCE6127E
	for <ceph-devel@vger.kernel.org>; Tue, 10 Sep 2013 09:16:54 +1000 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6U6TeajPhWl for <ceph-devel@vger.kernel.org>;
	Tue, 10 Sep 2013 09:16:49 +1000 (EST)
Received: from o1.private.otn.net.au (o1.private.onthe.net.au [10.200.63.41])
	by smtp1.onthe.net.au (Postfix) with ESMTP id AD5C7611C0
	for <ceph-devel@vger.kernel.org>; Tue, 10 Sep 2013 09:16:44 +1000 (EST)
Received: from achates.office.onthe.net.au (achates-gw1-vpn.private.onthe.net.au [10.9.1.8])
	by o1.private.otn.net.au (Postfix) with ESMTP id D925E80240
	for <ceph-devel@vger.kernel.org>; Tue, 10 Sep 2013 09:16:43 +1000 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day,

On 0.56.7-1~bpo70+1 I'm getting:

# ceph pg dump | grep inconsistent
013-09-10-08:39:59 2.bc        2776    0       0       0       11521799680     162063  162063  active+clean+inconsistent       2013-09-10 08:38:38.482302      20512'699877    20360'13461026  [6,0]   [6,0]   20512'699877    2013-09-10 08:38:38.482264      20512'699877     2013-09-10 08:38:38.482264

# ceph pg repair 2.bc
instructing pg 2.bc on osd.6 to repair

# tail /var/log/ceph/ceph-osd.6.log
2013-09-10 08:17:25.557926 7fef09c14700  0 log [ERR] : repair 2.bc 89ebebc/rbd_data.13a0c74b0dc51.00000000000107ec/head//2 on disk size (4194304) does not match object info size (4104192)
2013-09-10 08:17:27.316112 7fef09c14700  0 log [ERR] : 2.bc repair 1 errors, 0 fixed

# ls -l 'ceph-6/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2'
-rw-r--r-- 1 root root 4194304 Sep  8 21:01 ceph-6/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2
# ls -l 'ceph-0/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2'
-rw-r--r-- 1 root root 4194304 Sep  8 21:01 ceph-0/current/2.bc_head/DIR_C/DIR_B/DIR_E/rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2

One possible solution would be to simply truncate the objects down to the
object info size, as recommended in this case:

http://www.spinics.net/lists/ceph-users/msg00793.html

However I'm a little concerned about that solution as the on-disk size is
exactly 4MB, which I think is the expected size of these objects, and matches
the size of all the other objects in the same directory, and the "extra" data
looks a little interesting, with "FILE0" blocks in there (what are those?):

# cd /var/lib/ceph/osd/ceph-6/current/2.bc_head/DIR_C/DIR_B/DIR_E/
# dd if='rbd\udata.13a0c74b0dc51.00000000000107ec__head_089EBEBC__2' bs=1024 skip=4008 | od -c
0000000   F   I   L   E   0  \0 003  \0 312   j   o   o  \0  \0  \0  \0
0000020 001  \0 001  \0   8  \0 001  \0   X 001  \0  \0  \0 004  \0  \0
0000040  \0  \0  \0  \0  \0  \0  \0  \0 006  \0  \0  \0 310   p 017  \0
0000060 002  \0  \0  \0  \0  \0  \0  \0 020  \0  \0  \0   `  \0  \0  \0
...
0002000   F   I   L   E   0  \0 003  \0 002   k   o   o  \0  \0  \0  \0
0002020 001  \0 001  \0   8  \0 001  \0   X 001  \0  \0  \0 004  \0  \0
0002040  \0  \0  \0  \0  \0  \0  \0  \0 006  \0  \0  \0 311   p 017  \0
0002060 002  \0  \0  \0  \0  \0  \0  \0 020  \0  \0  \0   `  \0  \0  \0
...
0004000   F   I   L   E   0  \0 003  \0 023   r   o   o  \0  \0  \0  \0
0004020 001  \0 001  \0   8  \0 001  \0   X 001  \0  \0  \0 004  \0  \0
0004040  \0  \0  \0  \0  \0  \0  \0  \0 006  \0  \0  \0 312   p 017  \0
0004060 002  \0  \0  \0  \0  \0  \0  \0 020  \0  \0  \0   `  \0  \0  \0

Is it safe to simply truncate this object, or what other solutions might
be applicable?

Cheers,

Chris
