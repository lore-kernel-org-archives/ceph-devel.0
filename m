From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: "VFS: Busy inodes after unmount of ceph" kernel-message after
 umount
Date: Mon, 7 Jun 2010 08:33:09 +0000 (UTC)
Message-ID: <huias5$pf4$1@dough.gmane.org>
References: <hudfmd$kjm$1@dough.gmane.org>
	<Pine.LNX.4.64.1006062109410.14891@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37085 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab0FGIdX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jun 2010 04:33:23 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OLXlm-0006Z0-Ob
	for ceph-devel@vger.kernel.org; Mon, 07 Jun 2010 10:33:18 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jun 2010 10:33:18 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jun 2010 10:33:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Sun, 06 Jun 2010 21:10:28 -0700 schrieb Sage Weil:

> On Sat, 5 Jun 2010, Thomas Mueller wrote:
>> hi
>> 
>> since running an new snapshot test* that creates some(many?) snapshots
>> I get this kernel message on umount:
>> 
>> VFS: Busy inodes after unmount of ceph. Self-destruct in 5 seconds. 
>> Have a nice day...
>> 
>> this is with kernel 2.6.34 and ceph-client-standalone
> 
> This one is new.  Can you say a bit more about what workload induced the
> crash?  Or better yet, are you able to reproduce it?
> 

yes, i get the message every time i run the test and do the umount. the 
system is debian squeeze with 4GB of RAM and 2.6.34 kernel from 
experimental repo. cannot test it on centos5 right now. 


what the script does:
- mkdir snaptest-2; cd snaptest-2
- create 100 dirs with 1 textfile in it
- mkdir .snap/test-1
- create 100 dirs with 1 textfile in it
- for every subdir create a snapshot (mkdir $i/.snap/snaptest) and then 
create 10 textfiles
- mkdir .snap/test-2
- mkdir copysnap1; cp -R .snap/test-1 copysnap1/
- mkdir .snap/test-3
- rm -Rf ./*
- umount

(http://github.com/vinzent/ceph-testsuite/blob/master/tests/snaptest-2)

- Thomas

