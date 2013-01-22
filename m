From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Tue, 22 Jan 2013 22:19:14 +0100
Message-ID: <CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:42281 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3AVVTg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:19:36 -0500
Received: by mail-lb0-f170.google.com with SMTP id ge1so2007543lbb.15
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:19:34 -0800 (PST)
In-Reply-To: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I originally started a thread around these memory leaks problems here:
http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg11000.html

I'm happy to see that someone supports my theory about the scrubbing
process leaking the memory. I only use RBD from Ceph, so your theory
makes sense as well. Unfortunately, since I run a production platform
I don't really want to try the mem profiler, I had quite a bad
experience with it on a test cluster. While running the profiler some
OSD crashed...
The only way to fix this is to provide a heap dump. Could you provide o=
ne?

Moreover I can't reproduce the problem on my test environment... :(

--
Regards,
S=E9bastien Han.


On Tue, Jan 22, 2013 at 9:01 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
> Since I have ceph in prod, I experienced a memory leak in the OSD
> forcing to restart them every 5 or 6 days. Without that the OSD
> process just grows infinitely and eventually gets killed by the OOM
> killer. (To make sure it wasn't "legitimate", I left one grow up to 4=
G
> or RSS ...).
>
> Here's for example the RSS usage of the 12 OSDs process
> http://i.imgur.com/ZJxyldq.png during a few hours.
>
> What I've just noticed is that if I look at the logs of the osd
> process right when it grows, I can see it's scrubbing PGs from pool
> #3. When scrubbing PGs from other pools, nothing really happens memor=
y
> wise.
>
> Pool #3 is the pool where I have all the RBD images for the VMs and s=
o
> have a bunch of small read/write/modify. The other pools are used by
> RGW for object storage and are mostly write-once,read-many-times of
> relatively large objects.
>
> I'm planning to upgrade to 0.56.1 this week end and I was hoping to
> see if someone knew if that issue had been fixed with the scrubbing
> code ?
>
> I've seen other posts about memory leaks but at the time, it wasn't
> confirmed what was the source. Here I clearly see it's the scrubbing
> on pools that have RBD image.
>
> Cheers,
>
>       Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
