From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: timed out in osd1 error in dmes
Date: Thu, 15 Mar 2012 17:02:28 +0000 (UTC)
Message-ID: <loom.20120315T175920-67@post.gmane.org>
References: <loom.20120313T083325-276@post.gmane.org> <4F5FACD8.8090902@dreamhost.com> <loom.20120314T051739-894@post.gmane.org> <Pine.LNX.4.64.1203141057030.11925@cobra.newdream.net> <loom.20120315T084452-832@post.gmane.org> <Pine.LNX.4.64.1203150846180.21671@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34334 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031939Ab2CORCm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Mar 2012 13:02:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S8E4U-0005XQ-Al
	for ceph-devel@vger.kernel.org; Thu, 15 Mar 2012 18:02:38 +0100
Received: from Static-43.236.99.14.tataidc.co.in ([Static-43.236.99.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 18:02:38 +0100
Received: from madhusudhana.u.acharya by Static-43.236.99.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 18:02:38 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> 
> Can you share your ceph.conf please?
> 
> > > Another useful piece of information would be the ceph-osd's raw 
> > > performance writing to the local disk+journal, which you can get with
> > > 
> > >  $ ceph tell osd.0 bench
> > > 
> > > You might want to check it for several nodes to see if it's consistent, 
> > > etc.
> > > 
> > Below are the results from above command run against all osd's
> > 
> > 
> > 2012-03-15 13:06:19.980924 osd.0 -> 'bench: wrote 1024 MB in blocks of 
> > 4096 KB in 67.474949 sec at 15540 KB/sec' (0)
> > 2012-03-15 13:09:20.573176 osd.1 -> 'bench: wrote 1024 MB in blocks of 
> > 4096 KB in 70.815932 sec at 14807 KB/sec' (0)
> > 2012-03-15 13:11:57.895738 osd.2 -> 'bench: wrote 1024 MB in blocks of 
> > 4096 KB in 60.370233 sec at 17369 KB/sec' (0)
> 
> This is pretty slow, and probably due to the way your osd journals are 
> configured.  Please share your ceph.conf!
> 

Below is my ceph conf file

[root@ceph-node-8 ~]# cat /etc/ceph/ceph.conf
[global]
        ;auth supported = cephx
        keyring = /etc/ceph/admin.keyring
        debug ms = 1
        debug mds = 10

[mon]
        mon data = /data/mon.$id

[mon.a]
        host = ceph-node-4
        mon addr = xx.xx.xx.xx

[mon.b]
        host = ceph-node-5
        mon addr = xx.xx.xx.xx

[mon.c]
        host = ceph-node-6
        mon addr = xx.xx.xx.xx
[mds]
        keyring = /etc/ceph/keyring.$name

[mds.ceph-node-1]
        host = ceph-node-7

[mds.ceph-node-2]
        host = ceph-node-8

[osd]
        osd data = /data/osd.$id
        keyring = /etc/ceph/keyring.$name
        osd journal = /journal/osd.$id.journal
        osd journal size = 10000
        debug ms = 1
        debug osd = 20
        debug filestore = 20
        debug journal = 20



[osd.0]
        host = ceph-node-1
        btrfs devs = /dev/sda4

[osd.1]
        host = ceph-node-2
        btrfs devs = /dev/sda4

[osd.2]
        host = ceph-node-3
        btrfs devs = /dev/sda4

To brief, i have different partitions for mounting journal and osd. 

/journal is used for mounting journal 
/data is used for mounting osd


