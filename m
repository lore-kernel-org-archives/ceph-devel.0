From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Jenkins is having iassues???
Date: Wed, 27 Apr 2016 14:38:19 +0200
Message-ID: <df4addf5-7731-073a-1107-ae756cf06e24@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:44301 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbcD0Miu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Apr 2016 08:38:50 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id D08401534C8
	for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2016 14:38:47 +0200 (CEST)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id A50E515340D
	for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2016 14:38:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

Not sure why this change:
https://github.com/ceph/ceph/pull/8763

Would fail so badly...
https://jenkins.ceph.com/job/ceph-pull-requests/4781/console

Perhaps Jenkins was pulled from underneath it?

--WjW
