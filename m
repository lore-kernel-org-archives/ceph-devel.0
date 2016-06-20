From: Jeff Layton <jlayton@redhat.com>
Subject: Re: determining client and server on a connection
Date: Mon, 20 Jun 2016 15:33:24 -0400
Message-ID: <1466451204.21451.4.camel@redhat.com>
References: <1466421669.4297.13.camel@redhat.com>
	 <CACJqLyYbr1CvSe3svthj9YVSNh9NgNfV-+4rfdjbLjueLtw2Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36736 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbcFTTkS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 15:40:18 -0400
Received: by mail-yw0-f182.google.com with SMTP id b72so21917061ywa.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2016 12:40:18 -0700 (PDT)
In-Reply-To: <CACJqLyYbr1CvSe3svthj9YVSNh9NgNfV-+4rfdjbLjueLtw2Wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2016-06-21 at 00:26 +0800, Haomai Wang wrote:
>=20
>=20
> On Mon, Jun 20, 2016 at 7:21 PM, Jeff Layton <jlayton@redhat.com> wro=
te:
> > Hi! I'm just getting started working with ceph, and decided to tack=
le
> > fixing up the wireshark dissector which isn't working properly when=
 you
> > use the kernel's fs client.
> >=20
> > This page says that the server always sends its banner first:
> >=20
> > =C2=A0 =C2=A0 http://docs.ceph.com/docs/master/dev/network-protocol=
/?highlight=3Dprotocol
> >=20
> > ...but that's not true with the Linux kernel client. The client and
> > server send their banners and addresses concurrently, and the clien=
t
> > often gets there first. The wireshark dissector relies on the serve=
r
> > sending its banner first however, so it quickly mixes the two up an=
d
> > things go south from there.
> Hmm, actually I also modify this behavior in async msgr(https://githu=
b.com/ceph/ceph/pull/9802 last commit).
> Because I found there is no real logic difference in ordering.=C2=A0
> =C2=A0


Yeah, sending them concurrently does seem like the right thing to do.
There's no reason to serialize them at all, AFAICT. The first draft of
the patch is here:

=C2=A0 =C2=A0=C2=A0https://code.wireshark.org/review/#/c/16043/1

It seems to work for me when sniffing both the kernel and FUSE mounts
now.

The patch is not terribly pretty, but I think we'll have more work to
do in the dissector once msgr2 starts getting closer to being
finalized.

--=20
Jeff Layton <jlayton@redhat.com>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
