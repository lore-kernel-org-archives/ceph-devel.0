From: Alfredo Deza <adeza@redhat.com>
Subject: Re: drop i386 support
Date: Mon, 11 Jul 2016 09:42:25 -0400
Message-ID: <CAC-Np1wm16Ljt17w6fZN6-oxtEfWCGz-Ve6JtdZqiLnAFBqL_w@mail.gmail.com>
References: <CAJE9aONDn6S+8e7GNDpLX+6YaqSSEpQcFUDH_WeCXZrHfePAhg@mail.gmail.com>
 <20160711073205.GA14502@predictor> <1382742234.736.1468223238352@ox.pcextreme.nl>
 <alpine.DEB.2.11.1607111256190.2776@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35872 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbcGKNm1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 09:42:27 -0400
Received: by mail-wm0-f45.google.com with SMTP id f126so91071857wma.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2016 06:42:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1607111256190.2776@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@42on.com>, =?UTF-8?B?UGlvdHIgRGHFgmVr?= <branch@predictor.org.pl>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 11, 2016 at 8:58 AM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 11 Jul 2016, Wido den Hollander wrote:
>> > Op 11 juli 2016 om 9:32 schreef Piotr Da=C5=82ek <branch@predictor=
=2Eorg.pl>:
>> > On Mon, Jul 11, 2016 at 02:57:12PM +0800, kefu chai wrote:
>> > > Hi Cephers,
>> > >
>> > > I am proposing drop the support of i386. as we don't compile Cep=
h with
>> > > any i386 gitbuilder now[1] and hence don't test the i386 builds =
on
>> > > sepia on a regular basis. Also, based on the assumption that peo=
ple
>> > > don't use i386 in production, I think we can drop it from the mi=
nimum
>> > > hardware document[2]?
>> > >
>> > > And we won't explicitly disable the i386 build in code if we dec=
ide to
>> > > drop the i386 support, as we always try to be portable if possib=
le.
>> > > But just don't claim the i386 as the officially supported arch
>> > > anymore.
>> > >
>> > > What do you think?
>> >
>> > +1 from my side. Regular users are on amd64, and those willing to =
run on
>> > small devices are using ARM anyway.
>> >
>>
>> Indeed. In my experience I have never seen a cluster run on i386.
>>
>> +1 from my side to drop i386.
>
> Yep.
>
> The only value is the i386 builder, which serves as a canary for 32-b=
it
> build issues, and is a more convenient that building on 32-bit arm
> hardware.  So +.5 from me to keeping the builder around...

We also don't build i386 releases anymore (at least for a couple of yea=
rs now)


>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
