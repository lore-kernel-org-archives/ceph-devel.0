From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Generating debug packages
Date: Fri, 5 Jun 2015 13:38:11 -0600
Message-ID: <CAANLjFouSji7=QvwpDcNwn6tvWi=eUFaZQuu0q_yWk4AB7YHmg@mail.gmail.com>
References: <CAANLjFpFGb2e3V1q+z=E-a6KbiR7emG3X+WJyLW9dp6XW-Kw4w@mail.gmail.com>
	<5571F82D.1000204@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33902 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbbFETiN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 15:38:13 -0400
Received: by wibut5 with SMTP id ut5so30821579wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jun 2015 12:38:12 -0700 (PDT)
In-Reply-To: <5571F82D.1000204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

:$

Looks like ceph-debuginfo is what I'm looking for. Sorry, I come from
a Debian background and was looking for the wrong thing. I also seem
to remember when building the RPMs that it was stripping the debug
symbols, but I can't find any indication of that in the spec file. In
fact, I don't see the spec file building the debug package. I seem to
be more confused than when I started, but perf report now shows what I
was looking for.

We now return you to your regularly scheduled program...
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVcfqhCRDmVDuy+mK58QAA6bcQAJ9GHtrt21T9qnw0mrLw
YAYvs7tlgz8Fd4IJ3F8+r9nQ7Gil4ZKP0s8maZaFzGI6HonkGXGx8v2B7AzD
ZiHI5uo0JzvNT2KBQ4MOgjUQ7xBl5aFskQcIIPVrrq7BlzXIKGGb7U6a3duk
mATyeH2ekVcRdpNKSV0JqWzKVJwv2IUZ6petylxESsueqwGOaFsfEowJs5WR
K47+wSGDONHdlyPs+yoVitZTocbkOspiBqLVqG/ASU3z974J/yWK5xmPiH+C
M0LoW4CNrzChkW6jiyBE6q0yqUvZxMVkm0Fp60+sXEUQXK6lhz9uF+yOpLAC
B8FjCbmIJ+pUnSIWie2nqUP7WhRTIC3BTAIX13QuxQA37g/vxFN/1MYsddZ+
LeY3V8HViybwg3waF7zDeuNGpQlGqiYDQQCiF1mYfOux9kzxTWYfpHWfIgPj
ZJZMnGqP/d6Mtb7xTf2gL6fc7y828gbchd0t8eKYpNrR+r8jkb0QjwuqOQzG
ng3hoFhiLxXev2+TwyCN8KP4AwbWC0oqPe88XI7U+Lvbc/95Vyj4B6mDU5Cx
p9YLHNnEkEWWv0xivEukPwJP4rBbjx+dUqdU3kr34HsqWlkr0s1MvwEi8hkf
5CmbkMhpoLIrS5EumZD/hQIe6JKgpEh4is60iqiB9c2YwzDk2XRPpWFc5RRV
R7Qo
=3Djkb2
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Fri, Jun 5, 2015 at 1:27 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 05/06/2015 21:16, Robert LeBlanc wrote:
>> What is the feeling about generating debug packages along with the
>> standard packages? Seems like it could be useful. That and even thou=
gh
>> I enjoying building my own packages, I am lazy.
>
> There are -dbg packages, are you thinking of something else ?
>
>>
>> Thanks,
>> ----------------
>> Robert LeBlanc
>> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
