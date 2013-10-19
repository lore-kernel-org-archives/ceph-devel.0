From: Sage Weil <sage@inktank.com>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Fri, 18 Oct 2013 17:01:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310181657151.19763@cobra.newdream.net>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com> <alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net> <20131017151828.GB28859@redhat.com> <CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57502 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab3JSAB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Oct 2013 20:01:27 -0400
In-Reply-To: <CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: Mike Snitzer <snitzer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, linux-lvm@redhat.com

On Fri, 18 Oct 2013, Ugis wrote:
> > Ugis, please provide the output of:
> >
> > RBD_DEVICE=<rbd device name>
> > pvs -o pe_start $RBD_DEVICE
> > cat /sys/block/$RBD_DEVICE/queue/minimum_io_size
> > cat /sys/block/$RBD_DEVICE/queue/optimal_io_size
> >
> > The 'pvs' command will tell you where LVM aligned the start of the data
> > area (which follows the LVM metadata area).  Hopefully it reflects what
> > was published in sysfs for rbd's striping.
> 
> output follows:
> #pvs -o pe_start /dev/rbd1p1
>   1st PE
>     4.00m
> # cat /sys/block/rbd1/queue/minimum_io_size
> 4194304
> # cat /sys/block/rbd1/queue/optimal_io_size
> 4194304

Well, the parameters are being set at least.  Mike, is it possible that 
having minimum_io_size set to 4m is causing some read amplification 
in LVM, translating a small read into a complete fetch of the PE (or 
somethinga long those lines)?

Ugis, if your cluster is on the small side, it might be interesting to see 
what requests the client is generated in the LVM and non-LVM case by 
setting 'debug ms = 1' on the osds (e.g., ceph tell osd.* injectargs 
'--debug-ms 1') and then looking at the osd_op messages that appear in 
/var/log/ceph/ceph-osd*.log.  It may be obvious that the IO pattern is 
different.

> Seems correct in terms of ceph-LVM io parameter negotiation? I wonded
> about gpt header+PV metadata - it makes some shift starting from ceph
> 1st block beginning. Does this mean that all following LVM 4m data
> blocks are shifted by this part and span 2 ceph objects?
> If so, performance will be affected.

I'm no LVM expert, but I would guess that LVM is aligning things properly 
based on the above device properties...

sage
