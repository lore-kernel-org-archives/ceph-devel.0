From: Willem Jan Withagen <wjw@digiware.nl>
Subject: unset_dumpable
Date: Thu, 20 Jul 2017 16:02:20 +0200
Message-ID: <a7cd6c1f-93f7-e652-68ff-bdfc89ff20c1@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:39176 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965347AbdGTOCX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Jul 2017 10:02:23 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id E7A4545CC7
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jul 2017 16:02:20 +0200 (CEST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm running in too many:
/home/jenkins/workspace/ceph-master/src/test/bufferlist.cc:490:11:
warning: unused variable 'unset_dumpable' [-Wunused-variable]
    PrCtl unset_dumpable;
          ^

for it to be by accident??
But why is this variable created in about a dozen functions?

--WjW
