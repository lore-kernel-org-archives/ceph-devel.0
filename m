From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 10:46:09 +0100
Message-ID: <CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53503 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab3AQJqJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 04:46:09 -0500
Received: by mail-ie0-f171.google.com with SMTP id 9so562435iec.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 01:46:09 -0800 (PST)
In-Reply-To: <50F72150.7080002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

2013/1/16 Mark Nelson <mark.nelson@inktank.com>:
> Assuming you have 10GbE, you'll probably be capped by the SSDs for
> large block sequential workloads.  Having said that, I still think this has
> potential to be a nice setup.  Just be aware that we usually don't stick
> that much stuff on the SSDs!

10GbE for which network, OSDs or client network? I think you are
talking about OSD network.

I'm evaluating a small Infiniband 10GB or 20GB network , but I'm still
not sure if should I
make the OSD network in the node by using 2 IB card. What happens when
the OSD network
fails on a single node but that node is still reachable from the client network?

Ceph will remove it from the cluster?

I don't know if I have to use a single two port IB card (switch
redundancy and no card redundancy) or
I have to use two single port cards. (or a single one port IB?)
