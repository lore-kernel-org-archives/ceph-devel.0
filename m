From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: set different target_max_bytes for each pg in cache pool
Date: Thu, 23 Apr 2015 11:35:25 +0800
Message-ID: <CANE=7sWPNFW+SVkbwkigL3OTZW-nS-1717OWAURrFRVo-muw_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34419 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbDWDf0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Apr 2015 23:35:26 -0400
Received: by obfe9 with SMTP id e9so4454185obf.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2015 20:35:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

    In my production environment, each pg is the same pool has
different io pressure. The max is 3-

4 times more than min.  Currently, max size of each pg is
pool.info.target_max_bytes / pg_num.

So I think, we could do better. Such as, set different pg
target_max_bytes according to their io

pressure.


    Is that make sense?

-- 
Regards,
xinze
