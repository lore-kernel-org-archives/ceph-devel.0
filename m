From: Dietmar Maurer <dietmar@proxmox.com>
Subject: possible bug in init-ceph.in
Date: Thu, 21 Nov 2013 07:23:34 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F7559232FA2@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.maurer-it.com ([94.136.31.133]:56354 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab3KUH3y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Nov 2013 02:29:54 -0500
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id BCD21271E823
	for <ceph-devel@vger.kernel.org>; Thu, 21 Nov 2013 08:23:38 +0100 (CET)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

http://ceph.com/git/?p=ceph.git;a=blob;f=src/init-ceph.in;h=7399abb8f85855f2248c4afb22bf94f2e2f080a2;hb=HEAD

line 320:

      if [ "${update_crush:-1}" = "1" -o "{$update_crush:-1}" = "true" ]; then

looks strange to me. Maybe that should be:

-		if [ "${update_crush:-1}" = "1" -o "{$update_crush:-1}" = "true" ]; then
+		if [ "${update_crush:-1}" = "1" -o "${update_crush:-1}" = "true" ]; then



