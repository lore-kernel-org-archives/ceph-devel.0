From: Matthew Roy <imjustmatthew@gmail.com>
Subject: Re: ceph for small cluster?
Date: Mon, 31 Dec 2012 19:13:11 -0500
Message-ID: <CADXA5U0sGE9tyNKjbESS3_uxuYDrfUxE4rKg9UxC5TLkLcAAvg@mail.gmail.com>
References: <50E0B457.70200@meetinghouse.net>
	<CADXA5U1ATB+1baCfBSHmzozRe3m-HhLxHQr3be1-dASgABPQYw@mail.gmail.com>
	<50E19DC5.303@meetinghouse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:53950 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3AAANM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 19:13:12 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so5885217dak.11
        for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 16:13:11 -0800 (PST)
In-Reply-To: <50E19DC5.303@meetinghouse.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Miles Fidelman <mfidelman@meetinghouse.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 31, 2012 at 9:14 AM, Miles Fidelman
<mfidelman@meetinghouse.net> wrote:
>
>
> Which raises another question: how are you combining drives within each OSD (raid, lvm, ?).
>

I'm not combining them, just running an OSD per data disk. On this
cluster it's 2 disks for each of the 3 nodes.  I ended up that way
only because I added the second disk to each node after getting
started. There was an inktank blog post not too long ago about the
performance of RAID'ed disks on OSDs that might provide quantitative
justification for which route to go.

Like Wido suggests, I also use a shared SSD for journal on each node.
The journal's not really about speeding recovery from failed
OSDs/disks, it's about being able to ACK writes faster and still
retain integrity when Bad Things happen. If you're RAIDing with a
battery-backed cache I think you can run without a journal, but I
don't know the details on that.

Matthew
