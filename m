From: Wido den Hollander <wido@42on.com>
Subject: pre_start command not executed with upstart
Date: Tue, 28 Jul 2015 09:55:45 +0200
Message-ID: <55B73581.3040501@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:38583 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbbG1Hzp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 03:55:45 -0400
Received: from [IPv6:2001:980:7936:0:34e4:3aee:a07:138b] (unknown [IPv6:2001:980:7936:0:34e4:3aee:a07:138b])
	by websrv.42on.com (Postfix) with ESMTPSA id B8B2EC0F7D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 09:55:43 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I was trying to inject a pre_start command on a bunch of OSDs under
Ubuntu 14.04, but that didn't work.

I found out that only the sysvinit script execute pre_start commands,
but the upstart nor the systemd scripts do this.

Is this a thing which will disappear or is this just a oversight?

I'm actually using "sleep 30" as a pre-start to prevent all OSDs from
starting at the same time. Big boxes which die under the workload of all
OSDs starting at the same time.

I also try to prevent a lot of OSDMap changes by booting the OSDs slowly
so I tried to fix this with "pre_start".

Wido
