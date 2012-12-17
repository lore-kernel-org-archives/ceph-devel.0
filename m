From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Mon, 17 Dec 2012 23:41:18 +0100
Message-ID: <CAOLwVU=_Tz6Swirzk6AWwREdmG8qQUiQt=wd1OyNiPVSF1bqng@mail.gmail.com>
References: <CAOLwVUmJb0y39dg3zTv=c4iPSkjLBhG3L7L4=L7Ms96iP-SiWw@mail.gmail.com>
 <CAOLwVUnRqj+u7Vn2De+zAfvXLpYhj=tNggGZZdOH+m_xj2SMCQ@mail.gmail.com>
 <CA+4uBUY6Vf0HU71bL8z-3QhbsSSv+LRXFyfAiHHoNAzMw=5dLw@mail.gmail.com> <CAOLwVUn5VbH1P=0wu-Oxb1bSKpaQfC6uQ5012wvPc7bvz606JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:41999 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2LQWlk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 17:41:40 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so5261691lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 14:41:38 -0800 (PST)
In-Reply-To: <CAOLwVUn5VbH1P=0wu-Oxb1bSKpaQfC6uQ5012wvPc7bvz606JA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

No, I don't see nothing abnormal in the network stats. I don't see
anything in the logs... :(
The weird thing is that one node over 4 seems to take way more memory
than the others...

--
Regards,
S=E9bastien Han.


On Mon, Dec 17, 2012 at 11:31 PM, S=E9bastien Han <han.sebastien@gmail.=
com> wrote:
>
> Hi,
>
> No, I don't see nothing abnormal in the network stats. I don't see an=
ything in the logs... :(
> The weird thing is that one node over 4 seems to take way more memory=
 than the others...
>
> --
> Regards,
> S=E9bastien Han.
>
>
>
> On Mon, Dec 17, 2012 at 7:12 PM, Samuel Just <sam.just@inktank.com> w=
rote:
>>
>> Are you having network hiccups?  There was a bug noticed recently th=
at
>> could cause a memory leak if nodes are being marked up and down.
>> -Sam
>>
>> On Mon, Dec 17, 2012 at 12:28 AM, S=E9bastien Han <han.sebastien@gma=
il.com> wrote:
>> > Hi guys,
>> >
>> > Today looking at my graphs I noticed that one over 4 ceph nodes us=
ed a
>> > lot of memory. It keeps growing and growing.
>> > See the graph attached to this mail.
>> > I run 0.48.2 on Ubuntu 12.04.
>> >
>> > The other nodes also grow, but slowly than the first one.
>> >
>> > I'm not quite sure about the information that I have to provide. S=
o
>> > let me know. The only thing I can say is that the load haven't
>> > increase that much this week. It seems to be consuming and not giv=
ing
>> > back the memory.
>> >
>> > Thank you in advance.
>> >
>> > --
>> > Regards,
>> > S=E9bastien Han.
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
