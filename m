From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Hard to debug problem with ceph_erasure_code
Date: Fri, 1 Apr 2016 14:22:24 +0200
Message-ID: <56FE6800.7050407@digiware.nl>
References: <56FD5A15.1080507@digiware.nl> <20160401051205.GA29567@gmail.com>
 <56FE4098.8000209@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:54410 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbcDAMW4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Apr 2016 08:22:56 -0400
In-Reply-To: <56FE4098.8000209@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 1-4-2016 11:34, Willem Jan Withagen wrote:
> On 1-4-2016 07:12, Mykola Golub wrote:
>> On Thu, Mar 31, 2016 at 07:10:45PM +0200, Willem Jan Withagen wrote:
>>
>>> Does anybody have suggestions as how to track/debug this?
>>
>> valgrind?
>>
>=20
> Yup, tried that one, but it is sort of hard to find an intermittent
> erroneous write. I tried --track-addr=3D<addr of m_exp_len> But most =
of
> the time it is only written  at exact the code line it is supposed to=
 be
> written. So no info there.
>=20
> So perhaps I need a different set of tests?
>=20
> On average I need about 600 runs to catch one SIGSEGV.
>=20
> BTW: tried it on 2 FreeBSD systems, and on both the behaviour is
> identical. So it has got to be the code. And since 65000 runs on Linu=
x
> give no errors, it is also typical for the combo
> FreeBSD/Clang/FreeBSD-packages.

And it gets even weirder.
Clang allows to use of AddressSanitizer
( https://github.com/google/sanitizers/wiki/AddressSanitizer )

So i've compiled all of ceph with
    -fsanitize=3Daddress -fno-omit-frame-pointer
And now I've already logged 50.000 runs without crashes.

=46eels a lot like Schr=F6dinger's cat....

--WjW


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
