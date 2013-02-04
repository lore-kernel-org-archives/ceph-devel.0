From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Mon, 04 Feb 2013 13:03:12 -0800
Message-ID: <51102210.2040300@inktank.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com> <CAF6-1L7HJMwqDPWwpkbqyTNbGbVhm_5pCbR73nTtnk0eD8xB4g@mail.gmail.com> <CAF6-1L4SfogRx0=46A8YR4dW1f-qOLNSh-7mT9HS_NKz9CjCZQ@mail.gmail.com> <alpine.DEB.2.00.1301270946190.16117@cobra.newdream.net> <CAF6-1L76dwdxGp2MGJTWFF4VwmzMT3a62tSTZhE8P1b-OOSBuw@mail.gmail.com> <alpine.DEB.2.00.1301300116210.4449@cobra.newdream.net> <CAF6-1L61H28xXDPZBC5Um0tyJLs2uGX8S7G2UjpL64fnt7oRcA@mail.gmail.com> <alpine.DEB.2.00.1301301139490.18801@cobra.newdream.net> <CAF6-1L5z39ZsPwBz5yJWDvQoX7UaUZ5PVpUwfVhoBne56Z018Q@mail.gmail.com> <alpine.DEB.2.00.1301311141240.807@cobra.newdream.net> <510EA9A1.6070505@dachary.org> <CAOLwVUkUFvLihb6KbxG9Et7R_-ZTZpLQJYTjXm9TEe40V_ZRHg@mail.gmail.com> <CAOLwVUmYm0shGzdxfyg6LXSDgxa1hxF_Kh1oRDZXKtupvGB
 3VQ@mail.gmail.com> <CAOLwVUmNc_kZgbuKO4VY2mTBAV4FkwrLT=YdK1qJZhsK=sjbMQ@mail.gmail.com> <alpine.DEB.2.00.1302040930540.27333@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:58627 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689Ab3BDVET (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 16:04:19 -0500
Received: by mail-pa0-f44.google.com with SMTP id kp1so803128pab.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 13:04:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302040930540.27333@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, Loic Dachary <loic@dachary.org>, Sylvain Munaut <s.munaut@whatever-company.com>, ceph-devel <ceph-devel@vger.kernel.org>

...and/or do you have the corepath set interestingly, or one of the 
core-trapping mechanisms turned on?

On 02/04/2013 11:29 AM, Sage Weil wrote:
> On Mon, 4 Feb 2013, S?bastien Han wrote:
>> Hum just tried several times on my test cluster and I can't get any
>> core dump. Does Ceph commit suicide or something? Is it expected
>> behavior?
>
> SIGSEGV should trigger the usual path that dumps a stack trace and then
> dumps core.  Was your ulimit -c set before the daemon was started?
>
> sage
>
>
>
>> --
>> Regards,
>> S?bastien Han.
>>
>>
>> On Sun, Feb 3, 2013 at 10:03 PM, S?bastien Han <han.sebastien@gmail.com> wrote:
>>> Hi Lo?c,
>>>
>>> Thanks for bringing our discussion on the ML. I'll check that tomorrow :-).
>>>
>>> Cheer
>>> --
>>> Regards,
>>> S?bastien Han.
>>>
>>>
>>> On Sun, Feb 3, 2013 at 10:01 PM, S?bastien Han <han.sebastien@gmail.com> wrote:
>>>> Hi Lo?c,
>>>>
>>>> Thanks for bringing our discussion on the ML. I'll check that tomorrow :-).
>>>>
>>>> Cheers
>>>>
>>>> --
>>>> Regards,
>>>> S?bastien Han.
>>>>
>>>>
>>>> On Sun, Feb 3, 2013 at 7:17 PM, Loic Dachary <loic@dachary.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> As discussed during FOSDEM, the script you wrote to kill the OSD when it
>>>>> grows too much could be amended to core dump instead of just being killed &
>>>>> restarted. The binary + core could probably be used to figure out where the
>>>>> leak is.
>>>>>
>>>>> You should make sure the OSD current working directory is in a file system
>>>>> with enough free disk space to accomodate for the dump and set
>>>>>
>>>>> ulimit -c unlimited
>>>>>
>>>>> before running it ( your system default is probably ulimit -c 0 which
>>>>> inhibits core dumps ). When you detect that OSD grows too much kill it with
>>>>>
>>>>> kill -SEGV $pid
>>>>>
>>>>> and upload the core found in the working directory, together with the
>>>>> binary in a public place. If the osd binary is compiled with -g but without
>>>>> changing the -O settings, you should have a larger binary file but no
>>>>> negative impact on performances. Forensics analysis will be made a lot
>>>>> easier with the debugging symbols.
>>>>>
>>>>> My 2cts
>>>>>
>>>>> On 01/31/2013 08:57 PM, Sage Weil wrote:
>>>>>> On Thu, 31 Jan 2013, Sylvain Munaut wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I disabled scrubbing using
>>>>>>>
>>>>>>>> ceph osd tell \* injectargs '--osd-scrub-min-interval 1000000'
>>>>>>>> ceph osd tell \* injectargs '--osd-scrub-max-interval 10000000'
>>>>>>>
>>>>>>> and the leak seems to be gone.
>>>>>>>
>>>>>>> See the graph at  http://i.imgur.com/A0KmVot.png  with the OSD memory
>>>>>>> for the 12 osd processes over the last 3.5 days.
>>>>>>> Memory was rising every 24h. I did the change yesterday around 13h00
>>>>>>> and OSDs stopped growing. OSD memory even seems to go down slowly by
>>>>>>> small blocks.
>>>>>>>
>>>>>>> Of course I assume disabling scrubbing is not a long term solution and
>>>>>>> I should re-enable it ... (how do I do that btw ? what were the
>>>>>>> default values for those parameters)
>>>>>>
>>>>>> It depends on the exact commit you're on.  You can see the defaults if
>>>>>> you
>>>>>> do
>>>>>>
>>>>>>   ceph-osd --show-config | grep osd_scrub
>>>>>>
>>>>>> Thanks for testing this... I have a few other ideas to try to reproduce.
>>>>>>
>>>>>> sage
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>> --
>>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>>
>>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
