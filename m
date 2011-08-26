From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v3)
Date: Fri, 26 Aug 2011 12:25:33 -0700
Message-ID: <CAC-hyiGPmbMYi0t5kswjSrUHsQWbvT1Z0oqfo+f=KJQunALU5A@mail.gmail.com>
References: <20110826185117.GA19365@sir.fritz.box>
	<CAORUGqAJi+Erq9diLjkNhXmoeHY11H8O2+ugBBWaW=BJay72=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46588 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab1HZTZe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 15:25:34 -0400
Received: by bke11 with SMTP id 11so2777498bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 12:25:33 -0700 (PDT)
In-Reply-To: <CAORUGqAJi+Erq9diLjkNhXmoeHY11H8O2+ugBBWaW=BJay72=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Fri, Aug 26, 2011 at 12:10 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Aug 26, 2011 at 11:51, Christian Brunner <chb@muc.de> wrote:
>> + =A0if (!buf) {
>> + =A0 =A0len =3D ofs-lastofs;
>> + =A0 =A0tempbuf =3D (byte *) malloc(len);
>> + =A0 =A0if (!tempbuf)
>> + =A0 =A0 =A0return -ENOMEM;
>> + =A0 =A0hashbuf =3D tempbuf;
>> + =A0}
>> + =A0Hash->Update((const byte *) hashbuf, len);
>
> That'll still try to allocate 100GB of RAM for a 100GB hole. It needs
> to loop through big holes in smaller chunks, feeding them to the hash
> e.g. 8kB at a time. And at that point you might as well just use read
> and not read_iterate, that'll do the memsetting etc for you, and then
> you can use a static buffer and avoid malloc/free every round. There'=
s
> no shortcut to be had from "skipping" holes when you need to feed
> bytes to a hash function.

Well, when using read_iterate you avoid reading extra data over the
network when the object (chunk) exists (and is sparse). We can
probably have some optimization here, and only allocate and memset a
buffer once for the case where len =3D=3D objsize and reuse it later.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
