From: Peter Niemayer <niemayer@isg.de>
Subject: Using other filesystems than btrfs with Ceph
Date: Fri, 11 Jun 2010 16:23:15 +0200
Message-ID: <hutgsk$oh4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52374 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756376Ab0FKOZH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Jun 2010 10:25:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ON5AN-00024I-UP
	for ceph-devel@vger.kernel.org; Fri, 11 Jun 2010 16:25:03 +0200
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jun 2010 16:25:03 +0200
Received: from niemayer by barriere.frankfurter-softwarefabrik.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jun 2010 16:25:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

the release notes of 0.20 state "btrfs no longer strictly required".

Is there some documentation/discussion on the pro's and con's of using
other filesystems with Ceph?

Also, the documentation in the Wiki does not mention what would need
to be configured differently if another filesystem was to be used -
what would I have to use instead of "btrfs devs = /dev/sdy"?


The reason why I ask is that the application I would like to test-run
on a minimal Ceph-cluster runs much faster when using XFS than btrfs.
Also, XFS is not quite as young&experimental as btrfs, so if there is
no specific benefit from using btrfs, it would be a reasonable choice
to use the much longer matured XFS for now.

Any thoughts on this?

Regards,

Peter Niemayer


