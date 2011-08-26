From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v3)
Date: Fri, 26 Aug 2011 12:10:09 -0700
Message-ID: <CAORUGqAJi+Erq9diLjkNhXmoeHY11H8O2+ugBBWaW=BJay72=A@mail.gmail.com>
References: <20110826185117.GA19365@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61111 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab1HZTKa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 15:10:30 -0400
Received: by eyx24 with SMTP id 24so3003582eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 12:10:29 -0700 (PDT)
In-Reply-To: <20110826185117.GA19365@sir.fritz.box>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 26, 2011 at 11:51, Christian Brunner <chb@muc.de> wrote:
> + =C2=A0if (!buf) {
> + =C2=A0 =C2=A0len =3D ofs-lastofs;
> + =C2=A0 =C2=A0tempbuf =3D (byte *) malloc(len);
> + =C2=A0 =C2=A0if (!tempbuf)
> + =C2=A0 =C2=A0 =C2=A0return -ENOMEM;
> + =C2=A0 =C2=A0hashbuf =3D tempbuf;
> + =C2=A0}
> + =C2=A0Hash->Update((const byte *) hashbuf, len);

That'll still try to allocate 100GB of RAM for a 100GB hole. It needs
to loop through big holes in smaller chunks, feeding them to the hash
e.g. 8kB at a time. And at that point you might as well just use read
and not read_iterate, that'll do the memsetting etc for you, and then
you can use a static buffer and avoid malloc/free every round. There's
no shortcut to be had from "skipping" holes when you need to feed
bytes to a hash function.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
