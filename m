From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Fwd: Jenkins build is back to normal : ceph-master #1305
Date: Tue, 10 Oct 2017 17:29:55 +0200
Message-ID: <a5f8c802-839f-6b62-124c-3cd830113aaf@digiware.nl>
References: <1798451054.15.1507647774136.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:32766 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932518AbdJJPaR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Oct 2017 11:30:17 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id D63BC2E245
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 17:29:57 +0200 (CEST)
In-Reply-To: <1798451054.15.1507647774136.JavaMail.jenkins@cephdev.digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


It took PRs:
    18199.diff and one extra public function decl.
    18217.diff

And -D ALLOCATOR=libc with cmake to get FreeBSD building working again.

--WjW

-------- Forwarded Message --------
Subject: Jenkins build is back to normal : ceph-master #1305
Date: Tue, 10 Oct 2017 17:02:54 +0200 (CEST)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

See
<http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1305/display/redirect>

