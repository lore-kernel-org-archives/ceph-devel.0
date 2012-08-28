From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Mapping between PG & OSD
Date: Tue, 28 Aug 2012 08:24:00 -0700
Message-ID: <CADvuQRHoNP2anO0KVS8uaiU-cR+ELAfS2JiP-JgYwy=e_a3DSQ@mail.gmail.com>
References: <CAGfy=6=6uuw=eGLxTO7Uk_uFi=1FzyhToMXUN8izXjRyHWEWmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54589 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752865Ab2H1PYW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Aug 2012 11:24:22 -0400
Received: by lagy9 with SMTP id y9so3367339lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 08:24:20 -0700 (PDT)
In-Reply-To: <CAGfy=6=6uuw=eGLxTO7Uk_uFi=1FzyhToMXUN8izXjRyHWEWmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 27, 2012 at 11:50 PM, hemant surale <hemant.surale@gmail.com> wrote:
> Hi All ,
>       I was unable to figure out how we can direct the ceph to store
> data based on host needs i.e. Host A wants to keep frequently used
> data on its own local OSD. So my question is about how we can direct
> such write/read requests to local OSD than on network? Is it possible
> ?

Due to the nature of CRUSH -- being a deterministic pseudorandom
distribution and all -- the writer does not get to choose where n
object is stored.

The closest thing you can do is have a RADOS pool with a CRUSH ruleset
that puts the primary on that machine. As you'd need a pool per
machine, this really doesn't scale up well.

Perhaps the benefits of the scheme you are envisioning aren't as great
as you think they would be. Often accessing lots of fast servers over
a fast network performs better than a single local disk.
