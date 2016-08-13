From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Questions about Accepter::stop()
Date: Sat, 13 Aug 2016 13:14:18 +0200
Message-ID: <8bfc92da-efd2-6783-b74a-9ed3612a6f8a@digiware.nl>
References: <3492e51f-021b-2c6e-2242-2237add24784@digiware.nl>
 <alpine.DEB.2.11.1608122056380.17762@piezo.us.to>
 <b6ef2b22-e693-afcc-1772-73ab2d6869cc@digiware.nl>
 <67687e3b-f514-b727-ca3a-173c82fc3860@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:44909 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbcHMLO0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 13 Aug 2016 07:14:26 -0400
In-Reply-To: <67687e3b-f514-b727-ca3a-173c82fc3860@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 13-8-2016 00:31, Willem Jan Withagen wrote:
> On 12-8-2016 23:40, Willem Jan Withagen wrote:
>> On 12-8-2016 22:58, Sage Weil wrote:
>>> On Fri, 12 Aug 2016, Willem Jan Withagen wrote:
>>>> Hi,
>>>>
>>>> Still working on finding out why my OSD is not comming back up.
>>>> Looking at the OSD it seems to recover, but it is not reported back to
>>>> the other OSD and mons.
>>>>
>>>> Below some of the code from
>>>> 	./src/msg/simple/Accepter.cc
>>>>
>>>> Turns out that the thread freezes on the join, and the complicating
>>>> factor is that shoutdown always reports that
>>>>   accepter.stop shutdown failed:  errno 57 (57) Socket is not connected
>>>>
>>>> Then the code goes into the join, and gets stuck in there.
>>>>
>>>> So I've execluded that part of the code, and the close section.
>>>>
>>>> That seems to work, but I would very much some more opinions on this.
>>>> Original code was doen by Sage, but John Spray added a bit of exclusion
>>>> on the join()
>>>>
>>>> And even with this change I cannot complete
>>>> 	cephtool-test-mon.sh
>>>> But I'm getting a lot further down the test.
>>>
>>> This is the thread we need to wake up in Accepter::entry():
>>>
>>>     ldout(msgr->cct,20) << "accepter calling poll" << dendl;
>>>     int r = poll(&pfd, 1, -1);
>>>     if (r < 0)
>>>       break;
>>>     ldout(msgr->cct,20) << "accepter poll got " << r << dendl;
>>>
>>>     if (pfd.revents & (POLLERR | POLLNVAL | POLLHUP))
>>>       break;
>>>
>>>     ldout(msgr->cct,10) << "pfd.revents=" << pfd.revents << dendl;
>>>     if (done) break;
>>>
>>> It shutdown(2) isn't the "right" (portable) way to kick the thread blocked 
>>> on poll(2) on an accept socket, maybe there is some other socket call that 
>>> is more appropriate?  It just needs to wake up poll so that we either see 
>>> an error event queued or done == true.
>>
>> Yup,  that is what I see in the Linux code.
>> Poll returns with revent = 16 = POLLHUP.
>>
>> Now I'm sort of wondering what I can do with a socket that is already
>> disconnected.... Somebody has to have disconnected the connection.
>> And why the poll waiting on it does not report that....
>> perhaps calling close on it does signal the HUP.
>>
>> SHUT_RDWR has a few comments (at least in the FreeBSD manpage) but they
>> do not seem to fit this case.
>>
>> Any idea oh who would have disconnected this socket?
>>
>> Back to reading more manual pages. And trying to figure out the state
>> machine of a socket. :(
> 
> Right,
> 
> If I start closing the socket, I'm getting revent = 32.
> Which is POLLINVAL
> 	Invalid request: fd not open (output only).
> 
> Available both on Linux and FreeBSD. On FreeBSD it is always to get that
> in revents, even if not asked for. 8-;
> So I guess adding that to the break expression is useful.
> 
> And tack the closing somewhere into the stop. And make sure that join()
> is called.

Hi Sage,

Got a pull in #10720 that does work on my end...
I left the close at the end in so other OSes get the change to close the
socket when shutdown triggered the poll().

--WjW


