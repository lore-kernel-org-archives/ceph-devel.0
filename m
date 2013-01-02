From: Wido den Hollander <wido@widodh.nl>
Subject: EU mirror issues
Date: Wed, 02 Jan 2013 15:01:57 +0100
Message-ID: <50E43DD5.7070602@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:53999 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3ABOCA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 09:02:00 -0500
Received: from [IPv6:2a00:f10:113:0:6443:a162:2aa1:7d9d] (unknown [IPv6:2a00:f10:113:0:6443:a162:2aa1:7d9d])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 818AE4341D
	for <ceph-devel@vger.kernel.org>; Wed,  2 Jan 2013 15:01:58 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I just noticed that the sync process for eu.ceph.com didn't work properly.

The problem seems to be a faulty rsync script on my side which caused 
the "debian" directory not to be synced properly.

I corrected the issue, but it has to re-sync again now, that will take 
some time.

The mirror should be working properly again within a few hours.

Wido
