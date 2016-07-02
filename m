From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Cleaning up after in the cmake env?
Date: Sat, 2 Jul 2016 14:22:52 +0200
Message-ID: <1c338fe3-37a7-62f9-439b-dcfbfc873d90@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:48505 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbcGBMan (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 2 Jul 2016 08:30:43 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id B310E153413
	for <ceph-devel@vger.kernel.org>; Sat,  2 Jul 2016 14:22:53 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

How do I cleanup after I've ran a test build?
Other than thrashing the the full tree and start all over again.

--WjW

