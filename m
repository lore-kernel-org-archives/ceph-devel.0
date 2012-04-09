From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: defaults paths #2
Date: Mon, 9 Apr 2012 12:22:35 -0700
Message-ID: <CAORUGqC2M-d4wCHbboMCsozsqQsk5zKhv_fotWZ4hq9MhTb_0A@mail.gmail.com>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
 <9B9005B1-9397-4171-8726-A52903B8B8F1@openminds.be> <CAORUGqD_Oe2F-yTS87h5P8oB=OrUTcuZo7BsWo3bqy66VJ1YfA@mail.gmail.com>
 <720D7ADB-C3E4-4C5E-B308-216D941FDC83@openminds.be> <CAORUGqD06LYcg3-y5BNNt724cvxUm1pkarDx_LoWoPSzx1=f1g@mail.gmail.com>
 <Pine.LNX.4.64.1204091115310.21531@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51391 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616Ab2DITW4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Apr 2012 15:22:56 -0400
Received: by vbbff1 with SMTP id ff1so2503614vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Apr 2012 12:22:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204091115310.21531@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Bernard Grymonpon <bernard@openminds.be>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Apr 9, 2012 at 11:16, Sage Weil <sage@newdream.net> wrote:
> One thing we need to keep in mind here is that the individual disks a=
re
> placed in the CRUSH hierarchy based on the host/rack/etc location in =
the
> datacenter. =C2=A0Moving disk around arbitrarily will break the place=
ment
> constraints if that position isn't also changed.

Yeah, the location will have to be updated. I tend to think disks
*will* move, and it's better to cope with it than to think it won't
happen. All you need is a simple power supply/mobo/raid
controller/nic/etc failure, if there's any free slots anywhere it's
probably better to plug the disks in there than waiting for a
replacement part. I'm working under the assumption that it's better to
"just bring them up" rather than having an extended osd outage or
claiming the osd as lost.

Updating the new location for the osd could be something we do even at
every osd start -- it's a nop if the location is the same as the old
one. And we can say the host knows where it is, and that information
is available in /etc or /var/lib/ceph.

I'll come back to this once it's a little bit more concrete; I'd
rather not make speculative changes, until I can actual trigger the
behavior in a test bench.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
