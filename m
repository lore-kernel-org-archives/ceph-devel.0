From: Maxim Mikheev <mikhmv@gmail.com>
Subject: Re: Ceph copy-on-write
Date: Fri, 04 Nov 2011 15:34:34 -0400
Message-ID: <4EB43E4A.5050001@gmail.com>
References: <4EB35754.1040506@gmail.com> <CAORUGqAUW4Z-+KmfBwxXTpdsF+T52HrPuQuQzcSuA9Z=UA7DyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43026 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1KDTeh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 15:34:37 -0400
Received: by vcbf1 with SMTP id f1so686464vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 12:34:37 -0700 (PDT)
In-Reply-To: <CAORUGqAUW4Z-+KmfBwxXTpdsF+T52HrPuQuQzcSuA9Z=UA7DyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Tommi,

Thank you for your answer and filling bug.

I think it is a great performance already. Of course copy-on-write will 
be better.

Extra free space losses easy to explain. I am using 2  copies for 
redundancy and df update slowly.

I have another question. Looks like repository version 0.37 for ubuntu 
oneric has brocken dependencies
for ceph-client-tools.
Can you advice how can I install it?

Max

On 11/04/2011 01:10 PM, Tommi Virtanen wrote:
> On Thu, Nov 3, 2011 at 20:09, Maxim Mikheev<mikhmv@gmail.com>  wrote:
>> Is Ceph copy on write system?
> Ceph uses btrfs's copy-on-write properties internally, for cheap
> snapshots and journaling speed.
>
> As far as I know, Ceph does not currently expose reflink-style
> functionality to clients, and there's no common API either.
>
> I created a ticket http://tracker.newdream.net/issues/1680 to track
> this feature request.
>
>> If so, I think I do something wrong.
>> Files copying take too much time and disks space in my Ceph installation.
>> Could you like to help me resolve my problem?
> It seems you copied a 3075MB file from Ceph to Ceph, saw the free
> space in df drop 3395MB, and it took 109 seconds without sync, and
> you're asking why?
>
> First of all, the cephfs df statistics are allowed to update slowly,
> to improve performance. So that's not a reliable measure in the first
> place. Second, the df reports the underlying space free that ceph-osd
> sees, and that can be affected by other things such as journaling and
> unrelated files stored on the same filesystem. Also remember that ceph
> normally stores multiple copies of your data.
>
> As for writing at 31 MB/s, that's 310 Mbit/s, and if you have an OSD
> with just a single GigE network interface, the outgoing replication
> data stream uses the same network link. I've seen plenty of cheap GigE
> adapters max out at 600 Mbit/s, plus there's TCP and IP overhead. Lots
> of disks also max out at 40 MB/s. To troubleshoot further, you'll need
> to describe your cluster; how many OSDs, what kind of hardware and
> networking, what kind of performance do you see from the disks when
> accessed directly.
