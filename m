From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Collection of strange lockups on 0.51
Date: Mon, 1 Oct 2012 09:42:22 -0700
Message-ID: <CADvuQRHPF2Sehm-crtherpRvm3db4humUsqyJnL5x3X=dxGYhw@mail.gmail.com>
References: <CABYiri8t9yXQ39WOW1+Rib5jxp8qUCUY8iSht=p2PSQZtn3ZEA@mail.gmail.com>
 <CADvuQRFMaGpH9MdFHDDworDMEePsj=vn1A6vbE0b0G6+oS41Lg@mail.gmail.com>
 <CABYiri_ujogFa==21ty3eWhDGx7PMK-F4Rya0kJEF-RQTsBNQQ@mail.gmail.com> <CABYiri8pCTjJu1-2LzBJtxQe9cHBMqa51MSAkvf8LTWpm_P+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62899 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab2JAQmn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 12:42:43 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so6078qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 09:42:42 -0700 (PDT)
In-Reply-To: <CABYiri8pCTjJu1-2LzBJtxQe9cHBMqa51MSAkvf8LTWpm_P+Tw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Sep 30, 2012 at 2:55 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Short post mortem - EX3200/12.1R2.9 may begin to drop packets (seems
> to appear more likely on 0.51 traffic patterns, which is very strange
> for L2 switching) when a bunch of the 802.3ad pairs, sixteen in my
> case, exposed to extremely high load - database benchmark over 700+
> rbd-backed VMs and cluster rebalance at same time. It explains
> post-reboot lockups in igb driver and all types of lockups above. I
> would very appreciate any suggestions of switch models which do not
> expose such behavior in simultaneous conditions both off-list and in
> this thread.

I don't see how a switch dropping packets would give an ethernet card
driver any excuse to crash, but I'm simultaneously happy to hear that
it doesn't seem like Ceph is at fault, and sorry for your troubles.

I don't have an up to date 1GbE card recommendation to share, but I
would recommend making sure you're using a recent Linux kernel.
