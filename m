From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: Check memory allocation result
Date: Tue, 30 Jan 2018 14:31:19 +0100
Message-ID: <CAOi1vP8+4qTvXKwioBUxY_n2mH6p3HfZiXE2+95S4sX_BuHymA@mail.gmail.com>
References: <1516949683-127606-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP_b_1Um6gwo+Zz+YF8jmBbJY79Gndx8ie0caWrcGwStuA@mail.gmail.com> <BCF48816-962F-4314-BDD6-84F7BC57267F@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:55160 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeA3NbU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jan 2018 08:31:20 -0500
Received: by mail-it0-f68.google.com with SMTP id k131so606544ith.4
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jan 2018 05:31:20 -0800 (PST)
In-Reply-To: <BCF48816-962F-4314-BDD6-84F7BC57267F@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

On Tue, Jan 30, 2018 at 1:08 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Hi Ilya
>
> Is there a specific tree for ceph kernel client?
>
> I found below git repository is quite old.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git/

Yes, as noted in MAINTAINERS:

  git://github.com/ceph/ceph-client.git

Thanks,

                Ilya
