From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: Cluster Network & Public Network w.r.t XIO ?
Date: Mon, 3 Aug 2015 09:43:42 -0700
Message-ID: <CAFkUHxcJH1xwY2AdNYTbwhjzWjaZYjBL9i4HwwZai7zTh8k5KA@mail.gmail.com>
References: <20150801001253.GE2358@pika.private.linuxbox.com>
	<alpine.DEB.2.00.1507311805080.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33338 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbHCQnn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 12:43:43 -0400
Received: by pdbnt7 with SMTP id nt7so75953652pdb.0
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 09:43:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507311805080.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Marcus Watts <mwatts@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, vu@mellanox.com, raju kurunkad <raju.kurunkad@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Marcus & Matt. I will take a look at it this week.

-Neo

On Fri, Jul 31, 2015 at 6:07 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 31 Jul 2015, Marcus Watts wrote:
>> I promised information on my copy of wip-address.  It's not in as
>> good a shape as I promised-- got pulled onto something else, so
>> the last commit I made left it not building.  And it will definitely
>> need more past that.
>>
>> So here's where it lives right now,
>> repo
>> git@github.com:linuxbox2/linuxbox-ceph.git
>> branch
>> xio-firefly-mpc1
>>
>> This is definitely on my "todo" list, and I plan to work on it next week.
>>
>> I also plan to push a copy of this or something much like it, as a wip
>> branch to the main ceph git, as soon as practical.
>
> As a first step I'd rebase on master as any cleanup work done before
> that'll probably get shredded by the rebase conflicts.  This one is
> tedious unfortunately since every encode needs that features arg.  :(
>
> Thanks, Marcus!
> sage
