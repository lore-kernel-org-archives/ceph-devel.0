From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: mount: 10.0.6.10:/: can't read superblock
Date: Fri, 08 Jun 2012 15:44:48 -0400 (EDT)
Message-ID: <c4db6453-e419-4366-8f7b-924912f31b15@mail.linserv.se>
References: <CADvuQREEAKq3AJHe3=1y59VJS36FFVY3dXPcvOLFaYecmjb9xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:40545 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab2FHTpD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 15:45:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id A5D9ADA033
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 15:44:49 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MomcBPYtDket for <ceph-devel@vger.kernel.org>;
	Fri,  8 Jun 2012 15:44:48 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 9BD7BDA031
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 15:44:48 -0400 (EDT)
In-Reply-To: <CADvuQREEAKq3AJHe3=1y59VJS36FFVY3dXPcvOLFaYecmjb9xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello

> On Tue, Jun 5, 2012 at 9:37 PM, Martin Wilderoth 
> <martin.wilderoth@linserv.se> wrote: 
> > 0> 2012-06-06 05:38:37.200297 7f2d5ea08700 -1 mds/AnchorServer.cc: In function 'virtual void >AnchorServer::handle_query(MMDSTableRequest*)' thread 7f2d5ea08700 time 2012-06-06 05:38:37.198981 
> > mds/AnchorServer.cc: 249: FAILED assert(anchor_map.count(curino) == 1) 
> > 
> > ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1) 
> > 1: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6bdc95] 
> > 2: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b0474] 
> > 3: (MDS::_dispatch(Message*)+0xaf8) [0x4c50b8] 
... 
> > root@ceph1:~# ceph -v 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > root@ceph1:~# ssh ceph2 ceph -v 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > root@ceph1:~# ssh ceph3 ceph -v 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > root@ceph1:~# ssh ceph4 ceph -v 
> > ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372) 
> > 
> > is the 0.46 above reporting when the error occurred or am I running the wrong binaries 
> > i use the debian packages ? 
> 
> That sounds weird. The ways I can see that being possible are 
> 
> 1. you had daemons still running from when you had 0.46 debs 
> installed, and the package upgrade didn't restart them -- ceph.git 
> uses "dh_installinit --no-start", so this might actually have 
> happened? 

When upgrading from different versions I just run apt-get upgrade in a running cluster.
I just stop ods,mds and mon on the host and then upgrade.

Maybe this is very bad ? 

After the update I restart the server and take the next one.
But it means that I'm running nodes with different version.

In the last update I got HEALTH problems during the upgrade but when they were all upgraded
it looked ok.

The reason for doing like this is that if during the upgrade the upgrade host fails it's better
to have the other tree running to be able to recover.

But maybe this uppgrading process could create crashes :-(.

Maybe better to stop the cluster and restart when upgraded. 
But then the ceph.conf file has to be removed before restarting the host and copied back
before starting it again.

> 
> 2. at some point, you checked out the 0.46 source and ran make 
> install, and the binaries from that are installed at a path that takes 
> precedence over the 0.47.2 ones in /usr/sbin 
> 
> But having mixed versions in your cluster might explain the crashes. 

It was one package that was kept back during the upgrade. So I was runnig the wrong binary
on the mds maybe more ???. The package name was ceph, not sure what binaries that were missing.
but ceph -v reported 0.47.2. But doing apt-get install ceph installed the missing binary and
one other package.

 /Best Regards Martin
