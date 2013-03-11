From: Greg Farnum <greg@inktank.com>
Subject: Re: Estimating OSD memory requirements (was Re: stuff for
 v0.56.4)
Date: Mon, 11 Mar 2013 08:51:47 -0700
Message-ID: <955E1AF457D644858C908A3AA0392A03@inktank.com>
References: <201303111510.r2BFAUcx011721@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:42532 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab3CKPvv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 11:51:51 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so3866397pbc.9
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 08:51:51 -0700 (PDT)
In-Reply-To: <201303111510.r2BFAUcx011721@ayesha.phys.virginia.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bkw1a@ayesha.phys.virginia.edu
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Monday, March 11, 2013 at 8:10 AM, Bryan K. Wright wrote:

> sage@inktank.com said:
> > On Thu, 7 Mar 2013, Bryan K. Wright wrote:
> > 
> > sage@inktank.com said:
> > > - pg log trimming (probably a conservative subset) to avoid memory bloat 
> > 
> > 
> > 
> > Anything that reduces the size of OSD processes would be appreciated.
> > You can probably do this with just
> > log max recent = 1000
> > By default it's keeping 100k lines of logs in memory, which can eat a lot of
> > ram (but is great when debugging issues).
> 
> 
> 
> Thanks for the tip about "log max recent". I've made this 
> change, but it doesn't seem to significantly reduce the size of the 
> OSD processes.
> 
> In general, are there some rules of thumb for estimated the
> memory requirements for OSDs? I see processes blow up to 8gb of 
> resident memory sometimes. If I need to allow for that much memory
> per OSD process, I may have to just walk away from ceph.
> 
> Does the memory usage scale with the size of the disks?
> I've been trying to run 12 OSDs with 12 2TB disks on a single box.
> Would I be better off (memory-usage-wise) if I RAIDed the disks
> together and used a single OSD process?
> 


Memory use depends on several things, but the most important are how many PGs the daemon is hosting, and whether it's undergoing recovery of some kind. (Absolute disk size is not involved.) If you're getting up to 8GB per, it sounds as if you may have a bit too many PGs.
You could try RAIDing some of your drives together instead, yes -- memory & CPU utilization is one of the trade offs there, balanced against larger discrete failure units and the loss of space or reliability (depending on the RAID chosen).
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com



