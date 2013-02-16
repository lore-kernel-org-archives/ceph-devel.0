From: Wido den Hollander <wido@42on.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Sat, 16 Feb 2013 10:09:00 +0100
Message-ID: <511F4CAC.6020405@42on.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com> <alpine.DEB.2.00.1301300116210.4449@cobra.newdream.net> <CAF6-1L61H28xXDPZBC5Um0tyJLs2uGX8S7G2UjpL64fnt7oRcA@mail.gmail.com> <alpine.DEB.2.00.1301301139490.18801@cobra.newdream.net> <CAF6-1L5z39ZsPwBz5yJWDvQoX7UaUZ5PVpUwfVhoBne56Z018Q@mail.gmail.com> <alpine.DEB.2.00.1301311141240.807@cobra.newdream.net> <510EA9A1.6070505@dachary.org> <CAOLwVUkUFvLihb6KbxG9Et7R_-ZTZpLQJYTjXm9TEe40V_ZRHg@mail.gmail.com> <CAOLwVUmYm0shGzdxfyg6LXSDgxa1hxF_Kh1oRDZXKtupvGB3VQ@mail.gmail.com> <CAOLwVUmNc_kZgbuKO4VY2mTBAV4FkwrLT=YdK1qJZhsK=sjbMQ@mail.gmail.com> <alpine.DEB.2.00.1302040930540.27333@cobra.newdream.net> <51102210.2040300@inktank.com> <CAOLwVUknsZnGeT8dT8KcjNy4OQ2V5j9sg0Ry_SCq+YDb8ctSdw@mail.gmail.com> <CAPYLRziYOHRVeT5Z
 bDWjn2K3q=pVc8=fTQqcfGMnmVd9UOLnyA@mail.gmail.com> <CAOLwVUn3o=RKci50jVEPvNmkGrzpi_43M=Cp_HGNYL6ye_68VA@mail.gmail.com> <CABYiri8C9pSCW0a+ZZhLHGWL3+Eh1=8Y6brsPc2S1fvB1G1dYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:42001 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532Ab3BPJJG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 16 Feb 2013 04:09:06 -0500
In-Reply-To: <CABYiri8C9pSCW0a+ZZhLHGWL3+Eh1=8Y6brsPc2S1fvB1G1dYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>, Gregory Farnum <greg@inktank.com>, Dan Mick <dan.mick@inktank.com>, Sage Weil <sage@inktank.com>, Loic Dachary <loic@dachary.org>, Sylvain Munaut <s.munaut@whatever-company.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 02/16/2013 08:09 AM, Andrey Korolyov wrote:
> Can anyone who hit this bug please confirm that your system contains =
libc 2.15+?
>

I've seen this with 0.56.2 as well on Ubuntu 12.04. Ubuntu 12.04 comes=20
with 2.15-0ubuntu10.3

Haven't gotten around to adding a heap profiler to it.

Wido

> On Tue, Feb 5, 2013 at 1:27 AM, S=C3=A9bastien Han <han.sebastien@gma=
il.com> wrote:
>> oh nice, the pattern also matches path :D, didn't know that
>> thanks Greg
>> --
>> Regards,
>> S=C3=A9bastien Han.
>>
>>
>> On Mon, Feb 4, 2013 at 10:22 PM, Gregory Farnum <greg@inktank.com> w=
rote:
>>> Set your /proc/sys/kernel/core_pattern file. :) http://linux.die.ne=
t/man/5/core
>>> -Greg
>>>
>>> On Mon, Feb 4, 2013 at 1:08 PM, S=C3=A9bastien Han <han.sebastien@g=
mail.com> wrote:
>>>> ok I finally managed to get something on my test cluster,
>>>> unfortunately, the dump goes to /
>>>>
>>>> any idea to change the destination path?
>>>>
>>>> My production / won't be big enough...
>>>>
>>>> --
>>>> Regards,
>>>> S=C3=A9bastien Han.
>>>>
>>>>
>>>> On Mon, Feb 4, 2013 at 10:03 PM, Dan Mick <dan.mick@inktank.com> w=
rote:
>>>>> ...and/or do you have the corepath set interestingly, or one of t=
he
>>>>> core-trapping mechanisms turned on?
>>>>>
>>>>>
>>>>> On 02/04/2013 11:29 AM, Sage Weil wrote:
>>>>>>
>>>>>> On Mon, 4 Feb 2013, S?bastien Han wrote:
>>>>>>>
>>>>>>> Hum just tried several times on my test cluster and I can't get=
 any
