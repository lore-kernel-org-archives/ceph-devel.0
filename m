From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 08 Jun 2012 19:15:26 +0200
Message-ID: <2194809.KXWDOvK1M7@pc10>
References: <21601270.dfB0BsVfyn@pc10> <Pine.LNX.4.64.1206080652031.10292@cobra.newdream.net> <4FD2113C.3070906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:54999 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab2FHRPb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Jun 2012 13:15:31 -0400
In-Reply-To: <4FD2113C.3070906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, ceph-devel@vger.kernel.org

Am Freitag, 8. Juni 2012, 07:50:36 schrieb Josh Durgin:
> On 06/08/2012 06:55 AM, Sage Weil wrote:
> > On Fri, 8 Jun 2012, Oliver Francke wrote:
> >> Hi Guido,
> >> 
> >> yeah, there is something weird going on. I just started to establish some
> >> test-VM's. Freshly imported from running *.qcow2 images.
> >> Kernel panic with INIT, seg-faults and other "funny" stuff.
> >> 
> >> Just added the rbd_cache=true in my config, voila. All is
> >> fast-n-up-n-running...
> >> All my testing was done with cache enabled... Since our errors all came
> >> from rbd_writeback from former ceph-versions...
> > 
> > Are you guys able to reproduce the corruption with 'debug osd = 20' and
> > 
> > 'debug ms = 1'?  Ideally we'd like to:
> >   - reproduce from a fresh vm, with osd logs
> >   - identify the bad file
> >   - map that file to a block offset (see
> >   
> >     http://ceph.com/qa/fiemap.[ch], linux_fiemap.h)
> >   
> >   - use that to identify the badness in the log
> > 
> > I suspect the cache is just masking the problem because it submits fewer
> > IOs...
> 
> The cache also doesn't do sparse reads. Is it still reproducible with
> a fresh vm when you set filestore_fiemap_threshold = 0 for the osds,
> and run without rbd caching?

I have set filestore_fiemap_threshold = 0 on all osds and restarted them. The 
problem is still there, and so bad I cannot even run this fiemap utility that 
Sage posted. I guess I should have tried booting the VM from a livecd 
instead...

	Guido
