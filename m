From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Why can't I delete a pool
Date: Thu, 30 Mar 2017 14:59:38 +0200
Message-ID: <022a7617-95fd-2a92-c7c9-274479b03778@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:65484 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933173AbdC3M7n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 08:59:43 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 727483CA3A
        for <ceph-devel@vger.kernel.org>; Thu, 30 Mar 2017 14:59:39 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

[~] wjw@cephtest> ceph osd pool delete cephfsdata cephfsdata
--yes-i-really-really-mean-it
Error EPERM: pool deletion is disabled; you must first set the
mon_allow_pool_delete config option to true before you can destroy a pool
Exit 1
[~] wjw@cephtest> ceph -n mon.a --show-config | grep allow
...
mon_allow_pool_delete = true
...

--WjW
