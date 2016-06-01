From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Severe performance degradation with jewel rbd image
Date: Wed, 1 Jun 2016 08:58:30 +0200 (CEST)
Message-ID: <1201586295.760757370.1464764310119.JavaMail.zimbra@oxygem.tv>
References: <BL2PR02MB2115AA33422B53D2C0B65E7AF4400@BL2PR02MB2115.namprd02.prod.outlook.com> <BL2PR02MB2115D73ED758ADC9C52729A6F4410@BL2PR02MB2115.namprd02.prod.outlook.com> <CAN=+7FVX5WecZZ=2dj1vSeFC=WCBvJkO5Esi+UuTT+_2=aiX9A@mail.gmail.com> <CA+aFP1BH-sJE1e8BsTwS3s9D-246dYQoBrhTtAtauJFRi+G5jw@mail.gmail.com> <BL2PR02MB2115FA285EA269AB9D536FF0F4410@BL2PR02MB2115.namprd02.prod.outlook.com> <CA+aFP1CqwRC8-EqPb0vTktQG0XViS8NO5TUg6BG9z0ooDPgbbw@mail.gmail.com> <417572431.751254216.1464420555984.JavaMail.zimbra@oxygem.tv> <CA+aFP1DRf8TH5tJxSjjk1ptaxDTwNWpBbSCAKVzGj+XNgE5i+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:55937 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750697AbcFAG6d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 02:58:33 -0400
In-Reply-To: <CA+aFP1DRf8TH5tJxSjjk1ptaxDTwNWpBbSCAKVzGj+XNgE5i+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>Once librbd/librados can eliminate all the=20
>>threading/queuing slowdowns, a similar approach could be extended to=20
>>RBD images without the need to open multiple copies of the same image=
=2E=20

Thanks Jason, that's a really good news !

----- Mail original -----
De: "Jason Dillaman" <jdillama@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "Somnath Roy" <Somnath.Roy@sandisk.com>, "Samuel Just" <sjust@redha=
t.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mardi 31 Mai 2016 21:57:29
Objet: Re: Severe performance degradation with jewel rbd image

That QEMU patch looks like it only supports raw devices and=20
pre-allocated files. Once librbd/librados can eliminate all the=20
threading/queuing slowdowns, a similar approach could be extended to=20
RBD images without the need to open multiple copies of the same image.=20

On Sat, May 28, 2016 at 3:29 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:=20
> Hi,=20
>=20
> qemu should have soon multithreaded disk access support (multi queues=
 + multi iothreads)=20
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05023.html=20
>=20
> Do you think it'll work with exclusive-lock ?=20
>=20
> ----- Mail original -----=20
> De: "Jason Dillaman" <jdillama@redhat.com>=20
> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
> Cc: "Samuel Just" <sjust@redhat.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>=20
> Envoy=C3=A9: Jeudi 26 Mai 2016 20:52:26=20
> Objet: Re: Severe performance degradation with jewel rbd image=20
>=20
> You can dynamically enable/disable exclusive-lock, object-map,=20
> fast-diff, and journaling after the image is created via "rbd feature=
=20
> disable <image-spec> <feature>". The deep-flatten feature can be=20
> disabled-only via the same CLI.=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20
Jason=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
