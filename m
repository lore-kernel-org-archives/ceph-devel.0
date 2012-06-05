From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: mount: 10.0.6.10:/: can't read superblock
Date: Tue, 05 Jun 2012 14:33:19 -0400 (EDT)
Message-ID: <c99406dc-0969-47de-a75a-72a8f42eae52@mail.linserv.se>
References: <4FCE4C98.8020101@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:43309 "EHLO
	mail.linserv.se" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab2FESdn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 14:33:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 06A8AE7F2
	for <ceph-devel@vger.kernel.org>; Tue,  5 Jun 2012 14:33:20 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DAoFVJHwaBc5 for <ceph-devel@vger.kernel.org>;
	Tue,  5 Jun 2012 14:33:19 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 309E6E7EE
	for <ceph-devel@vger.kernel.org>; Tue,  5 Jun 2012 14:33:19 -0400 (EDT)
In-Reply-To: <4FCE4C98.8020101@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello

> Hi Martin, 
>
> On 06/05/2012 08:07 PM, Martin Wilderoth wrote: 
> > Hello 
> >
> > Is there a way to recover this error. 
> >
> > mount -t ceph 10.0.6.10:/ /mnt -vv -o name=admin,secret=XXXXXXXXXXXXXXXXXXXXXXX 
> > [ 506.640433] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6) 
> > [ 506.650594] ceph: loaded (mds proto 32) 
> > [ 506.652353] libceph: client0 fsid a9d5f9e1-4bb9-4fab-b79b-ba4457631b01 
> > [ 506.670876] Intel AES-NI instructions are not detected. 
> > [ 506.678861] libceph: mon0 10.0.6.10:6789 session established 
> > mount: 10.0.6.10:/: can't read superblock 
> >
>
> Could you share some more information? For example the output from: ceph -s 

2012-06-05 20:25:05.307914    pg v1189604: 1152 pgs: 1152 active+clean; 191 GB data, 393 GB used, 973 GB / 1379 GB avail
2012-06-05 20:25:05.315871   mds e60: 1/1/1 up {0=c=up:replay}, 2 up:standby
2012-06-05 20:25:05.315965   osd e1106: 8 osds: 8 up, 8 in
2012-06-05 20:25:05.316165   log 2012-06-05 20:24:50.425527 mon.0 10.0.6.10:6789/0 75 : [INF] mds.? 10.0.6.11:6800/22974 up:boot
2012-06-05 20:25:05.316371   mon e1: 3 mons at {a=10.0.6.10:6789/0,b=10.0.6.11:6789/0,c=10.0.6.12:6789/0}


>
> Did you change anything to the cluster since it worked? And what version 
> are you running? 

I have not done any changes installed at version 0.46 upgraded earlier and have been testing with
ceph and ceph-fuse and backuppc. It was during the ceph-fuse it hanged.

Current version
ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)

> > One of my mds logs has 24G of data. 
>
> Is it still running? 
I have restarted mds.a and mds.b they seems to be running. But not everything.
mds.a was stoped not sure mds.b but it has a big logfile.

>
> > 
> > I have some rbd devices that I would like to keep. 
>
> RBD doesn't use the MDS nor the POSIX filesystem, so you will probably 
> be fine, but we need the output of "ceph -s" first. 
>
> Does this work? 
> $ rbd ls
this works I'm still using the rbd with no problem 
> $ rados -p rbd ls 
seems to work reports something simmilar to
rb.0.2.00000000052e
rb.0.0.0000000002f2
rb.0.7.000000000345
rb.0.7.000000000896
rb.0.0.000000000102
rb.0.9.000000000172
rb.0.1.000000000350
rb.0.4.000000000180
rb.0.4.00000000068b
rb.0.5.00000000054c
rb.0.2.0000000001e1
 
> Wido 
>
> > 
> > /Regards Martin 
> > 
