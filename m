From: Sage Weil <sweil@redhat.com>
Subject: RE: Mon gets flooded with log messages for default log level
Date: Mon, 8 Sep 2014 06:59:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409080656220.30626@cobra.newdream.net>
References: <7F4FDDF05D5B3241ABA5EB82D169E31E054EBF45@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37093 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbaIHN72 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Sep 2014 09:59:28 -0400
In-Reply-To: <7F4FDDF05D5B3241ABA5EB82D169E31E054EBF45@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>

Note that you can make these messages stop with

  debug mon = 0

in your ceph.conf.  It looks like you are right, though: that 
is_readable() dout line is spamming things.  We can fix that in the next 
release.

	https://github.com/ceph/ceph/pull/2421

Thanks!
sage


On Mon, 8 Sep 2014, Aanchal Agrawal wrote:

> Any help on this ...
> 
> -----Original Message-----
> From: Aanchal Agrawal
> Sent: Friday, September 05, 2014 5:56 PM
> To: ceph-devel@vger.kernel.org
> Subject: Mon gets flooded with log messages for default log level
> 
> Hi,
> 
> With reference to commit f7d1902ccf9d5bb97cda626d718c3bb02f991a6d, 'Paxos' default level has been increased to 1.
> This cause mon to get flooded with the following message,  thus causes OS Drive(160GB) to get filled in 4-5 hours.
> 
> Log Snippet ::
> ==================
> 2014-09-01 16:35:11.527734 7f7efe706700 1 mon.rack6-ramp-1@0(leader).paxos(paxos active c 1..712) is_readable now=2014-09-01 16:35:11.527735 lease_expire=2014-09-01 16:35:13.637940 has v0 lc 712
> 2014-09-01 16:35:11.527773 7f7efe706700 1 mon.rack6-ramp-1@0(leader).paxos(paxos active c 1..712) is_readable now=2014-09-01 16:35:11.527774 lease_expire=2014-09-01 16:35:13.637940 has v0 lc 712
> 2014-09-01 16:35:11.527807 7f7efe706700 1 mon.rack6-ramp-1@0(leader).paxos(paxos active c 1..712) is_readable now=2014-09-01 16:35:11.527807 lease_expire=2014-09-01 16:35:13.637940 has v0 lc 712
> 2014-09-01 16:35:11.527840 7f7efe706700 1 mon.rack6-ramp-1@0(leader).paxos(paxos active c 1..712) is_readable now=2014-09-01 16:35:11.527840 lease_expire=2014-09-01 16:35:13.637940 has v0 lc 712
> 2014-09-01 16:35:11.527874 7f7efe706700 1 mon.rack6-ramp-1@0(leader).paxos(paxos active c 1..712) is_readable now=2014-09-01 16:35:11.527875 lease_expire=2014-09-01 16:35:13.637940 has v0 lc 712 ==================
> 
> ==================
> src/mon/Paxos.cc
> dout(1) << "is_readable now=" << ceph_clock_now(g_ceph_context) << " lease_expire=" << lease_expire
>           << " has v" << v << " lc " << last_committed << dendl; ==================
> 
> Incrementing 'log level' of this message to 2 or something else will solve this problem of mon space getting full quickly.
> 
> Moreover is this message that useful to get printed with default debug level '1'?
> Let me know if I am missing something here.
> 
> Thanks,
> Aanchal
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
