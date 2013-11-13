From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: libuuid vs boost uuid
Date: Wed, 13 Nov 2013 07:07:16 -0800
Message-ID: <B4DA9072-EED6-48EE-94FE-4F24CCDFA1F8@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B665E29B6@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1311092120290.30944@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:61383 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301Ab3KMPHS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 10:07:18 -0500
Received: by mail-pa0-f42.google.com with SMTP id kp14so553761pab.29
        for <ceph-devel@vger.kernel.org>; Wed, 13 Nov 2013 07:07:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311092120290.30944@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

I just wanted to follow up on this thread. I=92d like to bring this pat=
ch into the wip-port portability branch. Were you able to get the boost=
::uuid to work as a drop-in replacement?

Thanks,
Noah

On Nov 9, 2013, at 9:22 PM, Sage Weil <sage@inktank.com> wrote:

> On Sun, 10 Nov 2013, James Harper wrote:
>>>=20
>>> On Sat, 9 Nov 2013, James Harper wrote:
>>>> Just out of curiosity (recent thread about windows port) I just ha=
d a
>>>> quick go at compiling librados under mingw (win32 cross compile), =
and
>>>> one of the errors that popped up was the lack of libuuid under min=
gw.
>>>> Ceph appears to use libuuid, but I notice boost appears to include=
 a
>>>> uuid class too, and it seems that ceph already uses some of boost =
(which
>>>> already builds under mingw).
>>>>=20
>>>> Is there anything special about libuuid that would mean boost's uu=
id
>>>> class couldn't replace it? And would it be better to still use cep=
h's
>>>> uuid.h as a wrapper around the boost uuid class, or to modify ceph=
 to
>>>> use the boost uuid class directly?
>>>=20
>>> Nice!  Boost uuid looks like it would work just fine.  It is probab=
ly
>>> easier and less disruptive to use it from within the existing class=
 in
>>> include/uuid.h.
>>>=20
>>=20
>> That seems to work (the header compiles at least), but then it falls=
=20
>> down when things try to memcpy out of it. In particular, an fsid app=
ears=20
>> to be a char[16]. Is that a uuid? And is keeping it as a byte array =
an=20
>> optimisation?
>=20
> Probably just being lazy; where was that?  Feel free to replace the m=
emcpy=20
> with methods to copy in/out if it's necessary...
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
