From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: 12.2.2 Luminous validation status
Date: Wed, 29 Nov 2017 16:11:46 -0500
Message-ID: <CAKOnarkgAgS7o4rr2zRn3DEo473xzH0oG8icT_Yj6F+_bMwrJQ@mail.gmail.com>
References: <CAMMFjmH0-XbJ1P431bErnMS1BEaU3Ln9XhVMPbEte3ixm+YSzQ@mail.gmail.com>
 <9162c114-44ea-3153-fc3f-76fbd20e06b4@redhat.com> <CAMMFjmG_6UrMOEWmanz76GyGsJioFLt-ZAYRaYzQJ72LH2pRqA@mail.gmail.com>
 <87vai1ugkh.fsf@suse.com> <CAMMFjmGke9G7i2OLgBxQAdO+irkO7CXrT2zgKF1_KJnGPkE4yw@mail.gmail.com>
 <CAMMFjmGv13B5qLqZj+ZwhDY9H=XgqTJ+hqTFdDeE4vK04iBFTA@mail.gmail.com>
 <CAJE9aOMOm8mtSQ8VPb974NRCTvS989_Sxxs48uvw3n_uDDygBA@mail.gmail.com> <CAMMFjmFGUaKq1NbAZHCVNBYd1_-xrh24yfhR_WdsQ9rMf4WxxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:41872 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbdK2VLr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Nov 2017 16:11:47 -0500
Received: by mail-it0-f42.google.com with SMTP id x28so5775548ita.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Nov 2017 13:11:47 -0800 (PST)
In-Reply-To: <CAMMFjmFGUaKq1NbAZHCVNBYd1_-xrh24yfhR_WdsQ9rMf4WxxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Abhishek Lekshmanan <abhishek@suse.com>, Josh Durgin <jdurgin@redhat.com>, Ilya Dryomov <idryomov@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, Casey Bodley <cbodley@redhat.com>

approve

On Wed, Nov 29, 2017 at 4:05 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Please see updates in the ticket http://tracker.ceph.com/issues/21830
> Since this release is taking longer then usual (since 11/9/17) and we
> have added several (many) commits on top of the initial RC, major
> suites were reran (on smaller subsets), see runs marked with "rerun on
> latest sha1"
>
> Remaining issues:
>
> rados - approved by Sage
>
> rgw - Matt, Casey pls review and approve
>
> fs - Patrick pls review and approve (looks like known issue to me)
>
> rbd - Jason approved (IRC chat)
>
> jewel-x - still is running to confirm latest fixes, Sage pls approve
>
> (I'd say green on smithi/xenial
> http://pulpito.ceph.com/yuriw-2017-11-29_16:03:25-upgrade:jewel-x-luminous-distro-basic-smithi/
> +
> http://pulpito.ceph.com/yuriw-2017-11-29_18:36:04-upgrade:jewel-x-luminous-distro-basic-smithi/
> open issue http://tracker.ceph.com/issues/21930)
>
> powercycle - approved by Sage
>
> Sage - back to you for final review and approval!
>
> Thx
> YuriW
>
> On Tue, Nov 28, 2017 at 7:56 AM, kefu chai <tchaikov@gmail.com> wrote:
>> On Fri, Nov 24, 2017 at 12:31 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>> and ceph-disk unresolved
>>
>> Yuri, https://github.com/ceph/ceph/pull/19205 should address the
>> ceph-disk test failure.
>>
>>>
>>> On Thu, Nov 23, 2017 at 8:30 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>>> I need to review latest results next week.
>>>> But AFAIR Ilya approved krbd
>>>>
>>>> rest is unresolved and jewel-x maybe not be resolved yet.
>>>>
>>>> On Thu, Nov 23, 2017 at 8:04 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>>>>> Yuri Weinstein <yweinste@redhat.com> writes:
>>>>>
>>>>>> Josh's fixed merged and tested, so rados is good.
>>>>>>
>>>>>> Ilya's kernel fix helped sort out knfs and kcepfs failures, however
>>>>>> some jobs still failed (see details/bugs in the ticket) and need
>>>>>> Patrick, Ilya review.
>>>>>
>>>>> I saw patrick's approval on cephfs, though k{RBD/cephfs} suites need
>>>>> Ilya's approval I belive.
>>>>>>
>>>>>> Please review the tests results and either approve or comment.
>>>>>>
>>>>>> Thx
>>>>>> YuriW
>>>>>>
>>>>>> On Wed, Nov 15, 2017 at 6:07 PM, Josh Durgin <jdurgin@redhat.com> wrote:
>>>>>>> On 11/15/2017 02:00 PM, Yuri Weinstein wrote:
>>>>>>>>
>>>>>>>> Details of this release summarized here
>>>>>>>> http://tracker.ceph.com/issues/21830#note-26
>>>>>>>
>>>>>>>
>>>>>>> The rados failures are due to a bug in the test fixed by:
>>>>>>>
>>>>>>> https://github.com/ceph/ceph/pull/18808
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>> --
>>>>> Abhishek Lekshmanan
>>>>> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
>>>>> HRB 21284 (AG Nürnberg)
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Regards
>> Kefu Chai



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
