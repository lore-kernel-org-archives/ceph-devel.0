From: Wido den Hollander <wido@widodh.nl>
Subject: Re: ceph for small cluster?
Date: Wed, 02 Jan 2013 13:17:14 +0100
Message-ID: <50E4254A.5000502@widodh.nl>
References: <50E0B457.70200@meetinghouse.net> <CADXA5U1ATB+1baCfBSHmzozRe3m-HhLxHQr3be1-dASgABPQYw@mail.gmail.com> <50E19DC5.303@meetinghouse.net> <CADXA5U0sGE9tyNKjbESS3_uxuYDrfUxE4rKg9UxC5TLkLcAAvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:50657 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3ABMRR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 07:17:17 -0500
In-Reply-To: <CADXA5U0sGE9tyNKjbESS3_uxuYDrfUxE4rKg9UxC5TLkLcAAvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Roy <imjustmatthew@gmail.com>
Cc: Miles Fidelman <mfidelman@meetinghouse.net>, ceph-devel <ceph-devel@vger.kernel.org>

On 01/01/2013 01:13 AM, Matthew Roy wrote:
> On Mon, Dec 31, 2012 at 9:14 AM, Miles Fidelman
> <mfidelman@meetinghouse.net> wrote:
>>
>>
>> Which raises another question: how are you combining drives within each OSD (raid, lvm, ?).
>>
>
> I'm not combining them, just running an OSD per data disk. On this
> cluster it's 2 disks for each of the 3 nodes.  I ended up that way
> only because I added the second disk to each node after getting
> started. There was an inktank blog post not too long ago about the
> performance of RAID'ed disks on OSDs that might provide quantitative
> justification for which route to go.
>
> Like Wido suggests, I also use a shared SSD for journal on each node.
> The journal's not really about speeding recovery from failed
> OSDs/disks, it's about being able to ACK writes faster and still
> retain integrity when Bad Things happen. If you're RAIDing with a
> battery-backed cache I think you can run without a journal, but I
> don't know the details on that.
>

That depends on the RAID controller. Some (like Areca I think) cache 
O_DIRECT writes in their write cache, but other still flush them 
directly to the disks although they have a cache with BBU.

I'd try to prevent using any RAID system with Ceph. Let the replication 
handle everything. The less hardware and complexity you add, the less 
can fail.

Wido

> Matthew
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

