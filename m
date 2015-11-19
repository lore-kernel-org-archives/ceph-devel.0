From: Mike Almateia <mike.almateia@gmail.com>
Subject: All-Flash Ceph cluster and journal
Date: Thu, 19 Nov 2015 14:29:37 +0300
Message-ID: <564DB2A1.9080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35992 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087AbbKSL3m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 06:29:42 -0500
Received: by lbblt2 with SMTP id lt2so41801334lbb.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 03:29:40 -0800 (PST)
Received: from [127.0.0.1] ([212.34.43.122])
        by smtp.gmail.com with ESMTPSA id l128sm1142180lfe.27.2015.11.19.03.29.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 03:29:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello.

By now we have SSD disks with a great perfomance under O_DIRECT/O_SYNC 
flags (and we recomended to use they for journal).

Why in a All-Flash type Ceph clusters we still use journal and them put 
a data into OSD?
Why we can't just write a data into OSD with O_DIRECT/O_SYNC flags, 
without journal?

Can we just switch off the journal functional for all-flash ceph clusters?

-- 
Mike, runs.
