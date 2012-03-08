From: Damien Churchill <damoxc@gmail.com>
Subject: Monitor Logs
Date: Thu, 8 Mar 2012 17:29:53 +0000
Message-ID: <CAFtEh-cpGwU2Uhm4aMRp-OHpPMB1fRAj-Xyq--Pk_PofPL_EFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53681 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab2CHR3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 12:29:54 -0500
Received: by ghrr11 with SMTP id r11so375729ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Mar 2012 09:29:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Is it safe to delete the logs in the monitor data directory? I've just
noticed they haven't been trimmed in months and have grown into the
gigabytes :)

Thanks
