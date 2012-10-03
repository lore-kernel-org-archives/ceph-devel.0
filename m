From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Collection of strange lockups on 0.51
Date: Thu, 4 Oct 2012 01:33:38 +0400
Message-ID: <CABYiri-ZkrZnbEzE9jZ_EBjVjxKtBEB9w4SZRmQ7s7SYQUGxgQ@mail.gmail.com>
References: <CABYiri8t9yXQ39WOW1+Rib5jxp8qUCUY8iSht=p2PSQZtn3ZEA@mail.gmail.com>
 <CADvuQRFMaGpH9MdFHDDworDMEePsj=vn1A6vbE0b0G6+oS41Lg@mail.gmail.com>
 <CABYiri_ujogFa==21ty3eWhDGx7PMK-F4Rya0kJEF-RQTsBNQQ@mail.gmail.com>
 <CABYiri8pCTjJu1-2LzBJtxQe9cHBMqa51MSAkvf8LTWpm_P+Tw@mail.gmail.com> <CADvuQRHPF2Sehm-crtherpRvm3db4humUsqyJnL5x3X=dxGYhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64790 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab2JCVd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 17:33:59 -0400
Received: by weyt9 with SMTP id t9so4607257wey.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 14:33:58 -0700 (PDT)
In-Reply-To: <CADvuQRHPF2Sehm-crtherpRvm3db4humUsqyJnL5x3X=dxGYhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 1, 2012 at 8:42 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Sun, Sep 30, 2012 at 2:55 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> Short post mortem - EX3200/12.1R2.9 may begin to drop packets (seems
>> to appear more likely on 0.51 traffic patterns, which is very strange
>> for L2 switching) when a bunch of the 802.3ad pairs, sixteen in my
>> case, exposed to extremely high load - database benchmark over 700+
>> rbd-backed VMs and cluster rebalance at same time. It explains
>> post-reboot lockups in igb driver and all types of lockups above. I
>> would very appreciate any suggestions of switch models which do not
>> expose such behavior in simultaneous conditions both off-list and in
>> this thread.
>
> I don't see how a switch dropping packets would give an ethernet card
> driver any excuse to crash, but I'm simultaneously happy to hear that
> it doesn't seem like Ceph is at fault, and sorry for your troubles.
>
> I don't have an up to date 1GbE card recommendation to share, but I
> would recommend making sure you're using a recent Linux kernel.

I have incorrectly formulated a reason - of course drops can not cause
a lockup by themselves, but switch may create somehow a long-lasting
`corrupt` state on the trunk ports which leads to such lockups at the
ethernet card. Of course I`ll play with the driver versions and
card|port settings, thanks for suggestion :)

I`m still investigating the issue since it is a quite hard to repeat
in the right time and hope I`m able to capture this state using
tcpdump-like, e.g. s/w methods - if card driver locks on something, it
may prevent to process problematic byte sequence at packet sniffer level.
