From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-users] Ceph + RBD + Xen: Complete collapse -> Network issue
 in domU / Bad data for OSD / OOM Kill
Date: Mon, 3 Sep 2012 11:24:00 +0200
Message-ID: <CAF6-1L6FkkGTE25bXVYVHbMA7U86igx9HgjPRmXCAR2274p=dg@mail.gmail.com>
References: <CAF6-1L5t9CGk_kB08UPKdrOhQeZZXdbr5n+we1Oae+STpodxtg@mail.gmail.com>
	<503F7C25.2000303@inktank.com>
	<CAG1y0scr2T2vbhVBm4nMttAtZJ+H_3q2zoCCtjTUyPQeyXj7XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38145 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab2ICJYB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Sep 2012 05:24:01 -0400
Received: by vcbfk26 with SMTP id fk26so5238010vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 02:24:00 -0700 (PDT)
In-Reply-To: <CAG1y0scr2T2vbhVBm4nMttAtZJ+H_3q2zoCCtjTUyPQeyXj7XA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Fajar A. Nugraha" <list@fajar.net>
Cc: Alex Elder <elder@inktank.com>, xen-users@lists.xen.org, ceph-devel@vger.kernel.org

On Thu, Aug 30, 2012 at 5:04 PM, Fajar A. Nugraha <list@fajar.net> wrote:
> On Thu, Aug 30, 2012 at 9:43 PM, Alex Elder <elder@inktank.com> wrote:
>> On 08/30/2012 09:06 AM, Sylvain Munaut wrote:
>>> Hi,
>>
>> I posted the following comments on IRC but am putting it here
>> just so it's visible along with the original post.  All of the
>> following is deduced from about 10 minutes of scanning through
>> unfamiliar code, so I may be way off.  (I've edited my the
>> comments I posted for readability.)
>>
>> The code is in drivers/net/xen-netfront.c, in the function
>> xennet_get_responses().
>
> IIRC that's the xen PV driver.

I've been digging a bit and it seems issuing a

ethtool -K vif1.0 tx off

in the dom0 prevents the issue.

Note that it needs to be in the dom0 on the VIF and not in the domU on
the eth0 interface like I originally tried. It's also not enough to
disable gso and/or tso, you need to turn off all tx accel.

I will start another subject in xen-devel seems it appears to be a bug
in the PV driver.


Cheers,

    Sylvain
