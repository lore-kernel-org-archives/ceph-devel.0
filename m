From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Intermittent loss of connectivity with KVM-Ceph-Network (solved)
Date: Tue, 17 Jul 2012 09:24:44 -0700
Message-ID: <CADvuQRGYoEm2yzw=rQ+pLLSDvBH7xSRpSwHGyfgmxoR9P-qt5Q@mail.gmail.com>
References: <5004B022.1070805@australianjade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63398 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab2GQQZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 12:25:06 -0400
Received: by yenl2 with SMTP id l2so564244yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 09:25:05 -0700 (PDT)
In-Reply-To: <5004B022.1070805@australianjade.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Australian Jade <sales@australianjade.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 16, 2012 at 5:21 PM, Australian Jade
<sales@australianjade.com> wrote:
> all in vain. I also noticed that when hold up on interface happened pings
> come back with second difference: ie they piling up on interface and then
> suddenly sent through all at once and remote host returns all of them pretty
> much simultaneously. Another observation which I have made: this behaviour

That sounds like an interrupt (or some virtualized equivalent of one)
going across the vm-hypervisor boundary is getting lost.

I've actually seen that symptom with actual hardware, back in the day,
when driver bugs turned off the NICs interrupt handling too
heavyhandedly. The queues were still polled once a second..
