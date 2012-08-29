From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Mapping between PG & OSD
Date: Wed, 29 Aug 2012 07:08:06 -0400
Message-ID: <CADvuQRFfot9OAYv-9MH5sYi1GPfboJHQ0JcRLfH5QeVnksVX0Q@mail.gmail.com>
References: <CAGfy=6=6uuw=eGLxTO7Uk_uFi=1FzyhToMXUN8izXjRyHWEWmQ@mail.gmail.com>
 <CADvuQRHoNP2anO0KVS8uaiU-cR+ELAfS2JiP-JgYwy=e_a3DSQ@mail.gmail.com> <CAGfy=6nWN0=dCPLUv=Bo5jig_Q21pFa=H=qdkEhDRXNcoZ6R+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56026 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab2H2LI1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 07:08:27 -0400
Received: by vbbff1 with SMTP id ff1so424068vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 04:08:26 -0700 (PDT)
In-Reply-To: <CAGfy=6nWN0=dCPLUv=Bo5jig_Q21pFa=H=qdkEhDRXNcoZ6R+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 29, 2012 at 12:46 AM, hemant surale <hemant.surale@gmail.com> wrote:
> Hi Tommi ,
>       Actually I was thinking of "Availability" of related files to
> particular host. I wanted to guide ceph in some way to store related
> files for host on his local osd so that I/O over network can be
> reduced .

That sort of a design is only possible if you have a lookup table for
data locations, like e.g. HDFS does. Which has it's own problems,
causing a lot of lookup traffic and contention. CRUSH means data
placement does not depend on the origin of the data, only on the
object name and CRUSH ruleset.

Frankly, if you're thinking about single machines, you're probably
thinking at a smaller scale than what Ceph is aimed at.

> One more doubt I would like to ask is Whether read/write
> requests are sent to primary only Or only write requests are sent to
> primary while read request can be served by any OSD having object
> replica ?

Writes are sent to the primary, which sends them on to all the
replicas. Read requests are served by the primary also. There has been
some interest in reading from any replica, especially in the Hadoop
world, but as far as I remember that feature is not implemented.
