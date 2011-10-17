From: Christian Brunner <chb@muc.de>
Subject: Re: OSD blocked for more than 120 seconds
Date: Mon, 17 Oct 2011 11:40:32 +0200
Message-ID: <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com>
References: <4E974C87.2070204@tuxadero.com>
	<1318585099.2999.10.camel@wido-laptop>
	<CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com>
	<4E99E68F.9090005@tuxadero.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37255 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab1JQJkd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 05:40:33 -0400
Received: by vcge1 with SMTP id e1so1824330vcg.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2011 02:40:32 -0700 (PDT)
In-Reply-To: <4E99E68F.9090005@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

2011/10/15 Martin Mailand <martin@tuxadero.com>:
> Hi Christian,
> I have a very similar experience, I also used josef's tree and btrfs =
snaps =3D
> 0, the next problem I had than was excessive fragmentation, so I =A0u=
sed this
> patch http://marc.info/?l=3Dlinux-btrfs&m=3D131495014823121&w=3D2, an=
d changed the
> btrfs option to (btrfs options =3D noatime,nodatacow,autodefrag) that=
 kept the
> fragmentation under control.
> But even with this setup after a few days the load on the osd is unbe=
arable.

How did you find out about our fragmentation issues? Was it just a
performance problem?

> As far as I understood the doku if you disable the btrfs snapshot
> functionality the writeahead journal is activated.
> http://ceph.newdream.net/wiki/Ceph.conf
> And I get this in the logs.
> mount: enabling WRITEAHEAD journal mode: 'filestore btrfs snap' mode =
is not
> enabled
>
> May I asked what kind of probs you did have with ext4? Because I am l=
ooking
> into this direction as well.

You can read about our ext4 problems here:

http://marc.info/?l=3Dceph-devel&m=3D131201869703245&w=3D2

Our bugreport with RedHat didn't make any progress for a long time,
but last week RedHat made two sugestions:

- If you configure ceph with 'filestore flusher =3D false', do you see
any different behavior?
- If you mount with -o noauto_da_alloc does it change anything?

Since I have just migrated to btrfs, I've some problems to check this,
but I'll try to do this as soon as I can get hold of some extra
hardware.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
