From: Geoffrey Hartz <hartz.geoffrey@gmail.com>
Subject: OSDs don't actually delete files when two CephFS (or more) are in use
Date: Mon, 10 Dec 2012 19:29:44 +0100
Message-ID: <CAPU8t+pEuX2sP-gRqmCxGw-etrviOt1N7_18gv4=rDj+K6pkTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64633 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab2LJS3p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 13:29:45 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2728458oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 10:29:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I'm new to Ceph and I have a strange behavior with CephFS

Config is :

Ubuntu 12.04
Kernel 3.6.9
Ceph V0.55

2 OSD, 1 mon, 1 MDS, all on same host
2 clients, separate Hosts

Ceph.conf:

http://paste.ubuntu.com/1423712/

To mount the share I use : sudo ceph-fuse -m 192.168.80.139:6789 /mnt

When I create a file on one client, the other see the file, can be
downloaded etc.

But when I delete the file, both clients don't see the file anymore
BUT the file is still there on OSD (using space disk).

When I umount from BOTH clients, OSD are update and file is actually
delete (same behavior with mount -t ceph)

I'm missing something?

Thanks!

--
Geoffrey HARTZ
