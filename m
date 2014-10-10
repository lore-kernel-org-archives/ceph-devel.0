From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 1/1 linux-next] ceph: fix bool assignments
Date: Fri, 10 Oct 2014 10:41:15 +0200 (CEST)
Message-ID: <1754653714.36927.1412930475803.open-xchange@webmail.nmp.skynet.be>
References: <1412889395-19350-1-git-send-email-fabf@skynet.be> <54372B43.2010801@inktank.com> <CALFYKtB8Z4HHr5ZuLcMdctOKBSZZjgCAhbOiFHgbPnVcbjLySw@mail.gmail.com>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALFYKtB8Z4HHr5ZuLcMdctOKBSZZjgCAhbOiFHgbPnVcbjLySw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>, Ilya Dryomov <ilya.dryomov@inktank.com>, Dan Mick <dan.mick@inktank.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>
List-Id: ceph-devel.vger.kernel.org



> On 10 October 2014 at 10:24 Ilya Dryomov <ilya.dryomov@inktank.com> w=
rote:
>
>
> On Fri, Oct 10, 2014 at 4:41 AM, Dan Mick <dan.mick@inktank.com> wrot=
e:
> >
> >
> > On 10/09/2014 02:16 PM, Fabian Frederick wrote:
> >> Fix some coccinelle warnings:
> >> fs/ceph/caps.c:2400:6-10: WARNING: Assignment of bool to 0/1
> >
> >
> >> -=C2=A0 =C2=A0 =C2=A0bool wake =3D 0;
> >> +=C2=A0 =C2=A0 =C2=A0bool wake =3D false;
> >
> > FWIW, that message is backwards: it should say "WARNING: Assignment=
 of
> > 0/1 to bool" (I know, it's a coccinelle issue, but..)
>
> Hi Julia,
>
> See above, hopefully you are the right person to ask to forward this =
to
> the right people ;)
>
> Thanks,
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ilya
Hi Ilya,

=C2=A0 =C2=A0 Patch already send and acked:
http://marc.info/?l=3Dlinux-kernel&m=3D141292553109418&w=3D2

Regards,
=46abian
