From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: next branch: logrotate and invoke-rc.d
Date: Tue, 04 Dec 2012 09:07:40 +0100
Message-ID: <50BDAF4C.3090806@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:48972 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab2LDIHp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 03:07:45 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

since a few days can't remember which revision. It seems something in 
logrotate was changed.

I'm getting the following daily cron output:

Subject: Cron <root@cloud1-ceph1> test -x /usr/sbin/anacron || ( cd / && 
run-parts --report /etc/cron.daily )

/etc/cron.daily/logrotate:
/usr/sbin/invoke-rc.d

Greets,
Stefan
