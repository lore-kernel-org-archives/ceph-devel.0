From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 09:30:26 -0500
Message-ID: <44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
 <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
 <50F72150.7080002@inktank.com>
 <CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
 <CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
 <50F7FE9B.6050908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.177.14]:58866 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867Ab3AQOkH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 09:40:07 -0500
In-Reply-To: <50F7FE9B.6050908@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Joseph Glanville <joseph.glanville@orionvm.com.au>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Jan 17, 2013, at 8:37 AM, Mark Nelson <mark.nelson@inktank.com> wrote:

> On 01/17/2013 07:32 AM, Joseph Glanville wrote:
>> On 17 January 2013 20:46, Gandalf Corvotempesta
>> <gandalf.corvotempesta@gmail.com>  wrote:
>>> 2013/1/16 Mark Nelson<mark.nelson@inktank.com>:
>> 
>>> I don't know if I have to use a single two port IB card (switch
>>> redundancy and no card redundancy) or
>>> I have to use two single port cards. (or a single one port IB?)
>> 
>> On the topic of IB..
>> 
>> But slightly off-topic all the same..  I would love to attempt getting
>> Ceph running on rsockets if I could find the time (alas we don't run
>> Ceph).
>> rsockets is a fully userland implementation of BSD sockets over RDMA,
>> supporting fork and all the usual goodies, in theory unless you are
>> using the kernel RBD module (of the kernel FS module etc) you should
>> be able to run it on rsockets and enjoy a considerable performance
>> increase.
>> 
>> rsockets is available in the librdmacm git up on Open Fabrics and dev
>> + support happens on the linux-rdma list.
>> 
> 
> There's been some talk about rsockets on the list before.  I think there 
> are a couple of different folks that have tried (succeeded?) in getting 
> it working.  barring that, it sounds like if you tune interrupt affinity 
> settings and various other bits you can get IPoIB up into the 2GB/s+ 
> range which while not RDMA speed, is at least better than 10GbE.

IB DDR should get you close to 2 GB/s with IPoIB. I have gotten our IB QDR PCI-E Gen. 2 up to 2.8 GB/s measured via netperf with lots of tuning. Since it uses the traditional socket stack through the kernel, CPU usage will be as high (or higher if QDR) than 10GbE.

I would be interested in seeing if rsockets helps ceph. I have questions though.

By default, rsockets still has to copy data in and out. It has extensions for zero-copy, but they do not work with non-blocking sockets. Does ceph use non-blocking sockets?

How many simultaneous connections does it support before falling over into the non-rsockets path?

If rsockets has a ceiling on connections and falls over to the non-socket path, can the application determine if it is safe to use the zero-copy extensions for a specific connection or do they fail gracefully?

Scott