From: Haomai Wang <haomai@xsky.com>
Subject: Re: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Thu, 23 Jun 2016 20:28:12 +0800
Message-ID: <CACJqLyaKyX3goCLNWOz0mTgX3srHcnoT0kfAANxJakH47S1ZXg@mail.gmail.com>
References: <0a8a87d5-777c-7e78-0400-cf1978217928@digiware.nl>
 <a95dcbdc-2447-076a-516d-bb717d58ca0c@digiware.nl> <CACJqLyYq5vBMokPwdG_D=4qPAOp0tDyMe07gzOZWS6K-61J0nA@mail.gmail.com>
 <1fef436f-c122-e66d-59c9-257bc2360722@digiware.nl> <0cb2f18c-a7e1-7a20-fab6-c4206e8a4aec@digiware.nl>
 <CACJqLybYMjf9F6XVcVtshPV3qaKBMfLbvPOs49pG2xO2yYsE5w@mail.gmail.com> <bb185193-c0d4-3b8c-4ac7-2640c24134b0@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-os2jpn01on0120.outbound.protection.outlook.com ([104.47.92.120]:55965
	"EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750957AbcFWM21 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jun 2016 08:28:27 -0400
Received: by mail-vk0-f46.google.com with SMTP id j2so103301556vkg.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2016 05:28:21 -0700 (PDT)
In-Reply-To: <bb185193-c0d4-3b8c-4ac7-2640c24134b0@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 23, 2016 at 5:40 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 23-6-2016 09:44, Haomai Wang wrote:
>> On Thu, Jun 23, 2016 at 3:22 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> On 23-6-2016 00:16, Willem Jan Withagen wrote:
>>>> On 22-6-2016 16:36, Haomai Wang wrote:
>>>>> Oh, sorry. I still realize you are testing on kqueue event backend.
>>>>>
>>>>> I submit a pr to fix this. plz help to verify whether it works for you
>>>>> since I don't have bsd handy...
>>>>>
>>>>> https://github.com/ceph/ceph/pull/9869
>>>>
>>>> I think add_event needs about the same treatment.
>>>> Trying, Testing ATM....
>>>
>>> errgh, not quite...
>>>
>>> It also generates errors when trying to delete EVFILT_READ (mask=2) from
>>> an eventfilter that has both READ and WRITE set (mask=3).
>>> Next to that the ms_async_messenger threads seem to be busy_waiting
>>> looping and loading a full CPU core per thread.
>>>
>>> So I think I need some testing code to see what the requirements of
>>> kqueue actually are, compared to what async_messenger does.
>>>
>>> Could be that if we want to go from (READ|WRITE) to either READ or WRITE
>>> the event needs to be deleted first and than added anew.
>>
>> Hmm, I think I need to reread kqueue man page to figure out the problem...
>
> Hi,
>
> Perhaps we should take the Ceph-dev list off the CC, since I doubt that
> they would like to read all the details. Feel free to do so, and mail me
> private until there is a resolution.
>
> Eh, perhaps it is in the manual page but it is rather vague in how it
> deals with the filters internally. And how you can modify event-filters
> already in the kqueue filterlist.
>
> You currently assume that the filters you assign are internally
> summarised such that you can do
>         add(read)
>         add(write)
>         delete(read|write)
>
> Or      add(read|write)
>         delete(write)
>         delete(read)
>
> What I read in the man page:
> EV_ADD       Adds the event to the kqueue.  Re-adding an existing event
>              will modify the parameters of the original event, and not
>              result in a duplicate entry.  Adding an event automatically
>              enables it, unless overridden by the EV_DISABLE flag.
>
> EV_DELETE    Removes the event from the kqueue.  Events which are
>              attached to file descriptors are automatically deleted on
>              the last close of the descriptor.
>
> So I would read that as that you need to do any changes to the
> filter-flags doing EV_ADD. And only removing the full event should be
> done with EV_DELETE.
> And an event is identified by its "ident" only:
>  ident      Value used to identify this event.  The exact interpretation
>             is determined by the attached filter, but often is a file
>             descriptor.
> So any of the other settings are not used in determining which event to
> add/modify/delete.
>
> Now the problem lies in the "modify" word in EV_ADD. I woul;d read that
> as overwrite. Your code assumes that flags are merged when doing ADD or
> DELETE.
>
> I think the code should use ADD with the settings/mask that needs to be
> there, and only DELETE when the required filtermask is actually 0.
>

I just remember four years ago(I'm a bsd fan that time) I have written
kqueue codes(https://github.com/yuyuyu101/twemproxy/commit/68d04283ba8d58142e544868842307d66d8f4600#diff-ea1f3d7f51a1def56821fefd14eb8560R193).

EV_SET(&event, fd, EVFILT_READ|EV_CLEAR, EV_ADD, 0, 0, data);

I think we can follow this....

> Does this make sense?
>
> --WjW
>
>
