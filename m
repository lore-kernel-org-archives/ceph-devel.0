From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW: Implement S3 bucket logging feature
Date: Wed, 8 Mar 2017 20:42:41 +0000
Message-ID: <robbat2-20170308T204010-762077588Z@orbis-terrarum.net>
References: <CAF8OO3P3UiP+23CLUY0doYJLJNroAm2m5fu5zap6ctr3uP9wtw@mail.gmail.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:60670 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbdCHWZD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Mar 2017 17:25:03 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 7DE2D3416A1
        for <ceph-devel@vger.kernel.org>; Wed,  8 Mar 2017 20:42:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAF8OO3P3UiP+23CLUY0doYJLJNroAm2m5fu5zap6ctr3uP9wtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jiaying Ren <mikulely@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Mar 08, 2017 at 04:21:18PM +0800, Jiaying Ren wrote:
> Hi~ Yehuda and Ceph developers:
> 
> We're trying to implement S3 feature bucket
> logging (http://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html).
...
> Any comments are appreciated.Thx.

Strongly in favour of this from my end, and willing to find some cycles
to help you test/review it.

One thing that comes to mind, is ensuring logging of the correct client
IP when a load-balancer (eg HAProxy) is used in front of the RGW
instances. The internal IP of the load balancer should NOT be
written/exposed in the logs.

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
