From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Has rgw recently switched to deque usuage??
Date: Sat, 20 Feb 2016 15:41:45 +0100
Message-ID: <56C87B29.5040005@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43322 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbcBTOl6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 20 Feb 2016 09:41:58 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 650E51534E3
	for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 15:41:55 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 4A2B2153413
	for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 15:41:46 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

With the last rebase I'm getting compilation errors on rgw stuff.
So I was wondering if deque usuage got included recently, or that I'm
running into a case where Clang doesn't like the way some code is used.
And GCC just compiles fine...

Any answer would be appriciated

--WjW
