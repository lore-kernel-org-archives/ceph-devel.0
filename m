From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: 12.2.2 Luminous validation status
Date: Thu, 23 Nov 2017 08:30:23 -0800
Message-ID: <CAMMFjmGke9G7i2OLgBxQAdO+irkO7CXrT2zgKF1_KJnGPkE4yw@mail.gmail.com>
References: <CAMMFjmH0-XbJ1P431bErnMS1BEaU3Ln9XhVMPbEte3ixm+YSzQ@mail.gmail.com>
 <9162c114-44ea-3153-fc3f-76fbd20e06b4@redhat.com> <CAMMFjmG_6UrMOEWmanz76GyGsJioFLt-ZAYRaYzQJ72LH2pRqA@mail.gmail.com>
 <87vai1ugkh.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:40988 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdKWQaZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Nov 2017 11:30:25 -0500
Received: by mail-oi0-f44.google.com with SMTP id h81so13480142oib.8
        for <ceph-devel@vger.kernel.org>; Thu, 23 Nov 2017 08:30:24 -0800 (PST)
In-Reply-To: <87vai1ugkh.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Ilya Dryomov <idryomov@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I need to review latest results next week.
But AFAIR Ilya approved krbd

rest is unresolved and jewel-x maybe not be resolved yet.

On Thu, Nov 23, 2017 at 8:04 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
> Yuri Weinstein <yweinste@redhat.com> writes:
>
>> Josh's fixed merged and tested, so rados is good.
>>
>> Ilya's kernel fix helped sort out knfs and kcepfs failures, however
>> some jobs still failed (see details/bugs in the ticket) and need
>> Patrick, Ilya review.
>
> I saw patrick's approval on cephfs, though k{RBD/cephfs} suites need
> Ilya's approval I belive.
>>
>> Please review the tests results and either approve or comment.
>>
>> Thx
>> YuriW
>>
>> On Wed, Nov 15, 2017 at 6:07 PM, Josh Durgin <jdurgin@redhat.com> wrote:
>>> On 11/15/2017 02:00 PM, Yuri Weinstein wrote:
>>>>
>>>> Details of this release summarized here
>>>> http://tracker.ceph.com/issues/21830#note-26
>>>
>>>
>>> The rados failures are due to a bug in the test fixed by:
>>>
>>> https://github.com/ceph/ceph/pull/18808
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Abhishek Lekshmanan
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
> HRB 21284 (AG Nürnberg)
