From: Thomas Mueller <thomas@chaschperli.ch>
Subject: cmds segfault on pdj-fstest (ceph.git unstable)
Date: Wed, 9 Jun 2010 06:48:58 +0000 (UTC)
Message-ID: <hundgq$ums$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:42029 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab0FIGtM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Jun 2010 02:49:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OMF64-0005LU-RV
	for ceph-devel@vger.kernel.org; Wed, 09 Jun 2010 08:49:08 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jun 2010 08:49:08 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jun 2010 08:49:08 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi 

since this morning cmds segfaults on the pdj-fstest. 
(git rev 12798de37169f6561f0dc7643ca626957f7ab37e)

What happend:
<start server with vstart.sh>
<mount>
08:39:08 [  176.460708] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 5/5 5/5)
08:39:08 [  176.463965] ceph: client4101 fsid a7b6294d-a074-8e0e-2cee-a48fe2f85c86
08:39:08 [  176.464240] ceph: mon1 127.0.0.1:6789 session established
<start pdj-fstest>
08:40:51 [  279.406980] cmds[6675]: segfault at 0 ip 00000000004bddbd sp 00007f6861ba34e0 error 4 in cmds[400000+331000]
08:40:51 [  279.409895] ceph: mds0 127.0.0.1:6802 socket closed
08:40:51 [  279.804386] ceph: mds0 127.0.0.1:6802 connection failed
08:40:52 [  280.804383] ceph: mds0 127.0.0.1:6802 connection failed
08:40:54 [  282.804381] ceph: mds0 127.0.0.1:6802 connection failed
08:40:58 [  286.804387] ceph: mds0 127.0.0.1:6802 connection failed
08:41:06 [  294.804793] ceph: mds0 127.0.0.1:6802 connection failed
<killed pdj-fstest>
08:41:22 [  310.804820] ceph: mds0 127.0.0.1:6802 connection failed
08:41:38 [  326.804288] ceph: mds0 caps stale
08:41:53 [  341.804327] ceph: mds0 caps stale
08:41:54 [  342.804245] ceph: mds0 127.0.0.1:6802 connection failed


the segfault is reproducable on my machine. yesterday 
(git rev  58fe4b8d5441982d0103817666a6d1bfdd8e04cd) this error was not present.


- Thomas

