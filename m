From: Adrian Saul <Adrian.Saul@tpgtelecom.com.au>
Subject: RE: ceph-disk improvements
Date: Mon, 4 Apr 2016 00:41:33 +0000
Message-ID: <27b2185a6b214028968c368bf235ec55@TPG-TC3-EXCH04.tpg.local>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.trustedcloud.com.au ([203.221.44.60]:47587 "EHLO
	tc1mx1.trustedcloud.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752919AbcDDAxo convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 3 Apr 2016 20:53:44 -0400
In-Reply-To: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Another consideration is that right now we don't play nice with LVM at all.
> Should we?  dm-cache is usually used in conjunction with LVM (although it
> doesn't have to be).  Does LVM provide value?  Like, the ability for users to
> add a second SSD to a box and migrate cache, wal, or journal partitions
> around?

Perhaps being able to designate a VG to create a configured/specified sized LV from to create these needed devices, rather than having to manually partition up a disk or use an additional filesystem layer to simplify journal etc creation.   If ceph-disk has the OSD ID at the creation time then it can apply that to the LV naming to give better transparency as to what it is used for.    You can sort of do this now wrapping ceph-disk in a script but its not obvious what the OSD-ID will be so in my case I use the physical disk name, which is not always consistent (disks swaps changing disk name on reboot etc).   Having ceph-disk integrate this would tie them together more cleanly.

Benefits could be that you can do online migrations to a  new disk by adding it to the VG and using pvmove, or support online resizing of these volumes with lvextend (ceph-disk grow-journal?) if the sizing has room to be adjusted later.

>
> I'm interested in hearing feedback on requirements, approaches, and
> interfaces before we go too far down the road...
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
Confidentiality: This email and any attachments are confidential and may be subject to copyright, legal or some other professional privilege. They are intended solely for the attention and use of the named addressee(s). They may only be copied, distributed or disclosed with the consent of the copyright owner. If you have received this email by mistake or by breach of the confidentiality clause, please notify the sender immediately by return email and delete or destroy all copies of the email. Any confidentiality, privilege or copyright is not waived or lost because this email has been sent to you by mistake.
