From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Severe performance degradation with jewel rbd image
Date: Sat, 28 May 2016 09:29:15 +0200 (CEST)
Message-ID: <417572431.751254216.1464420555984.JavaMail.zimbra@oxygem.tv>
References: <BL2PR02MB2115AA33422B53D2C0B65E7AF4400@BL2PR02MB2115.namprd02.prod.outlook.com> <BL2PR02MB2115791B5D2A2D163F7A2AEFF4410@BL2PR02MB2115.namprd02.prod.outlook.com> <CA+aFP1DdPYWhRCeJ2buc7Gsz+gmti2BA4=7qoQHWP_Zi1_KyNQ@mail.gmail.com> <BL2PR02MB2115D73ED758ADC9C52729A6F4410@BL2PR02MB2115.namprd02.prod.outlook.com> <CAN=+7FVX5WecZZ=2dj1vSeFC=WCBvJkO5Esi+UuTT+_2=aiX9A@mail.gmail.com> <CA+aFP1BH-sJE1e8BsTwS3s9D-246dYQoBrhTtAtauJFRi+G5jw@mail.gmail.com> <BL2PR02MB2115FA285EA269AB9D536FF0F4410@BL2PR02MB2115.namprd02.prod.outlook.com> <CA+aFP1CqwRC8-EqPb0vTktQG0XViS8NO5TUg6BG9z0ooDPgbbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:54421 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcE1H3T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 May 2016 03:29:19 -0400
In-Reply-To: <CA+aFP1CqwRC8-EqPb0vTktQG0XViS8NO5TUg6BG9z0ooDPgbbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

qemu should have soon multithreaded disk access support (multi queues +=
 multi iothreads)

https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05023.html

Do you think it'll work with exclusive-lock ?

----- Mail original -----
De: "Jason Dillaman" <jdillama@redhat.com>
=C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>
Cc: "Samuel Just" <sjust@redhat.com>, "ceph-devel" <ceph-devel@vger.ker=
nel.org>
Envoy=C3=A9: Jeudi 26 Mai 2016 20:52:26
Objet: Re: Severe performance degradation with jewel rbd image

You can dynamically enable/disable exclusive-lock, object-map,=20
fast-diff, and journaling after the image is created via "rbd feature=20
disable <image-spec> <feature>". The deep-flatten feature can be=20
disabled-only via the same CLI.=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
