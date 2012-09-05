From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph-fs tests
Date: Wed, 5 Sep 2012 09:37:05 -0700
Message-ID: <CAPYLRziuFjjFpvBpNffQ=Y=HK=sQqdmpHCcJ_R3xvkuqMcZuOQ@mail.gmail.com>
References: <50468E0E.6070807@smart-weblications.de>
	<CADvuQRGy9gCSwy3jMw+DGAF0MfoeohhYNgR2PJ+vDU1WW9cM+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61717 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2IEQhG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 12:37:06 -0400
Received: by ieje11 with SMTP id e11so1406895iej.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 09:37:05 -0700 (PDT)
In-Reply-To: <CADvuQRGy9gCSwy3jMw+DGAF0MfoeohhYNgR2PJ+vDU1WW9cM+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: f.wiessner@smart-weblications.de, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 5, 2012 at 9:22 AM, Tommi Virtanen <tv@inktank.com> wrote:
> On Tue, Sep 4, 2012 at 4:26 PM, Smart Weblications GmbH - Florian
> Wiessner <f.wiessner@smart-weblications.de> wrote:
>> i set up a 3 node ceph cluster 0.48.1argonaut to test ceph-fs.
>>
>> i mount ceph via fuse, then i downloaded kernel tree and decompresse=
d a few
>> times, then stopping one osd (osd.1), afer a while of recovering, su=
ddenly:
>>
>> tar: linux-3.5.3/drivers/media/video/zoran/zr36060.h: Kann write nic=
ht
>> ausf=C3=BChren: Auf dem Ger=C3=A4t ist kein Speicherplatz mehr verf=C3=
=BCgbar
>> linux-3.5.3/drivers/media/video/zr364xx.c
>> tar: linux-3.5.3/drivers/media/video/zr364xx.c: Kann write nicht aus=
f=C3=BChren: Auf
>> dem Ger=C3=A4t ist kein Speicherplatz mehr verf=C3=BCgbar
>> linux-3.5.3/drivers/memory/
>
> Please provide English error messages when you share things with the
> list. In this case I can figure out what the message is, but really,
> we're all pattern matching animals and the specific strings in
> /usr/include/asm-generic/errno.h are what we know.
>
>> no space left on device, but:
>>
>> 2012-09-04 18:46:38.242840 mon.0 [INF] pgmap v2883: 576 pgs: 512 act=
ive+clean,
>> 64 active+recovering; 1250 MB data, 14391 MB used, 844 MB / 15236 MB=
 avail;
>> 36677/215076 degraded (17.053%)
>>
>> there is space left?
>
> Only 844 MB available, with the pseudo-random placement policies,
> means you practically are out of space.
>
> It looks like you had only 15GB to begin with, and with typical
> replication, that's <5GB usable space. That is dangerously small for
> any real use; Ceph currently does not cope very well with running out
> of space.

In this particular case, one of the OSDs is more than 95% full and has
been marked as full (which stops cluster IO) to prevent those
catastrophic failures from occurring. If you look at the full output
of ceph -s, you should see a warning about having OSDs full and
near-full.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
