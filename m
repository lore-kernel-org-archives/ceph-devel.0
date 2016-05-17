From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Fwd: How does EC pools support thousands of xattrs (XFS) but no omaps?
Date: Tue, 17 May 2016 18:12:21 +0530
Message-ID: <CAOu2ZZXBYeCUGhz5RpePsP6CVvh0r2d+FJHT7iHHt=RxuEPznA@mail.gmail.com>
References: <CAOu2ZZUT8hqUmatSWTX7RxzhS1oo_5R0NmZ49+k0D91QPHTOjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35843 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbcEQMmW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 08:42:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id n129so138670456wmn.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2016 05:42:22 -0700 (PDT)
In-Reply-To: <CAOu2ZZUT8hqUmatSWTX7RxzhS1oo_5R0NmZ49+k0D91QPHTOjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

While migrating to EC pools, I came to know that it does not support
omaps but it allows thousands of xattrs (XFS). Are these xattrs being
stored in a key-value store or in XFS file system?

Regards
Chandan
