From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Wed, 22 Jun 2016 15:47:55 +0200
Message-ID: <a95dcbdc-2447-076a-516d-bb717d58ca0c@digiware.nl>
References: <0a8a87d5-777c-7e78-0400-cf1978217928@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static.ip-176-74-240-009.signet.nl ([176.74.240.9]:19173 "EHLO
	smtp.digiware.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcFVNsz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 09:48:55 -0400
In-Reply-To: <0a8a87d5-777c-7e78-0400-cf1978217928@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Haomai Wang <haomai@xsky.com>

This time also to the list.

On 20-6-2016 04:40, Haomai Wang wrote:
> On Mon, Jun 20, 2016 at 5:28 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> I 've just rebased, but now I'm getting BUG warnings in del_event()
>> calls. And I suspect that it is because of the snippet below...
>>
>> In STATE_CONNECTING EVENT_READABLE is set on sd, but we try a bit latter
>> to remove EVENT_WRITABLE. Which abort since asserts were added to the
>> kevent code.
>>
>> Could it be that in STATE_CONNECTING_RE EVENT_READABLE needs to be removed?
> 
> https://github.com/ceph/ceph/pull/9086/commits/a74ce419133881ff8618733a0501c4a47e1368e3

'mmmm,

That piece of code is already in the code that I'm testing.
So that could be the source of problems. I don't know.
Not going to pretend I understand anything of the statmachine for
setting up connections.

>> ./msg/async/AsyncConnection.cc at line 1014
>>     case STATE_CONNECTING_RE:
>>       {
>>         r = net.reconnect(get_peer_addr(), sd);
>>         if (r < 0) {
>>           ldout(async_msgr->cct, 1) << __func__ << " reconnect failed "
>> << dendl;
>>           goto fail;
>>         } else if (r > 0) {
>>           ldout(async_msgr->cct, 10) << __func__ << " nonblock connect
>> inprogress" << dendl;
>>           center->create_file_event(sd, EVENT_WRITABLE, read_handler);
>>           break;
>>         }
>>
>>       lderr(async_msgr->cct) << __func__ << ":" <<__LINE__
>>         << " delete_file_event(" << sd << ", EVENT_WRITABLE)"
>>         << dendl;
>>         center->delete_file_event(sd, EVENT_WRITABLE);
>>         state = STATE_CONNECTING_WAIT_BANNER;
>>         break;
>>       }

If I put debug code in Event and {Epoll,Kqueue}Event, and the trace for
this file handle is:
2016-06-22 12:54:59.183258 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).create_file_event create event
started fd=13 mask=1 original mask is 0
2016-06-22 12:54:59.183279 811653300 -1 KqueueDriver.add_event add event
fd = 13 to kqfd = 10 cur_mask = 0 add_mask = 1
2016-06-22 12:54:59.183286 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).create_file_event create event
end fd=13 mask=1 original mask is 1
2016-06-22 12:54:59.183293 811653300 -1 Event(0x81164f448
owner=0x811653300 nevent=5000 time_id=1).delete_file_event delete event
started fd=13 mask=2 original mask is 1
2016-06-22 12:54:59.183304 811653300 -1 KqueueDriver.del_event delete
event fd = 13 to kqfd = 10 cur_mask = 1 delmask = 2
2016-06-22 12:54:59.183308 811653300 -1 KqueueDriver.del_event unable to
delete event: (2) No such file or directory. for handle: 13 kqfd handle: 10

And then we hit assert(BUG)

Looking at the e_poll output from Linux, it looks like:
2016-06-22 15:28:15.237564 7ff58d7fa700 -1 Event(0x7ff5900b1038
owner=140692617668352 nevent=5000 time_id=1).create_file_event create
event started fd=13 mask=1 original mask is 0
2016-06-22 15:28:15.237595 7ff58d7fa700 -1 Event(0x7ff5900b1038
owner=140692617668352 nevent=5000 time_id=1).create_file_event create
event end fd=13 mask=1 original mask is 1
2016-06-22 15:28:15.237609 7ff58d7fa700 -1 Event(0x7ff5900b1038
owner=140692617668352 nevent=5000 time_id=1).delete_file_event delete
event started fd=13 mask=2 original mask is 1
2016-06-22 15:28:15.237613 7ff58d7fa700 -1 EpollDriver.del_event delete
event fd = 13 to epfd = 10 cur_mask = 1 delmask = 2

The access pattern is the same, but that does not generate an error.

I think the error message actually means that there is no event in the
Keventqueue, that actually matches. And that is because EVENT_WRITABLE
is asked to be removed, but the event actually only has EVENT_READ
activated. So the EV_DELETE fails.

I have not tried this trace on Linux to see what is the result there.
Perhaps Linux e_poll stuff does not really care if you want a
non-existent filter?
But the assert is rather detrimental on FreeBSD code :(

But the other strange part for me is that the code tries to remove
events that are really not inserted....
Wether that is a problem in the current code? I do not know, but it
certainly strange.

--WjW


