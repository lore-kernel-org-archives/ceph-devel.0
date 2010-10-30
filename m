From: Sage Weil <sage@newdream.net>
Subject: RE: Ceph and bonnie++
Date: Sat, 30 Oct 2010 09:02:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010300900070.9576@cobra.newdream.net>
References: <14C7F4F06DB5814AB0DE29716C4F6D6710AA6958@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
 <AANLkTikRkB8oXoTdaxgTRB8vAdXJPOUHnyUH0wxf2_U6@mail.gmail.com>
 <14C7F4F06DB5814AB0DE29716C4F6D6710AA6A6E@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58122 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab0J3P6r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Oct 2010 11:58:47 -0400
In-Reply-To: <14C7F4F06DB5814AB0DE29716C4F6D6710AA6A6E@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 30 Oct 2010, Smets, Jan (Jan) wrote:
> 3 servers with each 2 OSDs, 1 MON and 1 MDS.

Which version of the kernel client are you using?  It's possible this is 
related to efa4c120, which loosened the locking surrounding satisfying 
readdir requests from the dcache.

sage



> 
> - Jan 
> 
> -----Original Message-----
> From: gfarnum@gmail.com [mailto:gfarnum@gmail.com] On Behalf Of Gregory Farnum
> Sent: vrijdag 29 oktober 2010 21:50
> To: Smets, Jan (Jan)
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Ceph and bonnie++
> 
> On Fri, Oct 29, 2010 at 6:37 AM, Smets, Jan (Jan) <jan.smets@alcatel-lucent.com> wrote:
> > client0:/mnt/ceph# bonnie -s 40 -r 10 -u root -f Using uid:0, gid:0.
> > Writing intelligently...done
> > Rewriting...done
> > Reading intelligently...done
> > start 'em...done...done...done...
> > Create files in sequential order...done.
> > Stat files in sequential order...Expected 16384 files but only got 0 
> > Cleaning up test directory after error.
> >
> >
> > Any suggestions? There was a thread about this some time ago:
> Are you running this with one or many MDSes? It should be fine under a single MDS.
> 
> bonnie++ is one of the workloads we've had issues with on a multi-mds
> system, although I thought we had it working at this point. I'll run our tests again now and see if I can reproduce locally.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
