From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Fri, 22 Feb 2013 16:24:13 +0100
Message-ID: <CAOLwVUn0SetsDgE2vqioFn+53xDi7Uh9TivDX2JOH6Qu5pEEUA@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
 <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
 <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
 <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com>
 <CAOLwVUkA5G+RyzembvZnv2gA5h-E+kNR_me_Hgoisjk0dmSWSg@mail.gmail.com> <CAPYLRzjx24oOEpjcvKa2ELJYb6QAxTegVatysMAobbP-h1v8Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33941 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236Ab3BVPYe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 10:24:34 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so687617obb.3
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 07:24:33 -0800 (PST)
In-Reply-To: <CAPYLRzjx24oOEpjcvKa2ELJYb6QAxTegVatysMAobbP-h1v8Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Hi all,

I finally got a core dump.

I did it with a kill -SEGV on the OSD process.

https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-0-0-20100-13=
61539008

Hope we will get something out of it :-).
--
Regards,
S=E9bastien Han.


On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Fri, Jan 11, 2013 at 6:57 AM, S=E9bastien Han <han.sebastien@gmail=
=2Ecom> wrote:
>>> Is osd.1 using the heap profiler as well? Keep in mind that active =
use
>>> of the memory profiler will itself cause memory usage to increase =97
>>> this sounds a bit like that to me since it's staying stable at a la=
rge
>>> but finite portion of total memory.
>>
>> Well, the memory consumption was already high before the profiler wa=
s
>> started. So yes with the memory profiler enable an OSD might consume
>> more memory but this doesn't cause the memory leaks.
>
> My concern is that maybe you saw a leak but when you restarted with
> the memory profiling you lost whatever conditions caused it.
>
>> Any ideas? Nothing to say about my scrumbing theory?
> I like it, but Sam indicates that without some heap dumps which
> capture the actual leak then scrub is too large to effectively code
> review for leaks. :(
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
