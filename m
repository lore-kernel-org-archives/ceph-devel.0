From: kefu chai <tchaikov@gmail.com>
Subject: multi-line comments
Date: Thu, 17 Aug 2017 19:22:27 +0800
Message-ID: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35527 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbdHQLW3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 07:22:29 -0400
Received: by mail-vk0-f44.google.com with SMTP id d124so21233114vkf.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 04:22:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, amitkuma@redhat.com

hi Amit,

i found that you started to encourage developers to use "/* */" for
multiple-lined comment while reviewing pull requests. IIUC, it's more
of a gray area, and sort of a personal preferences. so i don't
understand why we need to go this way. and i believe, in modern C++
practice, "//" is more common[0], and works better for developers. in
the sense that, it's more readable, conforms to C++ standards, and
works just fine with editors/tools.


---
[0] https://google.github.io/styleguide/cppguide.html#Comment_Style

-- 
Regards
Kefu Chai
