From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Wed, 7 Dec 2011 10:03:17 -0800
Message-ID: <CAORUGqD9jdS_zyHwCN6VAL9ibaj47pHvX9nxOo38zvGngLC1Rw@mail.gmail.com>
References: <4366451.BU1d1YAr76@pc10> <3826746.5bRf3lS2YZ@tolkien>
 <CAF3hT9DSf5Xaw00PUFHp5OtGAabka+Wc6H4vVkK24PJGNizd4Q@mail.gmail.com>
 <1871670.5qvOuPR13S@pc10> <CAORUGqDkyTJUWgj-0knXsfYxFC5izi703L=ASsPhigAXY0WZmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48529 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788Ab1LGSDj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 13:03:39 -0500
Received: by eekd41 with SMTP id d41so743643eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2011 10:03:38 -0800 (PST)
In-Reply-To: <CAORUGqDkyTJUWgj-0knXsfYxFC5izi703L=ASsPhigAXY0WZmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Wed, Dec 7, 2011 at 10:00, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> def crush(pg):
> =C2=A0 =C2=A0all_osds =3D ['osd.0', 'osd.1', 'osd.2', ...]
> =C2=A0 =C2=A0result =3D []
> =C2=A0 =C2=A0# size is the number of copies; primary+replicas
> =C2=A0 =C2=A0while len(result) < size:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D get_random_number()

Err I mean pseudorandom, based on pg. So basically "r =3D pg" there.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0chosen =3D all_osds[ r % len(all_osds) ]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if chosen in result:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# osd can be picked only onc=
e
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue
> =C2=A0 =C2=A0 =C2=A0 =C2=A0result.append(chosen)
> =C2=A0 =C2=A0return result
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
