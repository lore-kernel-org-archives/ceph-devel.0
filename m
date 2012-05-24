From: Greg Farnum <greg@inktank.com>
Subject: Re: how to free space from rados bench comman?
Date: Thu, 24 May 2012 10:55:18 -0700
Message-ID: <986F41761DD1467EA38C8C853CFE8160@inktank.com>
References: <4FBDDCAE.7040709@profihost.ag> <4FBDE314.7030305@widodh.nl>
 <4FBDE57F.9010409@profihost.ag> <4FBDEFB0.3030700@widodh.nl>
 <4FBDF691.3070601@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63394 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758845Ab2EXRzY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 13:55:24 -0400
Received: by dady13 with SMTP id y13so65081dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 10:55:24 -0700 (PDT)
In-Reply-To: <4FBDF691.3070601@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Wido den Hollander <wido@widodh.nl>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, May 24, 2012 at 1:51 AM, Stefan Priebe - Profihost AG wrote:
> Am 24.05.2012 10:22, schrieb Wido den Hollander:
> > On 24-05-12 09:38, Stefan Priebe - Profihost AG wrote:
> > > 
> > > ~# rados -p data ls|wc -l
> > > 46631
> > 
> > 
> > 
> > That is weird, I thought the bench tool cleaned up it's "mess".
> > 
> > Imho it should cleanup after it's done, but there might be a reason why
> > it's not. Did you abort the benchmark or did you let it do the whole run?
> 
> 
> No it doesn't BUG?
It doesn't because you might want to leave around the data for read benchmarking (or so that your cluster is full of data).
There should probably be an option to clean up bench data, though! I've created a bug: http://tracker.newdream.net/issues/2477
 
> 
> ~# rados -p data ls
> ~#
> ~# rados -p data bench 20 write -t 16
> ...
> ~# rados -p data ls| wc -l
> 589
> 
> > > I do not use the data pool so it is seperate ;-) i only use the rbd pool
> > > for block devices.
> > > 
> > > So i will free the space with:
> > > for i in `rados -p data ls`; do echo $i; rados -p data rm $i; done
> > 
> > 
> > 
> > rados -p data ls|xargs -n 1 rados -p data rm
> > 
> > I love shorter commands ;)
> me too i just tried it without -n and hoped that this works but rados
> didn't support more than 1 file per command and i didn't remembered -n1 ;)
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



