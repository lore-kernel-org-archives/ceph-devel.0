From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 07:37:31 -0600
Message-ID: <50F7FE9B.6050908@inktank.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>	<50F72150.7080002@inktank.com>	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com> <CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:64687 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3AQNhg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 08:37:36 -0500
Received: by mail-ia0-f173.google.com with SMTP id l29so409103iag.18
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 05:37:35 -0800 (PST)
In-Reply-To: <CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joseph Glanville <joseph.glanville@orionvm.com.au>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 01/17/2013 07:32 AM, Joseph Glanville wrote:
> On 17 January 2013 20:46, Gandalf Corvotempesta
> <gandalf.corvotempesta@gmail.com>  wrote:
>> 2013/1/16 Mark Nelson<mark.nelson@inktank.com>:
>
>> I don't know if I have to use a single two port IB card (switch
>> redundancy and no card redundancy) or
>> I have to use two single port cards. (or a single one port IB?)
>
> On the topic of IB..
>
> But slightly off-topic all the same..  I would love to attempt getting
> Ceph running on rsockets if I could find the time (alas we don't run
> Ceph).
> rsockets is a fully userland implementation of BSD sockets over RDMA,
> supporting fork and all the usual goodies, in theory unless you are
> using the kernel RBD module (of the kernel FS module etc) you should
> be able to run it on rsockets and enjoy a considerable performance
> increase.
>
> rsockets is available in the librdmacm git up on Open Fabrics and dev
> + support happens on the linux-rdma list.
>

There's been some talk about rsockets on the list before.  I think there 
are a couple of different folks that have tried (succeeded?) in getting 
it working.  barring that, it sounds like if you tune interrupt affinity 
settings and various other bits you can get IPoIB up into the 2GB/s+ 
range which while not RDMA speed, is at least better than 10GbE.

-- 
Mark Nelson
Performance Engineer
Inktank
