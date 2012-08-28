From: John Wright <jwright@psfc.mit.edu>
Subject: Re: MPI applications on ceph fs
Date: Tue, 28 Aug 2012 11:54:58 -0400
Message-ID: <8202724F-E1FF-4914-A474-A6449FA596F0@psfc.mit.edu>
References: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu> <alpine.DEB.2.00.1208262104360.11218@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:63693 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751816Ab2H1QAE convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Aug 2012 12:00:04 -0400
In-Reply-To: <alpine.DEB.2.00.1208262104360.11218@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Thanks for the suggestion.
I've attached two files with the dump from dmesg with the trigger set to true. They are for two nodes running 7 parallel processes each. The parallel process was launched via mpirun on 35e and you can see each of the parallel processes in its trace ('mitgcm') along with one ceph processes.  On the second node (37w) you see lots of ceph messages but no mitgcm processes (though there are mitgcm processes listed by 'ps' with state 'D'). This is the node on which the mounted ceph filesystem locks up and any process accessing it goes into state 'D': uninterruptible sleep. So far, it has always been the second node on which ceph locks. The lock up happens as soon as the executable is started presumably when it tries to open several new files from the 14  processes. Of course, an identical test u
 nder NFS mounted volumes works fine.

Interestingly, I did this after rebooting 37w from the last freeze up of the ceph volume and the first few times the application still froze with state 'D' on the second node and 'S' on the first but would terminate when mpirun was killed. But on the fourth try the ceph volume fully locked, requiring a reboot. In the past two tries the ceph lock up had occurred on the first mpirun test of mitgcm.

thanks for any feed back you give on this,

-John

The files are at
https://dl.dropbox.com/u/9688196/80_35e_dmsesg_gcm.log.1.1.txt
https://dl.dropbox.com/u/9688196/80_37w_dmesg.gcm.log.1.txt

(I tried to post yesterday, but it never made it to the list , maybe the files were too big?)

And because I forgot to CC the list, here's my reply to Mark's note:
> Hi Mark,
> the mpi application is attempting to open multiple files, one from each process, I believe it was at this step.  Several files are opened by process 0 for summary output. I cannot rule out that there is some concurrent opening or access going on since I am not the author of the code. That is one of my suspects and I'm writing some small programs to test that.  Not sure if the ceph osd's ever received a request or if things got locked up at the level of the kernel module for ceph on the node. 
> 
> I appreciate any suggestions. Does any one know if ceph has been tested in a parallel application environment where there often is a lot of file i/o concurrency?
> thanks,
> -john


On Aug 27, 2012, at 12:06 AM, Sage Weil wrote:

> Hi John,
> 
> Can you dump running threads?  'echo t > /proc/sysrq-trigger' and then 
> attach the output (from dmesg or kern.log).
> 
> Thanks!
> sage
> 
> 
> On Sun, 26 Aug 2012, John Wright wrote:
> 
>> Hi All,
>> We're running ceph 0.48 on  small three node test cluster. We've had good stability with I/O using dd and iozone especially after upgrading to 0.48. However, we're running into a repeatable lockup of the linux ceph client ( 3.3.5-2.fc16.x86_64 ) when running an mpi program that has simple I/O on a ceph mount. This is an mpi program running processes on two nodes. It is the remote node on which the ceph client locks up. The cient becomes immediately unresponsive and any attempt to access the mounted volume produces a process with status 'D'. I can see no indication in the server logs that it is ever contacted. Regular serial processes run fine on the volume. MPI runs on the nodes work fine when not using the ceph volume.
>> 
>> So any suggestions on where to look? Any one have an experience testing parallel programs on ceph?
>> 
>> thanks,
>> -john
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 

