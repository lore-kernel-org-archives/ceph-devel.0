From: John Spray <john.spray@redhat.com>
Subject: Re: Slow file creating and deleting using bonnie ++ on Hammer
Date: Tue, 26 May 2015 16:40:42 +0100
Message-ID: <556493FA.3020600@redhat.com>
References: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>	<CAC6JEv9ZjK6nn0tK7HpQWMkMcYhn=Kbg77_+J1NxKTq0WWfJOQ@mail.gmail.com>	<CAMzumdYw_13u2nYDohMRbtD-tcKOTmJNn-x+mEFh2__hpf8XKw@mail.gmail.com>	<CAMzumdZgmsmBYHci2qq1qDs2nWmXq3StR9FbPT3FfHy_zi9qeA@mail.gmail.com>	<555F4C78.7060601@redhat.com>	<CAMzumdYaQ1sZUQPbb-42ZSLZgYxLY7CWWoyE5DsUpryd3s6mhQ@mail.gmail.com>	<CAAM7YAnxOp3Yo+F=mP4AvZBM1-7xD_N8A8h_H0cVNjOZ=S=cfg@mail.gmail.com>	<55645FA3.3090507@redhat.com>	<CAC6JEv9D-5LjmUea=K1OBfYDX_uJGyLc2xf1aduyurWBTO7iFA@mail.gmail.com> <CAMzumdZsGzykN4=t6QeqhG5Y=xge1+oWi-75PBUCi2xkE4NEbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56034 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbbEZPk4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 May 2015 11:40:56 -0400
In-Reply-To: <CAMzumdZsGzykN4=t6QeqhG5Y=xge1+oWi-75PBUCi2xkE4NEbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>, Gregory Farnum <greg@gregs42.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 26/05/2015 15:50, Barclay Jameson wrote:
> Thank you for the great explanation Zheng! That definitely shows what
> I was seeing with the bonnie++ test. What bad things would happen if I
> modified the config option mds_tick_interval to flush the journal to a
> second or less?

The MDS does various pieces of housekeeping according to that interval, 
so setting it extremely low will cause some CPU cycles to be wasted, and 
flushing the log more often will cause a larger number of smaller IOs to 
get generated.  I would be very surprised if decreasing it to approx 1s 
was harmful though.

On a busy real world system, other metadata operations will often drive 
log writes through faster than waiting for a tick.

> Does this also mean any custom code written should
> avoid use of fsync() if writing a large number of files?

You should call it only when your application requires it for 
consistency, and always expect it to be a high latency operation. Add up 
the latency from your client to your server and from the server to the 
disk, and the length of the IO queue on the disk, and then the return 
leg -- that is the *minimum* time you should expect to wait for an fsync.

For example, a real world workload creating N files in a directory would 
hopefully call fsync on the directory once at the end, rather than in 
between every file, unless you really do need to be sure that the dentry 
for the preceding file will be persistent before you start writing the 
next file.

Sometimes it's easier to reason about it in terms of concurrency: if you 
have a bunch of IOs that you could safely run in parallel in a thread 
each, then you shouldn't be fsyncing between them, just at the point you 
join them.

John
