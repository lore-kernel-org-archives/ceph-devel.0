From: Ilya Dryomov <idryomov@gmail.com>
Subject: wip-fancy-striping in ceph/ceph-client
Date: Tue, 13 Feb 2018 10:58:56 +0100
Message-ID: <CAOi1vP-4_gmH2DqL2EN2_MkLju3frqBkbun7P=U=HrMUMLnOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:40364 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933955AbeBMJ66 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 04:58:58 -0500
Received: by mail-io0-f179.google.com with SMTP id t22so20664130ioa.7
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 01:58:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Alex Elder <elder@linaro.org>, David Disseldorp <ddiss@suse.de>, Maged Mokhtar <mmokhtar@petasan.org>

Hello,

I've pushed wip-fancy-striping with my striping v2 patches.  I didn't
want to patch bomb the list and opened a dummy PR for feedback:

  https://github.com/ceph/ceph-client/pull/19

As this is a full striping v2 implementation with adjacent extent
merging and no limitations on parent layouts, the patch set is very
invasive -- it's basically a rewrite of the entire I/O path.  Any
review comments and testing cycles would be greatly appreciated!

Thanks,

                Ilya
