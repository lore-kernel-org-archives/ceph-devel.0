From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Metadata vs UserData caching in BlueStore
Date: Thu, 15 Dec 2016 20:24:48 +0300
Message-ID: <ce95a133-7fae-34fc-b493-fbabdc272c55@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34852 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757106AbcLORY5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 12:24:57 -0500
Received: by mail-yw0-f180.google.com with SMTP id i145so17636432ywg.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 09:24:51 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id u67sm844924ywa.37.2016.12.15.09.24.50
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 09:24:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Sage et al,

shouldn't we have bluestore_cache_metadata_ratio set to 1 by default? To 
concentrate on metadata caching..

IMHO Onode caching is much more important and profitable than user data 
one. It's rather a client misbehavior to cause cache hit when accessing 
user data but it's  highly expected for onode metadata.

Moreover user data caching is probably already exists at block device 
level hence we rather duplicate disk cache....

What do you think?

Thanks,

Igor

