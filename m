From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: mds: failed to decode msg EXPORT_DIR
Date: Mon, 30 Oct 2017 19:53:45 -0700
Message-ID: <CA+2bHPYdhOzhf5GLCnPdahC3fwVHyXLjQVTS-LdhPYEZg6mvUg@mail.gmail.com>
References: <CAEYCsVJWvRz-ndaanfpcbEwWYTL3AJW3sSa4anvDDymkNBHfSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:49371 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdJaCyQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Oct 2017 22:54:16 -0400
Received: by mail-qk0-f180.google.com with SMTP id q83so18746085qke.6
        for <ceph-devel@vger.kernel.org>; Mon, 30 Oct 2017 19:54:16 -0700 (PDT)
In-Reply-To: <CAEYCsVJWvRz-ndaanfpcbEwWYTL3AJW3sSa4anvDDymkNBHfSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <ukernel@gmail.com>, John Spray <jspray@redhat.com>

Hi Xiaoxi,

On Sat, Oct 21, 2017 at 2:42 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Hi , I hit this on one of my MDS rank, it looks to me like the
> export_dir message is way much too big , the hux dump take more than
> 20GB(stop by no more disk space...).

We have created a tracker ticket for this issue here:
http://tracker.ceph.com/issues/21892

-- 
Patrick Donnelly
