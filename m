From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Wiping object content on removal
Date: Wed, 18 Nov 2015 17:42:24 +0300
Message-ID: <564C8E50.4070503@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35706 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933185AbbKROm2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 09:42:28 -0500
Received: by lbbsy6 with SMTP id sy6so25550210lbb.2
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 06:42:27 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id h196sm466467lfb.48.2015.11.18.06.42.26
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 06:42:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers.

Does Ceph have an ability to wipe object content during one's removal? 
Surely one can do that manually from the client but I think that's 
ineffective and not 100% secure.

If no - what's about adding such feature to Ceph?
  I can start working on that.

Thanks,
Igor.


