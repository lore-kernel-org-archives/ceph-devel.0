From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph-fs tests
Date: Wed, 5 Sep 2012 09:22:47 -0700
Message-ID: <CADvuQRGy9gCSwy3jMw+DGAF0MfoeohhYNgR2PJ+vDU1WW9cM+A@mail.gmail.com>
References: <50468E0E.6070807@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62214 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab2IEQXJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 12:23:09 -0400
Received: by vbbff1 with SMTP id ff1so305413vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 09:23:08 -0700 (PDT)
In-Reply-To: <50468E0E.6070807@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 4, 2012 at 4:26 PM, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
> i set up a 3 node ceph cluster 0.48.1argonaut to test ceph-fs.
>
> i mount ceph via fuse, then i downloaded kernel tree and decompressed=
 a few
> times, then stopping one osd (osd.1), afer a while of recovering, sud=
denly:
>
> tar: linux-3.5.3/drivers/media/video/zoran/zr36060.h: Kann write nich=
t
> ausf=C3=83=C2=BChren: Auf dem Ger=C3=83=C2=A4t ist kein Speicherplatz=
 mehr verf=C3=83=C2=BCgbar
> linux-3.5.3/drivers/media/video/zr364xx.c
> tar: linux-3.5.3/drivers/media/video/zr364xx.c: Kann write nicht ausf=
=C3=83=C2=BChren: Auf
> dem Ger=C3=83=C2=A4t ist kein Speicherplatz mehr verf=C3=83=C2=BCgbar
> linux-3.5.3/drivers/memory/

Please provide English error messages when you share things with the
list. In this case I can figure out what the message is, but really,
we're all pattern matching animals and the specific strings in
/usr/include/asm-generic/errno.h are what we know.

> no space left on device, but:
>
> 2012-09-04 18:46:38.242840 mon.0 [INF] pgmap v2883: 576 pgs: 512 acti=
ve+clean,
> 64 active+recovering; 1250 MB data, 14391 MB used, 844 MB / 15236 MB =
avail;
> 36677/215076 degraded (17.053%)
>
> there is space left?

Only 844 MB available, with the pseudo-random placement policies,
means you practically are out of space.

It looks like you had only 15GB to begin with, and with typical
replication, that's <5GB usable space. That is dangerously small for
any real use; Ceph currently does not cope very well with running out
of space.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
