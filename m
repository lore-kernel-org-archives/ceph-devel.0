From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 15:52:35 +0100
Message-ID: <50CB3D33.7070800@conversis.de>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:47682 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2LNOwi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 09:52:38 -0500
In-Reply-To: <50CAEDE5.9070509@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/14/2012 10:14 AM, Stefan Priebe wrote:
> One more IMPORTANT note. This might happen due to the fact that a disk was
> missing (disk failure) afte the reboot.
> 
> fstab and mountpoint are working with UUIDs so they match but the journal
> block device:
> osd journal  = /dev/sde1
> 
> didn't match anymore - as the numbers got renumber due to the failed disk.
> Is there a way to use some kind of UUIDs here too for journal?

You should be able to use /dev/disk/by-uuid/* instead. That should give you
a stable view of the filesystems.

Regards,
  Dennis

