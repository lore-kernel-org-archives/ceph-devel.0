From: Joseph Glanville <joseph.glanville@orionvm.com.au>
Subject: Re: flashcache
Date: Fri, 18 Jan 2013 00:32:06 +1100
Message-ID: <CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44198 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab3AQNcI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 08:32:08 -0500
Received: by mail-ie0-f171.google.com with SMTP id 9so883080iec.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 05:32:07 -0800 (PST)
In-Reply-To: <CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 17 January 2013 20:46, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/16 Mark Nelson <mark.nelson@inktank.com>:

> I don't know if I have to use a single two port IB card (switch
> redundancy and no card redundancy) or
> I have to use two single port cards. (or a single one port IB?)

On the topic of IB..

But slightly off-topic all the same..  I would love to attempt getting
Ceph running on rsockets if I could find the time (alas we don't run
Ceph).
rsockets is a fully userland implementation of BSD sockets over RDMA,
supporting fork and all the usual goodies, in theory unless you are
using the kernel RBD module (of the kernel FS module etc) you should
be able to run it on rsockets and enjoy a considerable performance
increase.

rsockets is available in the librdmacm git up on Open Fabrics and dev
+ support happens on the linux-rdma list.

-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
