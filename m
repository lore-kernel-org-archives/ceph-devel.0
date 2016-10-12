From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Running multiple Jenkins on one host??
Date: Wed, 12 Oct 2016 14:52:55 +0200
Message-ID: <f01169fc-17c9-19dc-58d4-63c58085bb10@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:16870 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932866AbcJLMxO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Oct 2016 08:53:14 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 2FA852AFB8
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 14:53:09 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Are people running multiple builds in Jenkins in parallel on the same
host/vm?

Or is everybody using one Jenkings thread per VM, and thus avoiding
classes in /tmp and in port-usuage?

--WjW
