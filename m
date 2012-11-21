From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: how to create snapshots
Date: Wed, 21 Nov 2012 15:07:51 +0100
Message-ID: <50ACE037.5010806@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57762 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab2KUOH6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 09:07:58 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i tried to create a snapshot of my disk vm-113-disk-1:

[: ~]# rbd -p kvmpool1 ls
vm-113-disk-1

[: ~]# rbd -p kvmpool1 snap create BACKUP vm-113-disk-1
rbd: extraneous parameter vm-113-disk-1

[: ~]# rbd -p kvmpool1 snap create vm-113-disk-1 BACKUP
rbd: extraneous parameter BACKUP

What's wrong here?

Stefan
