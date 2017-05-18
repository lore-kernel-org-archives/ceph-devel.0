From: Casey Bodley <cbodley@redhat.com>
Subject: Is jenkins still building docs for branches in ceph.git?
Date: Thu, 18 May 2017 12:25:34 -0400
Message-ID: <9d38ef73-ca54-00c4-7c12-35ef75280279@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33476 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755985AbdERQZh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 12:25:37 -0400
Received: by mail-qt0-f176.google.com with SMTP id t26so38475163qtg.0
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 09:25:36 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id 27sm1972880qtz.17.2017.05.18.09.25.35
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 09:25:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

The last few times I pushed doc branches to ceph/ceph.git, I never saw 
previews built. For example, I pushed 
https://github.com/ceph/ceph/commits/wip-doc-rgw-remove-agent a couple 
days ago, and I'm still getting 404 errors for 
http://docs.ceph.com/docs/wip-doc-rgw-remove-agent/.

This used to work. Are there new rules about which branches get built? 
Does there have to be an open PR targetting the ceph/ceph.git branch?

Thanks,
Casey
