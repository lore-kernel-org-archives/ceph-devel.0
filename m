From: Sage Weil <sweil@redhat.com>
Subject: osd dm-crypt key management, part... deux?
Date: Wed, 27 Jan 2016 09:26:41 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601262106390.6524@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42802 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555AbcA0O03 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Jan 2016 09:26:29 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id B1EC6C1C751F
	for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 14:26:29 +0000 (UTC)
Received: from cpach (ovpn-112-45.phx2.redhat.com [10.3.112.45])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0REQRIr021603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 09:26:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've had several partial starts to address this problem but haven't 
gotten anything over the line.  A quick summary:

1- Currently we store dm-crypt keys in /etc/ceph/dmcrypt-keys/$osd_uuid, 
on the boot disk.  This lets you throw away OSD disk but not boot disks 
and doesn't help you if someone walks away with a whole server.

2- SUSE had a pull request that made ceph-disk push/pull keys over (s)ftp.  
I can't find it now.. did it get closed?

3- We built a generic "config-key" storage service into the monitor that 
lets you restrict access to certain key/value pairs based on your 
(cephx) authentication key, intending that the osd dm-crypt keys be stored 
there.

4- Red Hat had a DEO project that addressed network-bound encryption in 
the works but that project has been shelved in favor of something 
newer/shinier/better.

5- Lars observes that any solution is incomplete if we don't *also* 
encrypt the swap devices.  (I think we don't need to worry about the boot 
disks, though, unless we're paranoid about /var/log/ceph?)

6- Radoslaw and Adam observe that anything using dm-crypt may have higher 
overhead than something implemented in RADOS itself.  But this is vastly 
more complicated and, if we move in this direction, a long way off.

7- In the meantime, we have nothing better than /etc/ceph/dmcrypt-keys 
upstream...


I suggest we do something simple:

1- Update SUSE's ceph-disk changes to make it easy to plug in 
different key management strategies.

2- Implement a simple mon-based strategy upstream.  We've discussed this a 
fair bit in the past, and were getting stuck on the problem of where to 
store the key-fetching-key.  I.e., we want a key on the disk that you use 
to ask the monitor for the LUKS key, which you then provide to LUKS to 
unlock the actual encryption key.  This means that we need a unencrypted 
spot on the device to store it in.  Milan has indicated that putting it in 
a LUKS key slot would be a bad idea and difficult to maintain.  Instead, I 
propose we create a new GPT partition type called OSD_LOCKBOX (or 
similar), with a tiny filesystem and a few files indicating what to do.  
This will make it easy to store the info we need for the mon scheme, and 
to support new key management approaches later (we can put whatever we 
want there as long as it's not too big).

I put some notes here:

	http://pad.ceph.com/p/osd-key-management

Thoughts?
sage

