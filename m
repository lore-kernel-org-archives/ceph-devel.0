From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd and the next jewel release v10.2.3
Date: Wed, 24 Aug 2016 11:30:40 -0400
Message-ID: <CA+aFP1DambKmEX3SFO-Y4VZ-rJpMBAdFVTz3AJTwbFh7fDdg7g@mail.gmail.com>
References: <57BC0D5F.5050006@dachary.org> <CA+aFP1CzY1UFgzUcWnCDAhqKH+p95gkhSZ7k+XhsuStm_y0ZnQ@mail.gmail.com>
 <57BC4BB1.2090803@dachary.org> <57BC5064.1030109@dachary.org>
 <57BC50DA.5040804@dachary.org> <CA+aFP1AiswTvMpd9Agcw6s4qFJgvjRF5HH4=VuCz5Yopu_+R6Q@mail.gmail.com>
 <57BD47C9.2080704@dachary.org>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36127 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbcHXPbN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 11:31:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id h186so7873179pfg.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 08:30:41 -0700 (PDT)
In-Reply-To: <57BD47C9.2080704@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

+1 -- results look as expected.

On Wed, Aug 24, 2016 at 3:07 AM, Loic Dachary <loic@dachary.org> wrote:
> It is running at http://pulpito.ceph.com/loic-2016-08-24_06:41:40-rbd-jewel-backports-distro-basic-smithi/
>
> On 23/08/2016 15:35, Jason Dillaman wrote:
>> OK -- in that case, feel free to kick off an rbd test run after it
>> builds.  If it ends up being after-hours, let me know and I can kick
>> it off.
>>
>> Thanks
>>
>> On Tue, Aug 23, 2016 at 9:34 AM, Loic Dachary <loic@dachary.org> wrote:
>>> The jewel-backport branch also has all the pull request you mentionned below. The details of what it contains are at http://tracker.ceph.com/issues/16344#note-32
>>>
>>> On 23/08/2016 15:32, Loic Dachary wrote:
>>>> The jewel-backport branch is in gitbuilder with the http://tracker.ceph.com/issues/16950 backport https://github.com/ceph/ceph/pull/10827 . I'll wait to hear from you before scheduling a run however.
>>>>
>>>> On 23/08/2016 15:12, Loic Dachary wrote:
>>>>> Ok. Let me know when the backport of http://tracker.ceph.com/issues/16950 is ready and I'll schedule tests. If you'd rather do the test yourself, that's also fine with me :-)
>>>>>
>>>>> Cheers
>>>>>
>>>>> On 23/08/2016 15:06, Jason Dillaman wrote:
>>>>>> If at all possible, I would definitely like to see the following
>>>>>> included in 10.2.3 since users are hitting it in the field:
>>>>>>
>>>>>> http://tracker.ceph.com/issues/16950
>>>>>>
>>>>>> ... and given that would require another RBD test run prior to merge,
>>>>>> I would also like to include the following which already have open
>>>>>> PRs:
>>>>>>
>>>>>> https://github.com/ceph/ceph/pull/10791
>>>>>> https://github.com/ceph/ceph/pull/10790
>>>>>> https://github.com/ceph/ceph/pull/10792
>>>>>> https://github.com/ceph/ceph/pull/10646
>>>>>> https://github.com/ceph/ceph/pull/10647
>>>>>> https://github.com/ceph/ceph/pull/10786
>>>>>>
>>>>>> I can create a PR for the high priority issue this morning.
>>>>>>
>>>>>> On Tue, Aug 23, 2016 at 4:46 AM, Loic Dachary <loic@dachary.org> wrote:
>>>>>>> Hi Jason,
>>>>>>>
>>>>>>> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel received (I think :-) enough rbd backports to cut the release. It was more challenging than usual and I'd like to thank you and Mykola for helping with the tricky parts.
>>>>>>>
>>>>>>> Do you think the jewel branch is ready for QE to start their own round of testing ?
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> --
>>>>>>> Loïc Dachary, Artisan Logiciel Libre
>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>> --
>>> Loïc Dachary, Artisan Logiciel Libre
>>
>>
>>
>
> --
> Loïc Dachary, Artisan Logiciel Libre



-- 
Jason
