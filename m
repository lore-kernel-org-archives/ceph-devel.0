From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: Testing 10GBE
Date: Wed, 13 Jun 2012 20:09:13 +0200
Message-ID: <CADdPHGvQudn-+KGT7vpPz4XDRr77YFvjia_DAhvwG=r8sH7P1w@mail.gmail.com>
References: <4FD74B46.6000805@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:46269 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab2FMSJO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 14:09:14 -0400
Received: by ghrr11 with SMTP id r11so668700ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 11:09:14 -0700 (PDT)
In-Reply-To: <4FD74B46.6000805@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

to give some hints it would be very helpful if you can describe your
setup a bit.

What hardware is used,
what network cards,
how many interfaces per server,
do you use bonding,
what kind of switching hw
MTU size
network bandwith measurent tool

Greetings

Stefan Majer


On Tue, Jun 12, 2012 at 3:59 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hello List,
>
> right now i'm starting to test 10GBE but i got strange results and ha=
ve no
> idea why this happens:
>
> 0,1 and 2 and 3 testsystems. But i've no idea why only Test system 2 =
<=3D> 3
> have problems with speed but 3 with 0 or 2 with 0 does not have a pro=
blem.
>
> 1 =3D> 0 =3D> 9,9Gbit/s
> 1 =3D> 2 =3D> 5,7Gbit/s
> 2 =3D> 0 =3D> 9,9Gbit/s
> 2 =3D> 1 =3D> 5,7Gbit/s
> 0 =3D> 1 =3D> 9,9Gbit/s
> 0 =3D> 2 =3D> 9,9Gbit/s
>
> Any ideas?
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Stefan Majer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
