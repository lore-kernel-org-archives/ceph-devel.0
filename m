From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Bumping my jenkins builds to the wall in radable.sh
Date: Wed, 16 Mar 2016 19:27:17 +0100
Message-ID: <56E9A585.9000309@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:20171 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618AbcCPS1b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Mar 2016 14:27:31 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 7000D153416
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 19:27:28 +0100 (CET)
Received: from [192.168.101.107] (vpn.ecoracks.nl [31.223.170.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 37B1C1534C8
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 19:27:18 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketEnt

../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo
error: buffer::end_of_buffer
**** failed to decode
../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/25f5ff183bba6da708243a0bbbe40a2e
****
error: buffer::end_of_buffer
**** failed to decode
../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/54f53e3e301071f48247d59272b27b53
****

../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/rgw_bucket_pending_info

"Just" a matter of rebase?
Or does it need more tinkering.

--WjW
