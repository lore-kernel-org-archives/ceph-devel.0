From: Samuel Just <sjust@redhat.com>
Subject: Re: About BUG #16279
Date: Tue, 6 Sep 2016 07:32:41 -0700
Message-ID: <CAN=+7FXC0Sh7684Htze1Aqop+tGHZfzaru2CFK9B=fTog5izXQ@mail.gmail.com>
References: <CALZt5jygWSRUBh4uJS1O69zw4ZageJ+pg4nkxUuByyRrqsQsQw@mail.gmail.com>
 <CAN=+7FUwtmZYQ0wf4Juo5s9-QMpN7HBbehk+7mCY+qxRuhdKRw@mail.gmail.com> <CALZt5jziM6jvisL0cnK1RmHQQ+dgwDrnD8VotTUCcJAs8zUuqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35729 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755473AbcIFOcs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 10:32:48 -0400
Received: by mail-qk0-f180.google.com with SMTP id v123so219033580qkh.2
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 07:32:47 -0700 (PDT)
In-Reply-To: <CALZt5jziM6jvisL0cnK1RmHQQ+dgwDrnD8VotTUCcJAs8zUuqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

No, in that example the versions are different, 100'10 vs 122'10.
-Sam

On Tue, Sep 6, 2016 at 3:35 AM, Ning Yao <zay11022@gmail.com> wrote:
> So I think the notation in the code is misunderstanding?
>
> Or the code to get list<pg_log_entry_t> divergent in merge_log is wrong?
>
>     // move aside divergent items
>     list<pg_log_entry_t> divergent;
>     while (!log.empty()) {
>       pg_log_entry_t &oe = *log.log.rbegin();
>       /*
>        * look at eversion.version here.  we want to avoid a situation like:
>        *  our log: 100'10 (0'0) m 10000004d3a.00000000/head by
> client4225.1:18529
>        *  new log: 122'10 (0'0) m 10000004d3a.00000000/head by
> client4225.1:18529
>        *  lower_bound = 100'9
>        * i.e, same request, different version.  If the eversion.version is > the
>        * lower_bound, we it is divergent.
>        */
>       if (oe.version.version <= lower_bound.version)
> break;
>       dout(10) << "merge_log divergent " << oe << dendl;
>       divergent.push_front(oe);
>       log.log.pop_back();
>     }
>
> As the logic above,  divergent will contain all log_entry whose
> version is the same in olog and log?
> Regards
> Ning Yao
>
>
> 2016-09-02 23:50 GMT+08:00 Samuel Just <sjust@redhat.com>:
>> On Thu, Sep 1, 2016 at 7:44 PM, Ning Yao <zay11022@gmail.com> wrote:
>>> Hi, all
>>>
>>> we got the same issue http://tracker.ceph.com/issues/16279
>>>
>>> I think it is possible objiter->second->version == last_divergent_update?
>>>
>>> If olog is [200'5 ~ 200'10, 202'11~ 202'20] with object A: [200'5, 200'8]
>>>    log is [200'3 ~ 200'11], object A : [200'5, 200'8]
>>>
>>> Then after merge log os [200'3 ~ 200'10, 202'11~202'20] with divergent entry:
>>> object A: 200'5 and 200'8
>>
>> I think I'm misunderstanding your notation, but if I'm reading this
>> right, the entries at 200'5 and 200'8 would *not* be divergent -- the
>> only divergent entry would be 200'11.
>>
>>>
>>> first_divergent_update will be 200'5 and last_divergent_update will be
>>> 200'8 for object A. If can find it in current log, and the possible
>>> version the object A is equal or greater than 200'8.  So I am not sure
>>> it must be greater than last_divergent_update but may be equal?
>>>
>>> Am I missing something else?
>>>
>>> Regards
>>> Ning Yao
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
