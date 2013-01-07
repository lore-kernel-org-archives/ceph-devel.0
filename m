From: Samuel Just <sam.just@inktank.com>
Subject: Re: OSD memory leaks?
Date: Mon, 7 Jan 2013 11:09:34 -0800
Message-ID: <CA+4uBUbGYtCDJkvte4Fo4pL_NuYw5LpBu+mBhr_nOgbQyw353A@mail.gmail.com>
References: <4172429.450.1357580400977.JavaMail.dspano@it1>
	<10953797.470.1357585419142.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:43459 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab3AGTJf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 14:09:35 -0500
Received: by mail-vb0-f50.google.com with SMTP id ft2so8124076vbb.37
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 11:09:34 -0800 (PST)
In-Reply-To: <10953797.470.1357585419142.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Awesome!  What version are you running (ceph-osd -v, include the hash)?
-Sam

On Mon, Jan 7, 2013 at 11:03 AM, Dave Spano <dspano@optogenics.com> wro=
te:
> This failed the first time I sent it, so I'm resending in plain text.
>
> Dave Spano
> Optogenics
> Systems Administrator
>
>
>
> ----- Original Message -----
>
> From: "Dave Spano" <dspano@optogenics.com>
> To: "S=E9bastien Han" <han.sebastien@gmail.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel Just" <sam.jus=
t@inktank.com>
> Sent: Monday, January 7, 2013 12:40:06 PM
> Subject: Re: OSD memory leaks?
>
>
> Sam,
>
> Attached are some heaps that I collected today. 001 and 003 are just =
after I started the profiler; 011 is the most recent. If you need more,=
 or anything different let me know. Already the OSD in question is at 3=
8% memory usage. As mentioned by S=E8bastien, restarting ceph-osd keeps=
 things going.
>
> Not sure if this is helpful information, but out of the two OSDs that=
 I have running, the first one (osd.0) is the one that develops this pr=
