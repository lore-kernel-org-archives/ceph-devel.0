From: Sage Weil <sage@newdream.net>
Subject: Re: CRUSH algorithm and its debug method
Date: Mon, 3 Oct 2016 13:22:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610031319090.19850@piezo.us.to>
References: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33935 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbcJCNWb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Oct 2016 09:22:31 -0400
In-Reply-To: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi!

On Sat, 1 Oct 2016, Ning Yao wrote:
> Hi, Sage
> 
> I find that several issues related to current CRUSH algorithm as below:
> 
> 1. It is possible to select out the same collision and retry bucket in
> a crush_choose_firstn() loop. (e.g.  when we set reweight to 0 or mark
> osd out, it would be definitely rejected if it is selected. However,
> when the second chance to select out another one based on the
> different r', it is still possible to select out the same osd
> previously rejected, right? And until a different one is selected
> after several retries.).  I think we can record those rejected or
> collision osds in the same loop so that the process can be converged
> much faster?

It's sitll possible to pick the same thing with a different r'.  
That's why the max retries values has to be reasonably high.  I'm not sure 
how you would avoid doing the full calculation, though... can you be 
more specific?
 
> 2. Currently, the reweight params in crushmap is memoryless (e.g we
> balance our data by reducing reweight, which will be lost after this
> osd DOWN and OUT automatically. And we mark its IN again because
> currently ceph osd in directly marks the reweight to 1.0 and out marks
> the reweight to 0.0).  It is quite awkward when we use ceph osd
> reweight-by-utilization to make data balance (If some osds down and
> out, our previous effort is totally lost).   So I think marking osd
> "in"  does not simply modify reweight to "1.0". Actually, we can
> iteration the previous osdmap and find out the value of the reweight
> or records it anywhere we can retrieve this value again?

The old value is stored here

https://github.com/ceph/ceph/blob/master/src/osd/OSDMap.h#L89

and restored when the OSD is marked back up, although IIRC there is a 
config option that controls when the old value is stored (it might only 
happen when the osd is marked out automatically, not when it is done 
manually?).  That behavior could be changed, though.

> 3. Currently, there is no debug option in the mapping progress in
> Mapper.c. dprintk is default disabled so that it will be hard to dig
> into the algorithm if something unexpected result happens. I think we
> can introduce the debug options and output the debug information when
> we use "ceph osd map xxx xxx" so that it is much more easier to find
> the shortness in current mapping process?

Yeah, it's hard to debug.  I usually uncomment the dprintk define and 
rebuild osdmaptool, which has a --test-map-pg option so that I can run 
a specific problematic mapping.  We could do something a bit more clever 
as long as it is a simple conditional--we don't want to slow down the 
mapping code as it is performance sensitive.

Thanks!
sage
