From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Ceph Best Practices
Date: Mon, 12 Dec 2011 13:45:25 -0800
Message-ID: <CAORUGqB_7PaJOpgX+g2QBg3cFoGgJFFW=bA6h61d3HmFeUnKqw@mail.gmail.com>
References: <CABGLbPHXtga0tXYRrF=bLmtJK1U439TDZkEXsvBkc=LFyFiaDg@mail.gmail.com>
 <CABGLbPHuo52tUSWWSt2=fbLNK1FoeLM-qALHKmUfb4P9T6gcZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49510 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1LLVpr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2011 16:45:47 -0500
Received: by faar15 with SMTP id r15so1756717faa.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2011 13:45:46 -0800 (PST)
In-Reply-To: <CABGLbPHuo52tUSWWSt2=fbLNK1FoeLM-qALHKmUfb4P9T6gcZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steven Crothers <steven.crothers@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Dec 5, 2011 at 13:47, Steven Crothers <steven.crothers@gmail.com> wrote:
> I have a quick question about the way to layout disks in the OSDs. I
> can't really find the information I'm looking for on the Wiki or in
> the existing mailing list archives that I have saved (4-5months
> worth).
>
> In the even a large OSD is being build (say 20 drives, same make/model
> 2TB). How would you build the OSD? Is it best to format each disk
> individually or build them into a raid group? Is there performance
> benefits to having each disk setup individually or perhaps having X
> amount of raid groups on the system?

You are entering a zone where answers depend on a lot of variables.
There is no single "do it this way" answer, it's a series of
tradeoffs. Which ones make most sense to you depend on hardware
features such as RAM size, expected usage patterns, risk tolerance,
performance requirements, etc.

To simplify, it's a tradeoff between these two:

1. Each OSD is a failure containment mechanism. If you only run 1 OSD
per server, that server will always fail as a whole, taking out a
whole lot of data at once, and causing a lot of repair traffic. So
more OSDs is better.

2. Lots of OSDs on a single server can mean they all spike in CPU&RAM
consumption at once, e.g. after a restart of the whole server. 20 OSDs
could consume quite of a lot of RAM at that point.

You're probably best off with something in between those two. Group a
handful of disks together, have multiple of these groups, run an OSD
per each group. Whether you use RAID or btrfs pools is largely a
question of reliability etc.

The only possible full answer is this: Follow the requirements you
have for reliability, then benchmark the alternatives.

We're currently hiring sales engineers etc to help people build
clusters, and we're hiring people to run benchmarks of various
configurations so we can provide more concrete recommendations.
