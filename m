From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: some performance issue
Date: Fri, 01 Feb 2013 15:10:33 -0600
Message-ID: <510C2F49.8010401@inktank.com>
References: <CAB7xdinwhd6gmqbzeC7Gp+ugDbJhOcr1TwX-1KYg5=geWbT0+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:41010 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab3BAVK3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 16:10:29 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so5891927iak.24
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 13:10:28 -0800 (PST)
In-Reply-To: <CAB7xdinwhd6gmqbzeC7Gp+ugDbJhOcr1TwX-1KYg5=geWbT0+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/01/2013 02:20 PM, sheng qiu wrote:
> Hi,
>
> i did one experiment which gives some interesting result.
>
> i create two OSD (ext4), each is a SSD attached on the same PC. i also
> configure one monitor and one mds on that PC.
> so generally, my OSDs, monitor and mds locate on the same node.
>
> i set up the ceph service and mount the ceph also on a local directory
> on that PC. so client, OSDs, monitor and mds all on the same node.
> i suppose this will exclude the network communication cost.
>
> i run fio benchmark which create one 10GB file (larger than main
> memory) on the ceph mount point. it perform sequential read/write and
> random read/write on the file, and generate the throughput result.
>
> next i umount the ceph and stop ceph service. i create ext4 on the
> same SSD that used as OSD before. then run the same workloads and get
> the throughput result.
>
> here are the results:
>
> (throughput kb/s)Seq-read	Rand-read	Seq-write	Rand-write
> ceph	                 7378	4740	           790	1211
> ext4	                 58260	17334	 54697	34257
>
> as you see, the ceph has huge performance down, even monitor, mds,
> client and osds locate on the same physical machine.
> another interesting thing is the seq-write has lower throughput
> compared with random-write under ceph. not quite clear....
>
> does anyone have idea about why ceph has that performance down?

Hi Sheng,

Are you using RBD or CephFS (and kernel or userland clients?)  How much 
replication?  Also, what FIO settings?

In general, it is difficult to make distributed storage systems perform 
as well as local storage for small read/write workloads.  You need a lot 
of concurrency to hide the latencies, and if the local storage is 
incredibly fast (like an SSD!) you have a huge uphill battle.

Regarding the network, Even though you ran everything on localhost, ceph 
is still using TCP sockets to do all of the communication.

Having said that, I think we can do better than 790 IOPs for seq writes, 
even if it's 2x replication.  The trick is to find where in the stack 
things are getting held up.  You might want to look at tools like iostat 
and collectl, and look at some of the op latency data in the ceph admin 
socket.  A basic introduction is described in sebastian's article here:

http://www.sebastien-han.fr/blog/2012/08/14/ceph-admin-socket/

>
> Thanks,
> Sheng
>
>

