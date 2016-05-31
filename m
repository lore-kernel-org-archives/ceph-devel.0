From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Severe performance degradation with jewel rbd image
Date: Tue, 31 May 2016 15:57:29 -0400
Message-ID: <CA+aFP1DRf8TH5tJxSjjk1ptaxDTwNWpBbSCAKVzGj+XNgE5i+Q@mail.gmail.com>
References: <BL2PR02MB2115AA33422B53D2C0B65E7AF4400@BL2PR02MB2115.namprd02.prod.outlook.com>
	<BL2PR02MB2115791B5D2A2D163F7A2AEFF4410@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1DdPYWhRCeJ2buc7Gsz+gmti2BA4=7qoQHWP_Zi1_KyNQ@mail.gmail.com>
	<BL2PR02MB2115D73ED758ADC9C52729A6F4410@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CAN=+7FVX5WecZZ=2dj1vSeFC=WCBvJkO5Esi+UuTT+_2=aiX9A@mail.gmail.com>
	<CA+aFP1BH-sJE1e8BsTwS3s9D-246dYQoBrhTtAtauJFRi+G5jw@mail.gmail.com>
	<BL2PR02MB2115FA285EA269AB9D536FF0F4410@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1CqwRC8-EqPb0vTktQG0XViS8NO5TUg6BG9z0ooDPgbbw@mail.gmail.com>
	<417572431.751254216.1464420555984.JavaMail.zimbra@oxygem.tv>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33035 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcEaT5b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 15:57:31 -0400
Received: by mail-pf0-f171.google.com with SMTP id b124so77554583pfb.0
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 12:57:30 -0700 (PDT)
In-Reply-To: <417572431.751254216.1464420555984.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

That QEMU patch looks like it only supports raw devices and
pre-allocated files.  Once librbd/librados can eliminate all the
threading/queuing slowdowns, a similar approach could be extended to
RBD images without the need to open multiple copies of the same image.

On Sat, May 28, 2016 at 3:29 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
> Hi,
>
> qemu should have soon multithreaded disk access support (multi queues=
 + multi iothreads)
>
> https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05023.html
>
> Do you think it'll work with exclusive-lock ?
>
> ----- Mail original -----
> De: "Jason Dillaman" <jdillama@redhat.com>
> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>
> Cc: "Samuel Just" <sjust@redhat.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>
> Envoy=C3=A9: Jeudi 26 Mai 2016 20:52:26
> Objet: Re: Severe performance degradation with jewel rbd image
>
> You can dynamically enable/disable exclusive-lock, object-map,
> fast-diff, and journaling after the image is created via "rbd feature
> disable <image-spec> <feature>". The deep-flatten feature can be
> disabled-only via the same CLI.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Jason
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
