From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Data replication not working
Date: Thu, 28 Apr 2011 14:12:01 +0530
Message-ID: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XJhXQi4Srqy6kl8wB/zN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:54314 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757280Ab1D1Iso (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2011 04:48:44 -0400
Received: from [10.100.106.210] (indica.cc.iitb.ac.in [10.100.106.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id 6502713900
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 14:12:01 +0530 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-XJhXQi4Srqy6kl8wB/zN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

We have been experimenting with ceph since version 0.24 and
found one important issue that is not resolved (or may be
we don't know how to configure properly).

I will talk about 0.27 since that is the latest release:

  We have a one mon, one mds, and two osd setup. The data
  stored goes to both the osds. We introduce a third osd.
  the ceph status shows "osd: 3 up, 3 in" but no data goes
  into the third osd. This remains the case even if we
  power off one of the original osds.

Data reliability thru replication is one of the major goals
of ceph. I am wondering as to what we might be missing to
get this feature going. I am attaching the configuration
file.

Pl help us solve this problem.

Regards.

--ajit

--=-XJhXQi4Srqy6kl8wB/zN
Content-Disposition: attachment; filename="ceph.conf"
Content-Type: text/plain; name="ceph.conf"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[global]
    user = root
    ; where the mdses and osds keep their secret encryption keys
    keyring = /home/ceph/keyring.bin
    pid file = /var/run/ceph/$name.pid

; monitors
[mon]
    ;Directory for monitor files
    
    mon data = /home/ceph/$name
    mon lease wiggle room = 1 
    paxos observer timeout = 1
    debug mon = 5 

[mon.five]
    host = mon-mds
    mon addr = 10.200.120.65:6789

[mds]
    
    keyring = /home/ceph/keyring.$name
    
    debug ms = 1 
    debug mds = 10 
    debug mds balancer = 10
    debug mds log = 10
    debug mds_migrator = 10
    debug monc = 10

[mds.0]
    host = mon-mds

; OSDs
[osd]
    osd data = /export.osd$id
    osd journal = /dev/export/journal
    osd heartbeat grace = 30
    filestore journal writeahead = true
    journaler_allow_split_entries = true

    keyring = /home/ceph/keyring.$name
    
    ;debug osd = 20
    ;debug filestore = 20

[osd.1]
    host = osd1
    btrfs devs=/dev/export/osd1.p1 

[osd.2]
   host = osd2
   btrfs devs = /dev/export/osd2.p1 

[osd.3]
   host = osd3
   btrfs devs = /dev/export/osd3.p1 


--=-XJhXQi4Srqy6kl8wB/zN--

