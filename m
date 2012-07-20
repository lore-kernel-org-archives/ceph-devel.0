From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Sat, 21 Jul 2012 02:23:25 +0930
Message-ID: <50098D05.2080704@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <50080D9D.8010306@bashkirtsev.com> <50085518.80507@inktank.com> <500984AC.9030104@bashkirtsev.com> <CADvuQRG1z0YQezCoJhCNFnC+03UDv6H3aJPUWBcbBw3-iUnA8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:41440 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2GTQxg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 12:53:36 -0400
In-Reply-To: <CADvuQRG1z0YQezCoJhCNFnC+03UDv6H3aJPUWBcbBw3-iUnA8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 21/07/2012 2:12 AM, Tommi Virtanen wrote:
> On Fri, Jul 20, 2012 at 9:17 AM, Vladimir Bashkirtsev
> <vladimir@bashkirtsev.com> wrote:
>> not running. So I ended up rebooting hosts and that's where fun begin: btrfs
>> has failed to umount , on boot up it spit out "btrfs: free space inode
>> generation (0) did not match free space cache generation (177431)". I have
>> not started ceph and made an attempt to umount and umount just froze.
>> Another reboot: same stuff. I have rebooted second host and it came back
>> with the same error. So in effect I was unable to mount btrfs and read it:
>> no wonder that ceph was unable to run. Actually according to mons ceph was
> The btrfs developers tend to be good about bug reports that severe --
> I think you should email that mailing list and ask if that sounds like
> known bug, and ask what information you should capture if it happens
> again (assuming the workload is complex enough that you can't easily
> capture/reproduce all of that).
Well... Work load was fairly high - not something usually happening on 
MySQL. Our client keeps imagery in MySQL and his system was regenerating 
images (it takes hi-res image and produces five or six images which are 
of smaller size + watermark). Stuff runs imagemagick which keeps its 
temporary data on disk (and to ceph it is not really temporary data - it 
is data which must be committed to osds) and then innodb in MySQL stores 
results - which of course creates number of pages and so it appears as 
random writes to underlying file system. And from what I have seen write 
traffic created by this process was in TB range (my whole ceph cluster 
is just 3.3TB). So it was considerable amount of changes on filesystem.

I guess if we will start that process again we will end up with the 
similar result in few days - but by some reason I don't want to try it 
in production system :)

I can scavenge something from logs and post it to btrfs devs. Thanks for 
a tip.
>
>> But it leaves me with very final question: should we rely on btrfs at this
>> point given it is having such major faults? What if I will use well tested
>> by time ext4?
> You might want to try xfs. We hear/see problems with all three, but
> xfs currently seems to have the best long-term performance and
> reliability.
>
> I'm not sure if anyone's run detailed tests with ext4 after the
> xattrs-in-leveldb feature; before that, we ran into fs limitations.
That's what I was thinking: before xattrs-in-leveldb I even did not 
consider ext4 as viable alternative but now it may be reasonable to give 
it a go. Or even may be have a mix of osds backed by different file 
systems? What is devs opinion on this?
