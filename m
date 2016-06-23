From: Haomai Wang <haomai@xsky.com>
Subject: Re: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Thu, 23 Jun 2016 15:44:45 +0800
Message-ID: <CACJqLybYMjf9F6XVcVtshPV3qaKBMfLbvPOs49pG2xO2yYsE5w@mail.gmail.com>
References: <0a8a87d5-777c-7e78-0400-cf1978217928@digiware.nl>
 <a95dcbdc-2447-076a-516d-bb717d58ca0c@digiware.nl> <CACJqLyYq5vBMokPwdG_D=4qPAOp0tDyMe07gzOZWS6K-61J0nA@mail.gmail.com>
 <1fef436f-c122-e66d-59c9-257bc2360722@digiware.nl> <0cb2f18c-a7e1-7a20-fab6-c4206e8a4aec@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0120.outbound.protection.outlook.com ([104.47.126.120]:6208
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750919AbcFWHpJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jun 2016 03:45:09 -0400
Received: by mail-vk0-f50.google.com with SMTP id d185so94625236vkg.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2016 00:44:58 -0700 (PDT)
In-Reply-To: <0cb2f18c-a7e1-7a20-fab6-c4206e8a4aec@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 23, 2016 at 3:22 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 23-6-2016 00:16, Willem Jan Withagen wrote:
>> On 22-6-2016 16:36, Haomai Wang wrote:
>>> Oh, sorry. I still realize you are testing on kqueue event backend.
>>>
>>> I submit a pr to fix this. plz help to verify whether it works for you
>>> since I don't have bsd handy...
>>>
>>> https://github.com/ceph/ceph/pull/9869
>>
>> I think add_event needs about the same treatment.
>> Trying, Testing ATM....
>
> errgh, not quite...
>
> It also generates errors when trying to delete EVFILT_READ (mask=2) from
> an eventfilter that has both READ and WRITE set (mask=3).
> Next to that the ms_async_messenger threads seem to be busy_waiting
> looping and loading a full CPU core per thread.
>
> So I think I need some testing code to see what the requirements of
> kqueue actually are, compared to what async_messenger does.
>
> Could be that if we want to go from (READ|WRITE) to either READ or WRITE
> the event needs to be deleted first and than added anew.

Hmm, I think I need to reread kqueue man page to figure out the problem...

>
> --WjW
>
