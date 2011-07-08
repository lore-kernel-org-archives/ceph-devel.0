From: Brian Chrisman <brchrisman@gmail.com>
Subject: exploration hooking RBD into SCST-iSCSI
Date: Fri, 8 Jul 2011 14:42:21 -0700
Message-ID: <CAN4=B2=QkFCzG0iSqpQPzJt=K-Ln4W1Za23HXgtpz=OKG6=kAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62672 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab1GHVmW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2011 17:42:22 -0400
Received: by vws1 with SMTP id 1so1699970vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2011 14:42:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I was able to hook rbd up through SCST's iSCSI driver to export a lun,
through which I was able to discover and perform some I/O via the
open-iscsi drivers.
Looks like it's basically working, but I wanted to check who else
might have been testing this and whether anybody's been integrating
either SCST or the mainline kernel iSCSI target driver with ceph/rbd?
One subject I was hoping to hear more about was how we can manage
persistent reservations in the ceph environment, as vmware/hyperv
applications require it for I/O fencing purposes among others.  It'd
be nice to have a seamless failover with PR in the case where a client
is accessing a lun via a node which fails.
I'll try to formalize what I've done and put a page up on the ceph
wiki regarding integrating at least the SCST side with RBD.

-Brian Chrisman (PS, my prev email was rejected as spam, trying again
with gmail's plain text formatting)
