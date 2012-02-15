From: Wido den Hollander <wido@widodh.nl>
Subject: logrotate and auto start = no
Date: Wed, 15 Feb 2012 15:26:23 +0100
Message-ID: <4F3BC08F.7090106@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:41827 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab2BOO0Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2012 09:26:25 -0500
Received: from [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37] (unknown [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id BF2343FBE9
	for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2012 15:26:23 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

When "auto start = no" is set for the OSD's, the logs won't get rotated.

I've set this to no so I can easily reboot machines without all OSD's 
starting, I think it's easier with testing or when you replace a broken 
disk.

Anyway, this prevents the logs from being rotated, causing my disks to 
fill up:

/var/log/ceph/*.log {
     rotate 7
     daily
     compress
     sharedscripts
     postrotate
         invoke-rc.d ceph reload >/dev/null || service ceph reload 
 >/dev/null
     endscript
     missingok
}

The init script doesn't touch daemons which have auto start set to no, 
but this also prevents logrotate from doing it's job.

Some suggestions:

1. Don't use the init script for logrotation
2. Modify the init script
3. Add a note in the documentation about this behaviour

I think that logrotation should work regardless the setting of auto start?

What do you think?

Wido
