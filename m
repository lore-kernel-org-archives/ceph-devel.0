From: "Fajar A. Nugraha" <list@fajar.net>
Subject: Re: [Xen-users] Ceph + RBD + Xen: Complete collapse -> Network issue
 in domU / Bad data for OSD / OOM Kill
Date: Thu, 30 Aug 2012 22:04:46 +0700
Message-ID: <CAG1y0scr2T2vbhVBm4nMttAtZJ+H_3q2zoCCtjTUyPQeyXj7XA@mail.gmail.com>
References: <CAF6-1L5t9CGk_kB08UPKdrOhQeZZXdbr5n+we1Oae+STpodxtg@mail.gmail.com>
	<503F7C25.2000303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34963 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab2H3PEq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 11:04:46 -0400
Received: by qcro28 with SMTP id o28so1314784qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 08:04:46 -0700 (PDT)
In-Reply-To: <503F7C25.2000303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, xen-users@lists.xen.org, ceph-devel@vger.kernel.org

On Thu, Aug 30, 2012 at 9:43 PM, Alex Elder <elder@inktank.com> wrote:
> On 08/30/2012 09:06 AM, Sylvain Munaut wrote:
>> Hi,
>
> I posted the following comments on IRC but am putting it here
> just so it's visible along with the original post.  All of the
> following is deduced from about 10 minutes of scanning through
> unfamiliar code, so I may be way off.  (I've edited my the
> comments I posted for readability.)
>
> The code is in drivers/net/xen-netfront.c, in the function
> xennet_get_responses().

IIRC that's the xen PV driver.

A simple way to test whether xen pv net device is at fault is to use a
HVM domU but WITHOUT the pv drivers (there's a kernel commandline
argument that lets you have both emulated and PV device in the domU),
using the emulated NIC instead (e.g. e1000).

... and further investigation result might be more useful to
@xen-devel instead of @xen-users.

-- 
Fajar
