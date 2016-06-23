From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Thu, 23 Jun 2016 09:22:29 +0200
Message-ID: <0cb2f18c-a7e1-7a20-fab6-c4206e8a4aec@digiware.nl>
References: <0a8a87d5-777c-7e78-0400-cf1978217928@digiware.nl>
 <a95dcbdc-2447-076a-516d-bb717d58ca0c@digiware.nl>
 <CACJqLyYq5vBMokPwdG_D=4qPAOp0tDyMe07gzOZWS6K-61J0nA@mail.gmail.com>
 <1fef436f-c122-e66d-59c9-257bc2360722@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static.ip-176-74-240-009.signet.nl ([176.74.240.9]:45110 "EHLO
	smtp.digiware.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbcFWHWs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2016 03:22:48 -0400
In-Reply-To: <1fef436f-c122-e66d-59c9-257bc2360722@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 23-6-2016 00:16, Willem Jan Withagen wrote:
> On 22-6-2016 16:36, Haomai Wang wrote:
>> Oh, sorry. I still realize you are testing on kqueue event backend.
>>
>> I submit a pr to fix this. plz help to verify whether it works for you
>> since I don't have bsd handy...
>>
>> https://github.com/ceph/ceph/pull/9869
> 
> I think add_event needs about the same treatment.
> Trying, Testing ATM....

errgh, not quite...

It also generates errors when trying to delete EVFILT_READ (mask=2) from
an eventfilter that has both READ and WRITE set (mask=3).
Next to that the ms_async_messenger threads seem to be busy_waiting
looping and loading a full CPU core per thread.

So I think I need some testing code to see what the requirements of
kqueue actually are, compared to what async_messenger does.

Could be that if we want to go from (READ|WRITE) to either READ or WRITE
the event needs to be deleted first and than added anew.

--WjW

