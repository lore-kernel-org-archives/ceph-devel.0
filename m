From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Compile error in Jenkins in rgw/rgw_data_sync.cc
Date: Wed, 11 May 2016 00:24:03 +0200
Message-ID: <3ab4655e-235d-1d8c-6072-cc796cb51746@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:11492 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbcEJWYc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 May 2016 18:24:32 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id E5DB5153430
	for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 00:24:28 +0200 (CEST)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id A4A9115340D
	for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 00:24:02 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


  CXX      rgw/librgw_la-rgw_replica_log.lo
rgw/rgw_data_sync.cc: In member function 'void
RGWDataSyncStatusManager::finalize()':
rgw/rgw_data_sync.cc:1383:3: error: 'sync_env' was not declared in this
scope
   sync_env = RGWDataSyncEnv{};
   ^

But I'm not sure which sync_env in what class needs exposure.

--WjW
