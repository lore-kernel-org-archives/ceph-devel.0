From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Jenkins build pestered by 'no such option:
 --disable-pip-version-check'
Date: Mon, 18 Jul 2016 15:57:47 +0200
Message-ID: <65d919f9-a015-4fe8-b578-b2fc275494de@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17712 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbcGRN6O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jul 2016 09:58:14 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 37DCA1534C6
	for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2016 15:58:01 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Since somewhere last week all my Jenkins test are aborted this.
And I was under the assumption that issue would have been fixed?

--WjW

See:
https://jenkins.ceph.com/job/ceph-pull-requests/9255/console

Running virtualenv with interpreter /usr/bin/python2.7

Usage:
  pip <command> [options]

no such option: --disable-pip-version-check

Usage:
  pip <command> [options]

no such option: --disable-pip-version-check

Usage:
  pip <command> [options]
