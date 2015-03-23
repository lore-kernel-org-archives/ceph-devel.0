From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: More writes on filestore than on journal ?
Date: Mon, 23 Mar 2015 14:21:31 +0100
Message-ID: <1427116891.16770.25.camel@daevel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:58444 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbbCWNVf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 09:21:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com
Cc: ceph-devel@vger.kernel.org

Hi,

I'm still trying to find why there is much more write operations on
filestore since Emperor/Firefly than from Dumpling.

So, I add monitoring of all perf counters values from OSD.

=46rom what I see : =C2=ABfilestore.ops=C2=BB reports an average of 78 =
operations
per seconds. But, block device monitoring reports an average of 113
operations per seconds (+45%).
please thoses 2 graphs :
- https://daevel.fr/img/firefly/osd-70.filestore-ops.png
- https://daevel.fr/img/firefly/osd-70.sda-ops.png

Do you see what can explain this difference ? (this OSD use XFS)

Thanks,
Olivier

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
