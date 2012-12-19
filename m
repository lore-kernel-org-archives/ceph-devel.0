From: Samuel Just <sam.just@inktank.com>
Subject: Re: OSD memory leaks?
Date: Wed, 19 Dec 2012 13:43:17 -0800
Message-ID: <CA+4uBUbY3eyj8VZ0m2Bn9Diac9OfuRFdg5m1dKf6GSXPk7Eisw@mail.gmail.com>
References: <CAOLwVUmJb0y39dg3zTv=c4iPSkjLBhG3L7L4=L7Ms96iP-SiWw@mail.gmail.com>
	<CAOLwVUnRqj+u7Vn2De+zAfvXLpYhj=tNggGZZdOH+m_xj2SMCQ@mail.gmail.com>
	<CA+4uBUY6Vf0HU71bL8z-3QhbsSSv+LRXFyfAiHHoNAzMw=5dLw@mail.gmail.com>
	<CAOLwVUn5VbH1P=0wu-Oxb1bSKpaQfC6uQ5012wvPc7bvz606JA@mail.gmail.com>
	<CAOLwVU=_Tz6Swirzk6AWwREdmG8qQUiQt=wd1OyNiPVSF1bqng@mail.gmail.com>
	<CA+4uBUZyeGAHH9Ntws2tCKud66H758qyCPWVG-aZnB2gcZjpJg@mail.gmail.com>
	<CAOLwVUkVhoM6U4z1iBPYFucdaq4AtV69_YReh2UaE_Jkocm4xQ@mail.gmail.com>
	<CAOLwVUm+8mZCrx9b_Ywna2AOjCM_eLaZnHSp04hnqTQ2ti-iAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:43837 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab2LSWIv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 17:08:51 -0500
Received: by mail-vb0-f50.google.com with SMTP id fr13so2924817vbb.37
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 14:08:50 -0800 (PST)
In-Reply-To: <CAOLwVUm+8mZCrx9b_Ywna2AOjCM_eLaZnHSp04hnqTQ2ti-iAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry, it's been very busy.  The next step would to try to get a heap
dump.  You can start a heap profile on osd N by:

ceph osd tell N heap start_profiler

and you can get it to dump the collected profile using

ceph osd tell N heap dump.

The dumps should show up in the osd log directory.

Assuming the heap profiler is working correctly, you can look at the
dump using pprof in google-perftools.

On Wed, Dec 19, 2012 at 8:37 AM, S=E9bastien Han <han.sebastien@gmail.c=
om> wrote:
> No more suggestions? :(
> --
> Regards,
> S=E9bastien Han.
>
>
> On Tue, Dec 18, 2012 at 6:21 PM, S=E9bastien Han <han.sebastien@gmail=
=2Ecom> wrote:
>> Nothing terrific...
>>
>> Kernel logs from my clients are full of "libceph: osd4
>> 172.20.11.32:6801 socket closed"
>>
>> I saw this somewhere on the tracker.
>>
>> Does this harm?
>>
>> Thanks.
>>
>> --
>> Regards,
>> S=E9bastien Han.
>>
>>
>>
>> On Mon, Dec 17, 2012 at 11:55 PM, Samuel Just <sam.just@inktank.com>=
 wrote:
>>>
>>> What is the workload like?
>>> -Sam
>>>
>>> On Mon, Dec 17, 2012 at 2:41 PM, S=E9bastien Han <han.sebastien@gma=
il.com> wrote:
>>> > Hi,
>>> >
>>> > No, I don't see nothing abnormal in the network stats. I don't se=
e
>>> > anything in the logs... :(
>>> > The weird thing is that one node over 4 seems to take way more me=
mory
>>> > than the others...
>>> >
>>> > --
>>> > Regards,
>>> > S=E9bastien Han.
>>> >
>>> >
>>> > On Mon, Dec 17, 2012 at 11:31 PM, S=E9bastien Han <han.sebastien@=
gmail.com> wrote:
>>> >>
>>> >> Hi,
>>> >>
>>> >> No, I don't see nothing abnormal in the network stats. I don't s=
ee anything in the logs... :(
>>> >> The weird thing is that one node over 4 seems to take way more m=
emory than the others...
>>> >>
>>> >> --
>>> >> Regards,
>>> >> S=E9bastien Han.
>>> >>
>>> >>
>>> >>
>>> >> On Mon, Dec 17, 2012 at 7:12 PM, Samuel Just <sam.just@inktank.c=
om> wrote:
>>> >>>
>>> >>> Are you having network hiccups?  There was a bug noticed recent=
ly that
>>> >>> could cause a memory leak if nodes are being marked up and down=
=2E
>>> >>> -Sam
>>> >>>
>>> >>> On Mon, Dec 17, 2012 at 12:28 AM, S=E9bastien Han <han.sebastie=
n@gmail.com> wrote:
>>> >>> > Hi guys,
>>> >>> >
>>> >>> > Today looking at my graphs I noticed that one over 4 ceph nod=
es used a
>>> >>> > lot of memory. It keeps growing and growing.
>>> >>> > See the graph attached to this mail.
>>> >>> > I run 0.48.2 on Ubuntu 12.04.
>>> >>> >
>>> >>> > The other nodes also grow, but slowly than the first one.
>>> >>> >
>>> >>> > I'm not quite sure about the information that I have to provi=
de. So
>>> >>> > let me know. The only thing I can say is that the load haven'=
t
>>> >>> > increase that much this week. It seems to be consuming and no=
t giving
>>> >>> > back the memory.
>>> >>> >
>>> >>> > Thank you in advance.
>>> >>> >
>>> >>> > --
>>> >>> > Regards,
>>> >>> > S=E9bastien Han.
>>> >>
>>> >>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
