From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS has inconsistent performance
Date: Tue, 24 Mar 2015 15:21:41 -0700
Message-ID: <CAC6JEv9Vamhg_0Ayj2VQBxm1Hpt1zO6L8eHKrsM--5jSfbED1w@mail.gmail.com>
References: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
	<CAC6JEv9fXSm+xEcFPiJ90kQNKjoWdFZCs02ZHKD4kJGd4_2Q8w@mail.gmail.com>
	<CAD=PzHLahg1TPu3-zjFk6hO4cXeYg+-TjdR5cw0XNSoVA+_Ebw@mail.gmail.com>
	<CAC6JEv_1Gx3pnmutej7UmABC+eyB+VvoBo6X1OZhHFu+==6fjA@mail.gmail.com>
	<CAD=PzHJFT4QUeer7A-EawAQ=AskEu44pLPqHo4BLpk11zA1UQw@mail.gmail.com>
	<CAC6JEv826RqkkTCt3224LLv_BdS9394yucXf7_qaKwsYHmC-+A@mail.gmail.com>
	<CAD=PzH+N91wHudqOZawwQ9XoX-GQZdX7Sqin7hJfnwBbjE0Pmw@mail.gmail.com>
	<CAC6JEv_n2Sp8o+0_AjKdBsNAmVWtv6pqegCyS3cNjNGSNfpwTQ@mail.gmail.com>
	<CAD=PzHJPFPMoetp0yMRiDJAtd1Aj-BXwXbR94gghwh+4TNbgqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35127 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbbCXWVn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 18:21:43 -0400
Received: by ieclw3 with SMTP id lw3so9235189iec.2
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2015 15:21:42 -0700 (PDT)
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com. [209.85.223.175])
        by mx.google.com with ESMTPSA id x9sm9410245igl.2.2015.03.24.15.21.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 15:21:42 -0700 (PDT)
Received: by iecvj10 with SMTP id vj10so9392968iec.0
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2015 15:21:42 -0700 (PDT)
In-Reply-To: <CAD=PzHJPFPMoetp0yMRiDJAtd1Aj-BXwXbR94gghwh+4TNbgqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's been a while and I don't imagine you care much right now, but I
finally made the time to look at these log details. The reason we got
slow turned out to be much stupider than I anticipated (we were losing
I_COMPLETE for bad reasons); I wrote up what I found at
http://tracker.ceph.com/issues/11226 and have an RFC change in
wip-11226-dir-fx (PR at https://github.com/ceph/ceph/pull/4168).

Thanks for the complaint and the logs! :)
-Greg

On Fri, Jan 16, 2015 at 1:13 PM, Michael Sevilla <mikesevilla3@gmail.co=
m> wrote:
> If you feel like perusing... log=3D20 on client, mds messenger, and m=
ds:
>
> https://www.dropbox.com/s/uvmexh9impd3f3c/forgreg.tar.gz?dl=3D0
>
> In this run, only client 1 starts doing the extra lookups.
>
> On Fri, Jan 16, 2015 at 10:43 AM, Gregory Farnum <greg@gregs42.com> w=
rote:
>> On Fri, Jan 16, 2015 at 10:34 AM, Michael Sevilla
>> <mikesevilla3@gmail.com> wrote:
>>> On Thu, Jan 15, 2015 at 10:37 PM, Gregory Farnum <greg@gregs42.com>=
 wrote:
>>>> On Thu, Jan 15, 2015 at 2:44 PM, Michael Sevilla <mikesevilla3@gma=
il.com> wrote:
>>>>> Let me know if this works and/or you need anything else:
>>>>>
>>>>> https://www.dropbox.com/s/fq47w6jebnyluu0/lookup-logs.tar.gz?dl=3D=
0
>>>>>
>>>>> Beware - the clients were on debug=3D10. Also, I tried this with =
the
>>>>> kernel client and it is more consistent; it does the 2 lookups pe=
r
>>>>> create on 1 client every single time.
>>>>
>>>> Mmmm, there are no mds logs of note here. :(
>>>>
>>>
>>> Meaning you couldn't find mds.issdm-15.log? Or that that log didn't
>>> show anything interesting...
>>
>> It's not interesting. Caps are not logged at a very high level so I
>> think we'd actually want debug 20 on the mds, the messenger, and the
>> client subsystems.
>>
>>>
>>>> I did look enough to see that:
>>>> 1) The MDS is for some reason revoking caps on the file create
>>>> prompting the switch to double-lookups, which it was not before. T=
he
>>>> client doesn't really have any visibility into why that would be t=
he
>>>> case; the best guess I can come up with is that maybe the MDS spli=
t up
>>>> the directory into multiple frags at this point =E2=80=94 do you h=
ave that
>>>> enabled?
>>>
>>> Nope, unless any of these make a difference:
>>> $ ceph --admin-daemon... config show | grep frag
>>>   "mds_bal_frag": "false",
>>>   "mds_bal_fragment_interval": "5",
>>>   "mds_thrash_fragments": "0",
>>>   "mds_debug_frag": "false",
>>>
>>>> 2) The only way we set the I_COMPLETE flag is when we create an em=
pty
>>>> directory, or when we do a complete listdir on one. That makes it
>>>> pretty difficult to get the flag back (and so do the optimal creat=
e
>>>> path) once you lose it. :( I'd love a better way to do so, but we'=
ll
>>>> have to look at what's involved in a bit of depth.
>>>
>>> No need - with that reasoning it looks more like this is part of th=
e
>>> design rather than a bug. I'll just have to accept the fact that th=
e
>>> system is very complicated and clients touching stuff at certain ti=
mes
>>> can make things less predictable... I just wanted to make sure I
>>> wasn't doing anything wrong. :)  I'll stick with the kernel client
>>> (it's almost twice as fast, anyways!)
>>
>> Well, sort of =E2=80=94 an isolated client with their own directory =
is
>> something we definitely want to have exclusive caps, but our
>> heuristics aren't sophisticated enough yet.
>>
>>>
>>>> I'm not sure why the kernel client is so much more cautious, but I
>>>> think there were a number of troubles with the directory listing
>>>> orders and things which were harder to solve there =E2=80=93 I don=
't remember
>>>> if we introduced the I_DIR_ORDERED flag in it or not. Zheng can ta=
lk
>>>> more about that. What kernel client version are you using?
>>>>
>>>> And for a vanity data point, what kind of hardware is your MDS run=
ning on? :)
>>>
>>> Really, really old hardware from 2006: 2 dual-core CPUs, 8GB RAM,
>>> connected with 1Gbit. Kernel 3.4. We actually just installed beefie=
r
>>> nodes so I'll keep you posted if we get other cool results.
>>
>> Awesome! That's much faster than previously, although Zheng did some
>> work recently to split the journaling code into a separate thread
>> which I guess must have made a big difference.
>> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
