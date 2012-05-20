From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: qemu-rdb questions
Date: Sun, 20 May 2012 06:33:43 +0200 (CEST)
Message-ID: <f5e64790-567a-4ad4-8b3d-01f6f6604dd7@mailpro>
References: <4FB738F3.1060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33642 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2ETEeE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 00:34:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id B251518024BE4
	for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 06:33:48 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1thYr4YXZXS7 for <ceph-devel@vger.kernel.org>;
	Sun, 20 May 2012 06:33:43 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 4530618026250
	for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 06:33:43 +0200 (CEST)
In-Reply-To: <4FB738F3.1060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
i'm planning to do rdb integration in proxmox2 kvm distribution (not using libvirt).

I found some doc here
http://ceph.com/wiki/QEMU-RBD
and also in libvirt mailing list.


some questions:

qemu drive command line :
-------------------------
-drive file=rbd:pool/image:id=myname:key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:auth_supported=cephx none:mon_host=mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,if=virtio,format=raw 

is it the right syntax ?



for image management, what is the best way ? qemu-img or rdb ?

rdb creation with qemu-img:
----------------------------
qemu-img create -f rbd rbd:data/foo 10G

how to specify monitor, authentification,.... ?

rdb delete/resize with qemu-img?
--------------------------------
don't find any infos.


rdb commands
------------
Is the rdb kernel module require to use rdb command ?

Also,I would like to not have any /dev/rdbx device on my client.

Regards,

-Alexandre
