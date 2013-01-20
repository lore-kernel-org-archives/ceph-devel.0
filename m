From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 13:51:20 -0500
Message-ID: <50FC3CA8.4070608@gmail.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net> <50FC2682.3020601@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:38090 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3ATS7j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 13:59:39 -0500
Received: by mail-yh0-f46.google.com with SMTP id 25so47790yhr.19
        for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 10:59:38 -0800 (PST)
In-Reply-To: <50FC2682.3020601@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

Wido den Hollander wrote:
> No, not really. 1Gbit should be more then enough for your monitors. 3
> monitors should also be good. No need to go for 5 or 7.

I have 5 monitors, across 16 different OSD-hosting machines...is that 
going to *harm* anything?

(I have had issues in my cluster when doing upgrades where my monitor 
count fell to 3, so it felt like having the extra was nice, at that point.)

Thanks,
Jeff
