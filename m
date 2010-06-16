From: Phil Carns <carns@mcs.anl.gov>
Subject: block device journal durability
Date: Wed, 16 Jun 2010 10:46:28 -0400
Message-ID: <4C18E3C4.5030303@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailhost.anl.gov ([130.202.113.50]:58707 "EHLO mailhost.anl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759047Ab0FPOqb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jun 2010 10:46:31 -0400
Received: from mailhost.anl.gov (mailhost.anl.gov [130.202.113.50])
	by localhost.anl.gov (Postfix) with ESMTP id D634246
	for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 09:46:30 -0500 (CDT)
Received: from zimbra.anl.gov (zimbra.anl.gov [130.202.101.12])
	by mailhost.anl.gov (Postfix) with ESMTP id CE2F543
	for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 09:46:30 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.anl.gov (Postfix) with ESMTP id 3F8AA19E016E
	for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 09:46:30 -0500 (CDT)
Received: from zimbra.anl.gov ([127.0.0.1])
	by localhost (zimbra.anl.gov [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEXGggsAt1iy for <ceph-devel@vger.kernel.org>;
	Wed, 16 Jun 2010 09:46:30 -0500 (CDT)
Received: from [192.168.0.104] (adsl-66-176-61.asm.bellsouth.net [98.66.176.61])
	by zimbra.anl.gov (Postfix) with ESMTP id 8E6C919E016C
	for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 09:46:29 -0500 (CDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I noticed that Ceph issues a warning if it detects that you are using a 
raw block device as the journal and write caching is enabled on that 
device.

When it opens the block device file, however, the FileJournal is using 
O_DIRECT|O_SYNC.  In recent kernels, syncing a block device file 
actually triggers a proper write barrier operation
(http://lxr.linux.no/linux+v2.6.34/fs/block_dev.c#L420).  The barrier 
operation is also supported on MD and LVM now as well if you happen to 
have a journal on a multi-disk volume.

Does this mean that if you have a new enough kernel, and a block device 
that understands barriers, that you can safely leave the write cache 
enabled for the journal device?  It seems that way to me, but I wanted 
to make sure that I am not missing a more subtle issue related to how 
Ceph performs its journaling.

Kudos on the user-friendly warning messages in Ceph in general, by the way.

thanks,
-Phil

