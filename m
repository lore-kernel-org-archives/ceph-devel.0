From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Thu, 23 Jun 2016 00:09:30 +0200
Message-ID: <de2c1722-8b90-90ee-f0de-dd72574b667e@digiware.nl>
References: <0a8a87d5-777c-7e78-0400-cf1978217928@digiware.nl>
 <a95dcbdc-2447-076a-516d-bb717d58ca0c@digiware.nl>
 <CACJqLyYq5vBMokPwdG_D=4qPAOp0tDyMe07gzOZWS6K-61J0nA@mail.gmail.com>
 <60b10792-1e48-56d0-c5d7-da7db5206f82@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static.ip-176-74-240-009.signet.nl ([176.74.240.9]:21626 "EHLO
	smtp.digiware.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcFVWKC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 18:10:02 -0400
In-Reply-To: <60b10792-1e48-56d0-c5d7-da7db5206f82@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 22-6-2016 17:25, Willem Jan Withagen wrote:
> On 22-6-2016 16:36, Haomai Wang wrote:
>> Oh, sorry. I still realize you are testing on kqueue event backend.
>>
>> I submit a pr to fix this. plz help to verify whether it works for you
>> since I don't have bsd handy...
>>
>> https://github.com/ceph/ceph/pull/9869
> 
> Yup,
> Saw this flying by.
> Got to finish the running 'make check', and then I'll put your stuff in
> and let you know.

Slightly better, but still not quite there yet:
2016-06-22 23:49:22.862340 811653300 -1 KqueueDriver.add_event add event
fd = 13 to kqfd = 10 cur_mask = 0 add_mask = 1
2016-06-22 23:49:22.862346 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).create_file_event create event
end fd=13 mask=1 original mask
 is 1
2016-06-22 23:49:22.862353 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).delete_file_event delete event
started fd=13 mask=2 original
mask is 1
2016-06-22 23:49:22.862364 811653300 -1 KqueueDriver.del_event delete
event fd = 13 to kqfd = 10 cur_mask = 1 delmask = 2
2016-06-22 23:49:22.862367 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).delete_file_event delete event
end fd=13 mask=2 original mask
 is 1
2016-06-22 23:49:22.862382 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).create_file_event create event
started fd=13 mask=2 original
mask is 1
2016-06-22 23:49:22.862386 811653300 -1 KqueueDriver.add_event add event
fd = 13 to kqfd = 10 cur_mask = 1 add_mask = 2
2016-06-22 23:49:22.862391 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).create_file_event create event
end fd=13 mask=2 original mask
 is 3
2016-06-22 23:49:22.863084 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).delete_file_event delete event
started fd=13 mask=2 original
mask is 3
2016-06-22 23:49:22.863095 811653300 -1 KqueueDriver.del_event delete
event fd = 13 to kqfd = 10 cur_mask = 3 delmask = 2
2016-06-22 23:49:22.863100 811653300 -1 KqueueDriver.del_event unable to
delete event: (22) Invalid argument. for handle: 13 kqfd handle: 10
msg/async/Event.cc: In function 'void
EventCenter::delete_file_event(int, int)' thread 811653300 time
2016-06-22 23:49:22.863112
msg/async/Event.cc: 210: FAILED assert(0 == "del_event BUG!")
 ceph version Development (no_version)

But there is a small type in the patch, the last two lines must be:
  if (mask & EVENT_WRITABLE)
    filter |= EVFILT_WRITE;

After which there are no more asserts.
So you need to fix this.

--WjW

