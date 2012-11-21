From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: RBD Backup
Date: Wed, 21 Nov 2012 14:37:58 +0100
Message-ID: <50ACD936.8060907@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49084 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab2KUNiH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 08:38:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

is there a recommanded way to backup rbd images / disks?

Or is it just
rbd snap create BACKUP
rbd export BACKUP
rbd snap rm BACKUP

Is the snap needed at all? Or is an export save? Is there a way to make 
sure the image is consistent?

Is it possible to use the BACKUP file as a loop device or something else 
so that i'm able to mount the partitions from the backup file?

Thanks!

Greets Stefan
