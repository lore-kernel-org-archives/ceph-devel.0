From: Thomas Mueller <thomas@chaschperli.ch>
Subject: "clocks not synchronized" warning message
Date: Thu, 8 Jul 2010 12:54:26 +0000 (UTC)
Message-ID: <i14hq2$hn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57771 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189Ab0GHMyi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 08:54:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWqcd-0008GJ-Cl
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 14:54:35 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 14:54:35 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 14:54:35 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

running ceph -w I see many of those warnings flying by:

10.07.08_14:36:49.897108   log 10.07.08_14:36:48.530057 mon1 192.168.1.52:6789/0 340 : [WRN] lease_expire from mon0 was sent from future time 10.07.08_14:36:48.886876, clocks not synchronized
10.07.08_14:36:49.897108   log 10.07.08_14:36:48.530076 mon1 192.168.1.52:6789/0 341 : [WRN] 

i've stopped ceph, ran ntpdate on every node, started ceph 
- the message is still there. 

date from the nodes:
# for i in node001 node002 node003 node004; do ssh root@$i date; done
Thu Jul  8 14:52:20 CEST 2010
Thu Jul  8 14:52:20 CEST 2010
Thu Jul  8 14:52:20 CEST 2010
Thu Jul  8 14:52:21 CEST 2010


this is on ceph.git/unstable from today.

- Thomas



ceph.conf:


[global]
	; enable secure authentication
	; auth supported = cephx

[mon]
	mon data = /ceph/mon$id

	; some minimal logging (just message traffic) to aid debugging
	;debug ms = 1

[mon0]
	host = node001
	mon addr = 192.168.1.51:6789

[mon1]
        host = node002
        mon addr = 192.168.1.52:6789

[mon2]
        host = node003
        mon addr = 192.168.1.53:6789

[mds]
	; where the mds keeps it's secret encryption keys
	keyring = /ceph/keyring.$name

[mds.node001]
	host = node001

[mds.node002]
	host = node002

[mds.node003]
        host = node003

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
	; This is where the btrfs volume will be mounted.
	osd data = /ceph/osd$id

	; Ideally, make this a separate disk or partition.  A few GB
 	; is usually enough; more if you have fast disks.  You can use
 	; a file under the osd data dir if need be
 	; (e.g. /ceph/osd$id/journal), but it will be slower than a
 	; separate disk or partition.
	osd journal = /ceph/osd$id/journal
	osd journal size = 100

[osd0]
	host = node001

	; if 'btrfs devs' is not specified, you're responsible for
	; setting up the 'osd data' dir.  if it is not btrfs, things
	; will behave up until you try to recover from a crash (which
	; usually fine for basic testing).
	;btrfs devs = /dev/sdx

[osd1]
	host = node002
	;btrfs devs = /dev/sdy

[osd2]
	host = node003
	;btrfs devs = /dev/sdx

[osd3]
	host = node004
	;btrfs devs = /dev/sdy

