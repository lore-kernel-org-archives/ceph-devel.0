From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: OSD and MON memory usage
Date: Fri, 16 Nov 2012 17:24:01 +0000
Message-ID: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:42519 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978Ab2KPRYF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Nov 2012 12:24:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 7DCAB7000487
	for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 17:24:02 +0000 (WET)
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id tFo8qPzbdN0Z for <ceph-devel@vger.kernel.org>;
	Fri, 16 Nov 2012 17:24:02 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 2A9CD700048E
	for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 17:24:02 +0000 (WET)
Received: from coyote.ist.utl.pt (coyote.ist.utl.pt [193.136.132.235])
	(Authenticated sender: ist146506)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 229AA200A8C7
	for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 17:24:02 +0000 (WET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


 Hi,

 We're testing ceph using a recent build from the 'next' branch (commit
b40387d) and we've run into some interesting problems related to memory
usage.

 The setup consists of 64 OSDs (4 boxes, each with 16 disks, most of
them 2TB, some 1.5TB, XFS filesystems, Debian Wheezy). After the
initial mkcephfs, a 'ceph -s' reports 12480 pgs total.

 For generating some load we used

rados -p rbd bench 28000 write -t 25

and left it running overnight.

 After several hours most of the OSDs had eaten up around 1GB or more
of memory each, which caused trashing on the servers (12GB of RAM
per box), and eventually the OOM killer was invoked, killing many OSDs
and even the SSH daemons. This seems to have caused a domino effect,
and in the morning only around 18 of the OSD were still up.

 After a hard reboot of the boxes that were unresponsive, we are now in
a situation in which there is simply not enough memory for the cluster
to recover. That is, after restarting the OSDs, in 2 to 3 minutes we
have many of them using 1~1.5GB of RAM and the trashing starts all over
again, the OOM killer comes in and things go downhill again. Efectively
the cluster is not able to recover no matter how many times we restart
the daemons.

 We're not using any non-default options in the OSD section of the
config. file. We checked that there is free space for logging on the
system partitions.

 While I know that 12GB per machine can be hardly called to much RAM,
the question I put forward is: is it reasonable for a OSD to consume so
much memory in normal usage, or even recovery situations, when there is
just around ~200 PGs per OSD and only around ~3TB of objects created by
rados bench?

 Is there a rule of thumb to estimate the amount of memory consumed as
a function of PG count, object count and perhaps the number of PGs
trying to recover in a given instant? One of my concerns here is also
to understand if memory consumption during recovery is bounded and
deterministic at all, or if we're simply hitting a severe memory leak
in the OSDs.

 As for the monitor daemon on this cluster (running on a dedicated
machine), it is currently using 3.2GB of memory, and it got to that
point again in a matter of minutes after being restarted. Would it be
good if we tested with the changes from the wip-mon-leaks-fix branch?

 We would appreciate any advice on the best way to understand if the
OSDs are leaking memory or not.

 We will gladly provide any config or debug info that you might be
interested in, or run any tests.

 Thanks in advance

Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
