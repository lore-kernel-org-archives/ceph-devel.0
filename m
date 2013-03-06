From: Martin B Nielsen <martin@unity3d.com>
Subject: Re: [ceph-users] Using different storage types on same osd hosts?
Date: Wed, 6 Mar 2013 09:58:08 +0100
Message-ID: <CAD3n6hFUg0ks-V=XVTA+u+NLcM_ADEqhD7Nk_rx-A3FrWqLBuQ@mail.gmail.com>
References: <51365A16.4020103@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:50169 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CFI6J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 03:58:09 -0500
Received: by mail-qa0-f54.google.com with SMTP id hg5so2395472qab.6
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 00:58:08 -0800 (PST)
In-Reply-To: <51365A16.4020103@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-users <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We did the opposite here; adding some SSD in free slots after having a
normal cluster running with SATA.

We just created a new pool for them and separated the two types. I
used this as a template:
http://ceph.com/docs/master/rados/operations/crush-map/?highlight=ssd#placing-different-pools-on-different-osds
and left out the part with placing a master copy on each ssd.

I had to create the pool, rack and host in the crush rules for the
first server (wouldn't let me from the command line using 'ceph osd
crush set ...'), after that I could just add servers/osd to it like
normal.

I think unless you really need two separate clusters, I'd go with just
having different pools for it; you'll need a copy of every service
(mons, storagenodes etc) with two clusters.

More info on running multiple clusters here:
http://ceph.com/docs/master/rados/configuration/ceph-conf/#running-multiple-clusters

Cheers,
Martin

On Tue, Mar 5, 2013 at 9:48 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi,
>
> right now i have a bunch of OSD hosts (servers) which have just 4 disks
> each. All of them use SSDs right now.
>
> So i have a lot of free harddisk slots in the chassis. So my idea was to
> create a second ceph system using these free slots. Is this possible? Or
> should i just the first one with different rules? Any hints?
>
> Greets,
> Stefan
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
