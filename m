From: Noah Watkins <noahwatkins@gmail.com>
Subject: cap mask differences for `Client::stat` vs `Client::fstat`
Date: Wed, 13 Apr 2016 10:26:10 -0700
Message-ID: <CAB2gnbUz9D9VWz6=PtDdAQ7u+hVWeHa3rz=5CypGAFLq-bSboA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38514 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbcDMR0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 13:26:12 -0400
Received: by mail-ig0-f175.google.com with SMTP id ui10so65931087igc.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 10:26:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

In the libcephfs client it looks like both `Client::stat` and
`Client::lstat` use a default mask of CEPH_STAT_CAP_INODE_ALL and are
able to return immediately from `Client::_getattr` without making an
MDS request. However, `Client::fstat` uses hard-coded -1 as the cap
mask and always issues a MDS request. Is this the intended behavior,
and if so, what are different semantics of fstat that make this a
requirement?

Thanks,
Noah
