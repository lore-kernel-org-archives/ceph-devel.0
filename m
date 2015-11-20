From: Sage Weil <sweil@redhat.com>
Subject: Re: Aggregate failure report in ceph -s
Date: Fri, 20 Nov 2015 03:27:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511200324480.24879@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC0365008A@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1661655366-1448018878=:24879"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37623 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758503AbbKTL2B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Nov 2015 06:28:01 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC0365008A@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1661655366-1448018878=:24879
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 20 Nov 2015, Chen, Xiaoxi wrote:
> 
> Hi Sage,
> 
>        As we are looking at the failure detection part of ceph(basically
> around osd flipping issue), we  got some suggestion from customer that
> showing the aggregated failure report in ?ceph ?s?. The idea is:
> 
>       When an OSD find it cannot hear heartbeat from some of the peers, it
> will try to aggregate the failure domain, say ?I cannot reach all my peers
> in Rack C,    something wrong??  and this kind of log will be showed on ceph
> ?s.   So if we see ceph ?s and notice a lot of complain saying cannot reach
> Rack C, we will easily diagnose the Rack C has some network issue.
> 
>  
> 
>       Is that make sense?

Yeah, sounds reasonable to me!  It's a bit more awkward to do this at the 
mon level since rack C may talk to the mon, but doing it at the OSD makes 
sense.  There will be a lot of heuristics involved, though.  I expect the 
messages might include

- cannot reach _% of peers outside of my $crushlevel $foo [on front|back]
- cannot reach _% of hosts in $crushlevel $foo [on front|back]

?

Also note that it would be easiest to log these in the cluster log (ceph 
-w, not ceph -s).. I'm guessing that's what you mean?

Thanks!
sage
--557981400-1661655366-1448018878=:24879--