oblem the quickest. osd.1 does have the same issue, it just takes much =
longer. Do the monitors hit the first osd in the list first, when there=
's activity?
>
>
> Dave Spano
> Optogenics
> Systems Administrator
>
>
> ----- Original Message -----
>
> From: "S=E9bastien Han" <han.sebastien@gmail.com>
> To: "Samuel Just" <sam.just@inktank.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Friday, January 4, 2013 10:20:58 AM
> Subject: Re: OSD memory leaks?
>
> Hi Sam,
>
> Thanks for your answer and sorry the late reply.
>
> Unfortunately I can't get something out from the profiler, actually I
> do but I guess it doesn't show what is supposed to show... I will kee=
p
> on trying this. Anyway yesterday I just thought that the problem migh=
t
> be due to some over usage of some OSDs. I was thinking that the
> distribution of the primary OSD might be uneven, this could have
> explained that some memory leaks are more important with some servers=
=2E
> At the end, the repartition seems even but while looking at the pg
> dump I found something interesting in the scrub column, timestamps
> from the last scrubbing operation matched with times showed on the
> graph.
>
> After this, I made some calculation, I compared the total number of
> scrubbing operation with the time range where memory leaks occurred.
> First of all check my setup:
>
> root@c2-ceph-01 ~ # ceph osd tree
> dumped osdmap tree epoch 859
> # id weight type name up/down reweight
> -1 12 pool default
> -3 12 rack lc2_rack33
> -2 3 host c2-ceph-01
> 0 1 osd.0 up 1
> 1 1 osd.1 up 1
> 2 1 osd.2 up 1
> -4 3 host c2-ceph-04
> 10 1 osd.10 up 1
> 11 1 osd.11 up 1
> 9 1 osd.9 up 1
> -5 3 host c2-ceph-02
> 3 1 osd.3 up 1
> 4 1 osd.4 up 1
> 5 1 osd.5 up 1
> -6 3 host c2-ceph-03
> 6 1 osd.6 up 1
> 7 1 osd.7 up 1
> 8 1 osd.8 up 1
>
>
> And there are the results:
>
> * Ceph node 1 which has the most important memory leak performed 1608
> in total and 1059 during the time range where memory leaks occured
> * Ceph node 2, 1168 in total and 776 during the time range where
> memory leaks occured
> * Ceph node 3, 940 in total and 94 during the time range where memory
> leaks occurred
> * Ceph node 4, 899 in total and 191 during the time range where
> memory leaks occurred
>
> I'm still not entirely sure that the scrub operation causes the leak
> but the only relevant relation that I found...
>
> Could it be that the scrubbing process doesn't release memory? Btw I
> was wondering, how ceph decides at what time it should run the
> scrubbing operation? I know that it's once a day and control by the
> following options
>
> OPTION(osd_scrub_min_interval, OPT_FLOAT, 300)
> OPTION(osd_scrub_max_interval, OPT_FLOAT, 60*60*24)
>
> But how ceph determined the time where the operation started, during
> cluster creation probably?
>
> I just checked the options that control OSD scrubbing and found that =
by default:
>
> OPTION(osd_max_scrubs, OPT_INT, 1)
>
> So that might explain why only one OSD uses a lot of memory.
>
> My dirty workaround at the moment is to performed a check of memory
> use by every OSD and restart it if it uses more than 25% of the total
> memory. Also note that on ceph 1, 3 and 4 it's always one OSD that
> uses a lot of memory, for ceph 2 only the mem usage is high but almos=
t
> the same for all the OSD process.
>
> Thank you in advance.
>
> --
> Regards,
> S=E9bastien Han.
>
>
> On Wed, Dec 19, 2012 at 10:43 PM, Samuel Just <sam.just@inktank.com> =
wrote:
>>
>> Sorry, it's been very busy. The next step would to try to get a heap
>> dump. You can start a heap profile on osd N by:
>>
>> ceph osd tell N heap start_profiler
>>
>> and you can get it to dump the collected profile using
>>
>> ceph osd tell N heap dump.
>>
>> The dumps should show up in the osd log directory.
>>
>> Assuming the heap profiler is working correctly, you can look at the
>> dump using pprof in google-perftools.
>>
>> On Wed, Dec 19, 2012 at 8:37 AM, S=E9bastien Han <han.sebastien@gmai=
l.com> wrote:
>> > No more suggestions? :(
>> > --
>> > Regards,
>> > S=E9bastien Han.
>> >
>> >
>> > On Tue, Dec 18, 2012 at 6:21 PM, S=E9bastien Han <han.sebastien@gm=
ail.com> wrote:
>> >> Nothing terrific...
>> >>
>> >> Kernel logs from my clients are full of "libceph: osd4
>> >> 172.20.11.32:6801 socket closed"
>> >>
>> >> I saw this somewhere on the tracker.
>> >>
>> >> Does this harm?
>> >>
>> >> Thanks.
>> >>
>> >> --
>> >> Regards,
>> >> S=E9bastien Han.
>> >>
>> >>
>> >>
>> >> On Mon, Dec 17, 2012 at 11:55 PM, Samuel Just <sam.just@inktank.c=
om> wrote:
>> >>>
>> >>> What is the workload like?
>> >>> -Sam
>> >>>
>> >>> On Mon, Dec 17, 2012 at 2:41 PM, S=E9bastien Han <han.sebastien@=
gmail.com> wrote:
>> >>> > Hi,
>> >>> >
>> >>> > No, I don't see nothing abnormal in the network stats. I don't=
 see
>> >>> > anything in the logs... :(
>> >>> > The weird thing is that one node over 4 seems to take way more=
 memory
>> >>> > than the others...
>> >>> >
>> >>> > --
>> >>> > Regards,
>> >>> > S=E9bastien Han.
>> >>> >
>> >>> >
>> >>> > On Mon, Dec 17, 2012 at 11:31 PM, S=E9bastien Han <han.sebasti=
en@gmail.com> wrote:
>> >>> >>
>> >>> >> Hi,
>> >>> >>
>> >>> >> No, I don't see nothing abnormal in the network stats. I don'=
t see anything in the logs... :(
>> >>> >> The weird thing is that one node over 4 seems to take way mor=
e memory than the others...
>> >>> >>
>> >>> >> --
>> >>> >> Regards,
>> >>> >> S=E9bastien Han.
>> >>> >>
>> >>> >>
>> >>> >>
>> >>> >> On Mon, Dec 17, 2012 at 7:12 PM, Samuel Just <sam.just@inktan=
k.com> wrote:
>> >>> >>>
>> >>> >>> Are you having network hiccups? There was a bug noticed rece=
ntly that
>> >>> >>> could cause a memory leak if nodes are being marked up and d=
own.
>> >>> >>> -Sam
>> >>> >>>
>> >>> >>> On Mon, Dec 17, 2012 at 12:28 AM, S=E9bastien Han <han.sebas=
tien@gmail.com> wrote:
>> >>> >>> > Hi guys,
>> >>> >>> >
>> >>> >>> > Today looking at my graphs I noticed that one over 4 ceph =
nodes used a
>> >>> >>> > lot of memory. It keeps growing and growing.
>> >>> >>> > See the graph attached to this mail.
>> >>> >>> > I run 0.48.2 on Ubuntu 12.04.
>> >>> >>> >
>> >>> >>> > The other nodes also grow, but slowly than the first one.
>> >>> >>> >
>> >>> >>> > I'm not quite sure about the information that I have to pr=
ovide. So
>> >>> >>> > let me know. The only thing I can say is that the load hav=
en't
>> >>> >>> > increase that much this week. It seems to be consuming and=
 not giving
>> >>> >>> > back the memory.
>> >>> >>> >
>> >>> >>> > Thank you in advance.
>> >>> >>> >
>> >>> >>> > --
>> >>> >>> > Regards,
>> >>> >>> > S=E9bastien Han.
>> >>> >>
>> >>> >>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
