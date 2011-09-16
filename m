From: Sage Weil <sage@newdream.net>
Subject: Re: ceph kernel bug
Date: Fri, 16 Sep 2011 11:22:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109161120480.11043@cobra.newdream.net>
References: <4E6BD2B4.7050709@tuxadero.com> <Pine.LNX.4.64.1109101546370.19147@cobra.newdream.net>
 <4E6BF6C3.5010202@tuxadero.com> <4E7254D6.9020509@tuxadero.com>
 <Pine.LNX.4.64.1109151302160.17623@cobra.newdream.net> <4E7269D1.6010804@tuxadero.com>
 <Pine.LNX.4.64.1109151551250.27715@cobra.newdream.net> <4E731147.6010405@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46520 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab1IPSQ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 14:16:29 -0400
In-Reply-To: <4E731147.6010405@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Hi Martin,

Thanks, this was enough to help me reproduce it, and I believe I have a 
correct fix (it's working for me).  Can you try commit 935b639 'libceph: 
fix linger request requeuing' (for-linus branch of 
git://github.com/NewDreamNetwork/ceph-client.git) and confirm that it 
fixes things for you as well?

Thanks!
sage


On Fri, 16 Sep 2011, Martin Mailand wrote:

> Hi Sage,
> I rerun the test and I think I triggered the first bug again.
> http://pastebin.com/ydNm0pff
> 
> I did also the dumps for you.
> http://tuxadero.com/multistorage/ceph.ko_dump
> http://tuxadero.com/multistorage/libceph.ko_dump
> 
> Best Regards,
>  martin
> Am 16.09.2011 00:54, schrieb Sage Weil:
> > On Thu, 15 Sep 2011, Martin Mailand wrote:
> > > Hi Sage,
> > > that's quite a bit of output, I put it in a pastebin.
> > > http://pastebin.com/9CNJk0Pw.
> > Any chance you can include the output of 'objdump -rdS libceph.ko'?
> > ceph.ko too, for good measure.
> > 
> > This looks like a sightly different crash than the one on that bug!
> > 
> > Thanks!
> > sage
> > 
> > 
> > > Best Regards,
> > >   martin
> > > 
> > > Sage Weil schrieb:
> > > > On Thu, 15 Sep 2011, Martin Mailand wrote:
> > > > > Hi Sage,
> > > > > I am still hitting this in -rc6. It happeneds every time I stop an
> > > > > OSD.
> > > > > Do you need more information to reproduce it?
> > > > Oh, great to hear it's easy to reproduce!  I was trying (in my uml
> > > > environment) and failing.
> > > > 
> > > > Can run the script below right before stopping the osd, and send the
> > > > dmesg
> > > > output along?  (Or attach to http://tracker.newdream.net/issues/1382)
> > > > 
> > > > Thanks!
> > > > sage
> > > > 
> > > > 
> > > > #!/bin/sh -x
> > > > 
> > > > p() {
> > > >   echo "$*">  /sys/kernel/debug/dynamic_debug/control
> > > > }
> > > > 
> > > > p 'module ceph +p'
> > > > p 'module libceph +p'
> > > > p 'module rbd +p'
> > > > p 'file net/ceph/messenger.c -p'
> > > > p 'file' `grep -- --- /sys/kernel/debug/dynamic_debug/control | grep
> > > > ceph \
> > > > 	| awk '{print $1}' | sed 's/:/ line /'` '+p'
> > > > p 'file' `grep -- === /sys/kernel/debug/dynamic_debug/control | grep
> > > > ceph \
> > > > 	| awk '{print $1}' | sed 's/:/ line /'` '+p'
> > > > 
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
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
