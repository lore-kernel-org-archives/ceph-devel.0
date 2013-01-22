From: Mark Nelson <mark.nelson@inktank.com>
Subject: Ceph Bobtail Performance: IO Scheduler Comparison Article
Date: Tue, 22 Jan 2013 10:03:30 -0600
Message-ID: <50FEB852.7030406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:45478 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3AVQDV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 11:03:21 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so11949907iec.13
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 08:03:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Guys,

We've got an article up looking at performance of CFQ, Deadline, and 
NOOP IO schedulers with Ceph on the SAS2208.   I won't claim that these 
results are universally applicable to other controllers and disk setups, 
but they might be interesting if you've been trying to determine what 
scheduler to use with your setup.

http://ceph.com/community/ceph-bobtail-performance-io-scheduler-comparison/

Thanks,
Mark
