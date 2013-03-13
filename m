From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: mon memory leak
Date: Wed, 13 Mar 2013 13:58:13 +0000
Message-ID: <514085F5.6010509@inktank.com>
References: <51405874.6030506@profihost.ag> <CAOLwVUk9bT-pR3_6QmG+HywZMs4sEKZGGX=uiFqvFyFTM1Q=aA@mail.gmail.com> <CACkq2mr1juPpqn85jsxeNr_RdgX1nyC6KDLehuNs5rSveWMALw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:64667 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab3CMN7L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 09:59:11 -0400
Received: by mail-ee0-f41.google.com with SMTP id c13so496935eek.28
        for <ceph-devel@vger.kernel.org>; Wed, 13 Mar 2013 06:59:09 -0700 (PDT)
In-Reply-To: <CACkq2mr1juPpqn85jsxeNr_RdgX1nyC6KDLehuNs5rSveWMALw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/13/2013 01:42 PM, Travis Rhoden wrote:
> Hi Stefan,
>
> I have seen a mon grow quite high on Bobtail.  Joao had some theories
> as for why, and I was able to provide him with a memory dump of the
> running process.  No word yet on whether it revealed anything, but I
> know it is on his stack.  Background here:
> http://thread.gmane.org/gmane.comp.file-systems.ceph.user/14
>
>   - Travis

Hi all,

As Travis points out, this has been seen before.  I've spent a fair=20
amount of time chasing this down now, but haven't got to any useful=20
conclusions yet.  Although this is concerning, chasing down this kind o=
f=20
behaviour tends to be a time sink and there are other more pressing=20
issues that have been requiring most of my attention.  This hasn't been=
=20
forgotten and I've been allocating my time to it as possible.

On S=E9bastien's issue, that may very well be caused by some of the=20
memleaks that have been fixed some time since argonaut, prior to bobtai=
l.

I'm expecting to be able to find the time Real Soon Now to put a doc=20
together with ways, for anyone willing, to provide us further insight o=
n=20
what's happening.  The monitor is supposed to be able to dump a heap=20
profile (using gperftools) on-the-fly, but I recall having some issues=20
with that not so long ago, so that's probably one thing to look into as=
ap.

In any case, Stefan, do you by chance still have that monitor going?  I=
f=20
so, are you able to tell us what's that monitor rank? 'ceph mon_status'=
=20
should help you assessing that.  Furthermore, assuming you are using a=20
version prior to v0.58, any chance you can run a 'du -chs=20
/var/lib/ceph/mon/ceph-foo', with foo being the mem-hogging monitor's=20
id, and then, if you notice an abnormal disk consumption on one of the=20
directories, dive in to check where said consumption is happening?

   -Joao

>
> On Wed, Mar 13, 2013 at 7:02 AM, S=E9bastien Han <han.sebastien@gmail=
=2Ecom> wrote:
>>
>> Hi,
>>
>> I do have some ceph-mon memory leak as well but it's on Argonaut.
>>
>> See the memory consumption here:
>> [snipped]
>>
>> Sorry for the long post.
>> --
>> Regards,
>> S=E9bastien Han.
>>
>>
>> On Wed, Mar 13, 2013 at 11:44 AM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>>> Hi,
>>>
>>> are there any known ceph-mon memory leaks in bobtail? Today i've se=
en a
>>> ceph-mon process consuming 50GB Memory.
>>>
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
