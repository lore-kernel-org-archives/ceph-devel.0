From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Questions regarding mds early reply
Date: Wed, 29 Nov 2017 23:40:30 +0800
Message-ID: <CAEYCsVJcyqr4i6sz=1dvne-cGSHvBFmHf_0MT=zh26L1acx8hw@mail.gmail.com>
References: <CAEYCsVJCz4ecJNXyKLF0EyovJw8sLHwb_uzMBQaZVfasuuy+cw@mail.gmail.com>
 <CAEYCsVJAamRkFeH_3St0dMybks97q09P4b-h0+nVrFNPy_c-BA@mail.gmail.com> <CAAM7YAm4Dnzcc9uz-5iL9kaigoFbKjsZJjVP9J_LQX00zeia2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:34004 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbdK2Pkb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Nov 2017 10:40:31 -0500
Received: by mail-it0-f46.google.com with SMTP id m11so26643996iti.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Nov 2017 07:40:31 -0800 (PST)
In-Reply-To: <CAAM7YAm4Dnzcc9uz-5iL9kaigoFbKjsZJjVP9J_LQX00zeia2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks Zheng,  see if i understand correctly, when early reply the
syscall is returned and the request initiator can see the change from
its local inode/dentry cache. However, the change to mdcache is
actually happen in the context finisher of the log op, so that other
client will not see the change.
