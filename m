From: Sage Weil <sage@inktank.com>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Thu, 6 Dec 2012 06:43:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212060615100.13653@cobra.newdream.net>
References: <50BF1A43.4060605@profihost.ag> <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net> <BC8B71E3-1BE1-49ED-B578-34A0CBACAB98@profihost.ag> <alpine.DEB.2.00.1212051534530.14332@cobra.newdream.net> <50C0677B.4090400@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49720 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423553Ab2LFOng (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Dec 2012 09:43:36 -0500
In-Reply-To: <50C0677B.4090400@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 6 Dec 2012, Stefan Priebe - Profihost AG wrote:
> Hi,
> 
> here a new dump / crash:
> https://www.dropbox.com/s/1qhg0dd0fv17q10/ceph-osd.54.log.gz

Awesome, thanks!  I see the bug now.  Working out a fix.

In the meantime, you can revert 85574a36226611ccf0fb7591fd275a2bdcca2bad 
and 528108485be7912069087822e5b7a1a2f1dd515e.

sage


> 
> Stefan
> 
> Am 06.12.2012 00:36, schrieb Sage Weil:
> > On Wed, 5 Dec 2012, Stefan Priebe - Profihost AG wrote:
> > > There was a dump in the attached log.
> > 
> > The stack trace is there, but with 'debug journal = 0/20' in your conf it
> > will also dump all of the journal logging activity leading up to that
> > point.  Can you reproduce with that enabled?  That should tell me why op <
> > commited_seq.
> > 
> > Thanks!
> > sage
> > 
> > 
> > > 
> > > Stefan
> > > 
> > > Am 05.12.2012 um 15:41 schrieb Sage Weil <sage@inktank.com>:
> > > 
> > > > On Wed, 5 Dec 2012, Stefan Priebe - Profihost AG wrote:
> > > > > Hello list,
> > > > > 
> > > > > i updated to latest next from today and then after 20 minutes an OSD
> > > > > was
> > > > > crashing in os/JournalingObjectStore.cc.
> > > > > 
> > > > > Attached is the log.
> > > > 
> > > > Hmm, this is perplexing.  It might just be a bad assert, but I can't see
> > > > how it could happen.  Any chance you can reproduce with
> > > > 
> > > >     debug journal = 0/10
> > > > 
> > > > in the [osd] section?  That will give us a dump if it fails the assert.
> > > > 
> > > > Thanks!
> > > > s
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
