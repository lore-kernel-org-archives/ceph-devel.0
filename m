From: Sage Weil <sage@newdream.net>
Subject: Re: CRUSH algorithm and its debug method
Date: Mon, 3 Oct 2016 14:21:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610031421000.19850@piezo.us.to>
References: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com> <alpine.DEB.2.11.1610031319090.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34266 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbcJCOVg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Oct 2016 10:21:36 -0400
In-Reply-To: <alpine.DEB.2.11.1610031319090.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 3 Oct 2016, Sage Weil wrote:
> > 2. Currently, the reweight params in crushmap is memoryless (e.g we
> > balance our data by reducing reweight, which will be lost after this
> > osd DOWN and OUT automatically. And we mark its IN again because
> > currently ceph osd in directly marks the reweight to 1.0 and out marks
> > the reweight to 0.0).  It is quite awkward when we use ceph osd
> > reweight-by-utilization to make data balance (If some osds down and
> > out, our previous effort is totally lost).   So I think marking osd
> > "in"  does not simply modify reweight to "1.0". Actually, we can
> > iteration the previous osdmap and find out the value of the reweight
> > or records it anywhere we can retrieve this value again?
> 
> The old value is stored here
> 
> https://github.com/ceph/ceph/blob/master/src/osd/OSDMap.h#L89
> 
> and restored when the OSD is marked back up, although IIRC there is a 
> config option that controls when the old value is stored (it might only 
> happen when the osd is marked out automatically, not when it is done 
> manually?).  That behavior could be changed, though.

...and I just found this sitting on my todo list.  Here is a fix:

	https://github.com/ceph/ceph/pull/11293

sage
