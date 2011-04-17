From: Zenon Panoussis <oracle@provocation.net>
Subject: Logging
Date: Mon, 18 Apr 2011 01:30:05 +0200
Message-ID: <4DAB77FD.4010804@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:36568 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1DQXaU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 19:30:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Question: what's the "do not log at all" syntax in ceph.conf? I tried
putting everything on "debug xyz = 0", but ceph (osd in this case) is
still logging plenty. According to this, I think it shouldn't:

# grep debug /etc/ceph/ceph.conf
	; logging, for debugging monitor crashes, in order of
	debug ms = 0
	debug mon = 0
	debug paxos = 0
	debug auth = 0
	; mds logging to debug issues.
	debug ms = 0
	debug mds = 0
	debug mds balancer = 0
	debug mds log = 0
	debug mds_migrator = 0
	debug monc = 0
	; osd logging to debug osd issues, in order of likelihood of being
	debug ms = 0
	debug osd = 0
	debug filestore = 0
	debug journal = 0

Log example:

2011-04-18 01:28:56.787046 7f7976fd8700 osd0 5 pg[1.3d( v 5'186 (5'184,5'186] n=1 ec=2 les=5 3/3/2) [0,1] r=0 mlcod 5'184 active+clean]  sending commit on repgather(0x7f794827fb70 applying 5'186 rep_tid=49196 wfack=0 wfdisk= op=osd_op(mds0.1:27067 200.00000058 [write 3241176~1615] 1.fbbd) v2) 0x7f794811b630

Z


