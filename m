From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: objecter incremental osdmap crc check
Date: Wed, 3 Feb 2016 21:54:07 +0800
Message-ID: <CANE=7sVATveDWRxv_X=jprzcJW50ssu0zojQgHLOUDP5aGF5Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33482 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbcBCNyI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 08:54:08 -0500
Received: by mail-ob0-f181.google.com with SMTP id is5so30144833obc.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 05:54:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

      When osd update the osdmap, it would apply the
OSDMap::Incremental and get the crc for the new osdmap. If the crc is
not the same as define in Incremental osd would request the full
osdmap. I think the logic is quite well.

     But in the client, the objecter do not check the crc. I do not
know why not client do the same logic as osd.

    Could anyone explain this? Thanks.

-- 
Regards,
Xinze Chi