>>>>>>> core dump. Does Ceph commit suicide or something? Is it expecte=
d
>>>>>>> behavior?
>>>>>>
>>>>>>
>>>>>> SIGSEGV should trigger the usual path that dumps a stack trace a=
nd then
>>>>>> dumps core.  Was your ulimit -c set before the daemon was starte=
d?
>>>>>>
>>>>>> sage
>>>>>>
>>>>>>
>>>>>>
>>>>>>> --
>>>>>>> Regards,
>>>>>>> S?bastien Han.
>>>>>>>
>>>>>>>
>>>>>>> On Sun, Feb 3, 2013 at 10:03 PM, S?bastien Han <han.sebastien@g=
mail.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Hi Lo?c,
>>>>>>>>
>>>>>>>> Thanks for bringing our discussion on the ML. I'll check that =
tomorrow
>>>>>>>> :-).
>>>>>>>>
>>>>>>>> Cheer
>>>>>>>> --
>>>>>>>> Regards,
>>>>>>>> S?bastien Han.
>>>>>>>>
>>>>>>>>
>>>>>>>> On Sun, Feb 3, 2013 at 10:01 PM, S?bastien Han <han.sebastien@=
gmail.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> Hi Lo?c,
>>>>>>>>>
>>>>>>>>> Thanks for bringing our discussion on the ML. I'll check that=
 tomorrow
>>>>>>>>> :-).
>>>>>>>>>
>>>>>>>>> Cheers
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Regards,
>>>>>>>>> S?bastien Han.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Sun, Feb 3, 2013 at 7:17 PM, Loic Dachary <loic@dachary.or=
g> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> As discussed during FOSDEM, the script you wrote to kill the=
 OSD when
>>>>>>>>>> it
>>>>>>>>>> grows too much could be amended to core dump instead of just=
 being
>>>>>>>>>> killed &
>>>>>>>>>> restarted. The binary + core could probably be used to figur=
e out
>>>>>>>>>> where the
>>>>>>>>>> leak is.
>>>>>>>>>>
>>>>>>>>>> You should make sure the OSD current working directory is in=
 a file
>>>>>>>>>> system
>>>>>>>>>> with enough free disk space to accomodate for the dump and s=
et
>>>>>>>>>>
>>>>>>>>>> ulimit -c unlimited
>>>>>>>>>>
>>>>>>>>>> before running it ( your system default is probably ulimit -=
c 0 which
>>>>>>>>>> inhibits core dumps ). When you detect that OSD grows too mu=
ch kill it
>>>>>>>>>> with
>>>>>>>>>>
>>>>>>>>>> kill -SEGV $pid
>>>>>>>>>>
>>>>>>>>>> and upload the core found in the working directory, together=
 with the
>>>>>>>>>> binary in a public place. If the osd binary is compiled with=
 -g but
>>>>>>>>>> without
>>>>>>>>>> changing the -O settings, you should have a larger binary fi=
le but no
>>>>>>>>>> negative impact on performances. Forensics analysis will be =
made a lot
>>>>>>>>>> easier with the debugging symbols.
>>>>>>>>>>
>>>>>>>>>> My 2cts
>>>>>>>>>>
>>>>>>>>>> On 01/31/2013 08:57 PM, Sage Weil wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Thu, 31 Jan 2013, Sylvain Munaut wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> I disabled scrubbing using
>>>>>>>>>>>>
>>>>>>>>>>>>> ceph osd tell \* injectargs '--osd-scrub-min-interval 100=
0000'
>>>>>>>>>>>>> ceph osd tell \* injectargs '--osd-scrub-max-interval 100=
00000'
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> and the leak seems to be gone.
>>>>>>>>>>>>
>>>>>>>>>>>> See the graph at  http://i.imgur.com/A0KmVot.png  with the=
 OSD
>>>>>>>>>>>> memory
>>>>>>>>>>>> for the 12 osd processes over the last 3.5 days.
>>>>>>>>>>>> Memory was rising every 24h. I did the change yesterday ar=
ound 13h00
>>>>>>>>>>>> and OSDs stopped growing. OSD memory even seems to go down=
 slowly by
>>>>>>>>>>>> small blocks.
>>>>>>>>>>>>
>>>>>>>>>>>> Of course I assume disabling scrubbing is not a long term =
solution
>>>>>>>>>>>> and
>>>>>>>>>>>> I should re-enable it ... (how do I do that btw ? what wer=
e the
>>>>>>>>>>>> default values for those parameters)
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> It depends on the exact commit you're on.  You can see the =
defaults
>>>>>>>>>>> if
>>>>>>>>>>> you
>>>>>>>>>>> do
>>>>>>>>>>>
>>>>>>>>>>>    ceph-osd --show-config | grep osd_scrub
>>>>>>>>>>>
>>>>>>>>>>> Thanks for testing this... I have a few other ideas to try =
to
>>>>>>>>>>> reproduce.
>>>>>>>>>>>
>>>>>>>>>>> sage
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe c=
eph-devel"
>>>>>>>>>>> in
>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-in=
fo.html
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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


--=20
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
