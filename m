From: Wido den Hollander <wido@42on.com>
Subject: libvirt: Removing RBD volumes with snapshots, auto purge or not?
Date: Tue, 20 Aug 2013 17:36:15 +0200
Message-ID: <52138CEF.8010109@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:56247 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab3HTPgS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Aug 2013 11:36:18 -0400
Received: from [IPv6:2001:980:7936:0:bda9:9b05:bc36:8dd7] (unknown [IPv6:2001:980:7936:0:bda9:9b05:bc36:8dd7])
	by websrv.42on.com (Postfix) with ESMTPSA id 464CBBF476
	for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 17:36:15 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

The current [0] libvirt storage pool code simply calls "rbd_remove" 
without anything else.

As far as I know rbd_remove will fail if the image still has snapshots, 
you have to remove those snapshots first before you can remove the image.

The problem is that libvirt's storage pools do not support listing 
snapshots, so we can't integrate that.

Libvirt however has a flag you can pass down to tell you want the device 
to be zeroed.

The normal procedure is that the device is filled with zeros before 
actually removing it.

I was thinking about "abusing" this flag to use it as a snap purge for RBD.

So a regular volume removal will call only rbd_remove, but when the flag 
VIR_STORAGE_VOL_DELETE_ZEROED is passed it will purge all snapshots 
prior to calling rbd_remove.

Another way would be to always purge snapshots, but I'm afraid that 
could make somebody very unhappy at some point.

Currently "virsh" doesn't support flags, but that could be fixed in a 
different patch.

Does my idea sound sane?

[0]: 
http://libvirt.org/git/?p=libvirt.git;a=blob;f=src/storage/storage_backend_rbd.c;h=e3340f63f412c22d025f615beb7cfed25f00107b;hb=master#l407

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
