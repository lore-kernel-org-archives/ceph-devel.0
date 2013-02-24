From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Mon, 25 Feb 2013 00:10:08 +0100
Message-ID: <CAOLwVU=iAvD4pd_SZdL5MAWvd3fOYno7=rdk+YA8Tc6EBFy_cA@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
 <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
 <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
 <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com>
 <CAOLwVUkA5G+RyzembvZnv2gA5h-E+kNR_me_Hgoisjk0dmSWSg@mail.gmail.com>
 <CAPYLRzjx24oOEpjcvKa2ELJYb6QAxTegVatysMAobbP-h1v8Xg@mail.gmail.com>
 <CAOLwVUn0SetsDgE2vqioFn+53xDi7Uh9TivDX2JOH6Qu5pEEUA@mail.gmail.com> <alpine.DEB.2.00.1302221642570.5703@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63409 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757280Ab3BXXK3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Feb 2013 18:10:29 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so2290273obb.0
        for <ceph-devel@vger.kernel.org>; Sun, 24 Feb 2013 15:10:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302221642570.5703@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Hi Sage,

Sorry it's a production system, so I can't test it.
So at the end, you can't get anything out of the core dump?

--
Regards,
S=E9bastien Han.


On Sat, Feb 23, 2013 at 1:44 AM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 22 Feb 2013, S?bastien Han wrote:
>> Hi all,
>>
>> I finally got a core dump.
>>
>> I did it with a kill -SEGV on the OSD process.
>>
>> https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-0-0-20100=
-1361539008
>>
>> Hope we will get something out of it :-).
>
> AHA!  We have a theory.  The pg log isnt trimmed during scrub (becaus=
e teh
> old scrub code required that), but the new (deep) scrub can take a ve=
ry
> long time, which means the pg log will eat ram in the meantime..
> especially under high iops.
>
> Can you try wip-osd-log-trim (which is bobtail + a simple patch) and =
see
> if that seems to work?  Note that that patch shouldn't be run in a mi=
xed
> argonaut+bobtail cluster, since it isn't properly checking if the scr=
ub is
> class or chunky/deep.
>
> Thanks!
> sage
>
>
>  > --
>> Regards,
>> S?bastien Han.
>>
>>
>> On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inktank.com> w=
rote:
>> > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.sebastien@gmai=
l.com> wrote:
>> >>> Is osd.1 using the heap profiler as well? Keep in mind that acti=
ve use
>> >>> of the memory profiler will itself cause memory usage to increas=
e ?
>> >>> this sounds a bit like that to me since it's staying stable at a=
 large
>> >>> but finite portion of total memory.
>> >>
>> >> Well, the memory consumption was already high before the profiler=
 was
>> >> started. So yes with the memory profiler enable an OSD might cons=
ume
>> >> more memory but this doesn't cause the memory leaks.
>> >
>> > My concern is that maybe you saw a leak but when you restarted wit=
h
>> > the memory profiling you lost whatever conditions caused it.
>> >
>> >> Any ideas? Nothing to say about my scrumbing theory?
>> > I like it, but Sam indicates that without some heap dumps which
>> > capture the actual leak then scrub is too large to effectively cod=
e
>> > review for leaks. :(
>> > -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
