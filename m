From: Willem Jan Withagen <wjw@digiware.nl>
Subject: compiling with Clang 5.0
Date: Tue, 29 Aug 2017 17:08:51 +0200
Message-ID: <4eacf564-d665-900b-f0f7-ae1f08ade705@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:37026 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbdH2PIx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 29 Aug 2017 11:08:53 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 4BA4B2FD
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 17:08:51 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

Just a point on the timeline

FreeBSD current has moved to Clang 5.0.
And other than a few `#pragma GCC` things that start warnings I was able
to build HEAD without any problems.

So that is great for the current code base.

For those that are currious about the warning:
/home/jenkins/workspace/ceph-master/src/include/encoding.h:300:32:
warning: unknown warning group '-Wmaybe-uninitialized', ignored
[-Wunknown-warning-option]
#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
                               ^
1 warning generated.

And given the file, it pops up quite a lot.
So I might want to submit a PR wrapping this in an `#ifdef`

--WjW
