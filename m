From: Harshal Gupta <harshal.gupta001@gmail.com>
Subject: Bucket name restrictions in RGW
Date: Fri, 12 Jun 2015 20:58:50 +0530
Message-ID: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f193.google.com ([209.85.212.193]:34112 "EHLO
	mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbFLP3M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 11:29:12 -0400
Received: by wivr20 with SMTP id r20so3043555wiv.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 08:29:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I was looking into the bucket creation and found out that we are able
to create buckets with names which are not DNS compliant. One such
example is names ending with a non-alphanumeric character. There are
other rules which make bucket name restrictions in RGW more lenient
than what is recommended for DNS compliant names as well.

In case we plan to support website hosting in future on RGW, we will
need to make bucket names DNS compliant. Keeping that in mind, I am
thinking about modifying the bucket name rules and applying more
restrictions to make them more towards DNS compliant.

Please share your opinion about this.

Thanks,
Harshal Gupta
