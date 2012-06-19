From: Sage Weil <sage@inktank.com>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 08:42:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206190840550.21853@cobra.newdream.net>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro> <4FE01CE7.8000204@profihost.ag>
 <4FE0782A.1060104@inktank.com> <4FE07B2A.7080209@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35867 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2FSPmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 11:42:31 -0400
In-Reply-To: <4FE07B2A.7080209@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Tue, 19 Jun 2012, Stefan Priebe - Profihost AG wrote:
> Am 19.06.2012 15:01, schrieb Mark Nelson:
> > On 06/19/2012 01:32 AM, Stefan Priebe - Profihost AG wrote:
> > > Am 19.06.2012 06:41, schrieb Alexandre DERUMIER:
> > > > Hi Stephann
> > > > recommandations are 30-50 PGS by osd if I remember.
> > > > 
> > > rbd, data and metadata have 2176 PGs with 12 OSD. This is 181,333333333
> > > per OSD?!
> > > 
> > > Stefan
> > 
> > That's probably fine, it just means that you will have a better
> > pseudo-random distribution of OSD combinations (It does have higher
> > cpu/memory overhead though). Figuring out how many PGs you should have
> > per OSD depends on a lot of factors including how many OSDs you have,
> > how many nodes, CPU, memory, etc. I'm guessing ~180 per OSD won't cause
> > problems. On the other hand, with low OSD counts you could probably have
> > fewer and be fine too.
> 
> But this number 2176 of PGs were set while doing mkcephfs - how is it
> calculated?

	num_pgs = num_osds << osd_pg_bits

which is configurable via --osd-pg-bits N or ceph.conf (at mkcephfs time).  
The default is 6.

sage
