From: Sage Weil <sage@newdream.net>
Subject: RBD status update
Date: Mon, 10 Oct 2011 09:40:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110100920460.26361@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab1JJQke (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2011 12:40:34 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E865ABC952
	for <ceph-devel@vger.kernel.org>; Mon, 10 Oct 2011 09:40:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C742ABC952
	for <ceph-devel@vger.kernel.org>; Mon, 10 Oct 2011 09:40:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just a quick update on the current status of RBD.

The main recent development is that librbd (the userspace library) can ack 
writes immediately (instead of waiting for them to actually commit), to 
better mimic the behavior of a normal disk.  

Why do this?  A long long time ago, when you issued a write to a disk, it 
would ACK the write when the data was written.  No more.  Now, the ACK 
means the data is either the drive's cache or on disk.  You don't know 
data is safe/durable until you issue a separate flush command.  Now RBD 
behaves similarly: writes are acked immediately (up to some number of 
bytes, at least), and a flush will wait for all previous writes to commit.  
The only real difference between this and a real drive cache is that a 
real drive will try to coalesce small writes into a single operation, 
while RBD sends them all straight through to the backend cluster.

To make this work with qemu/KVM you need:

 - Ceph v0.35 or later.

 - Set the rbd_writeback_window to the number of bytes (something on the 
   order of what you'd expect a physical disk cache to be.. say, 8 MB).
   This means using a qemu drive string like

	rbd:rbd/myimage:rbd_writeback_window=8000000

 - You need qemu with commit 7a3f5fe, which wires up the qemu flush 
   function properly.

This is not yet implemented in the kernel RBD driver.  As a result, 
effective performance using that device is still relatively poor.  We hope 
to have similar behavior ready when the v3.2 merge window opens.

sage
