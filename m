From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: MDS dir split size threshold
Date: Tue, 14 Mar 2017 15:34:39 -0400
Message-ID: <CA+2bHPYNC+0DBw1k013_W=MjJG_1SK_1vTy=X5FJzg9BuYthKA@mail.gmail.com>
References: <CAL-vruMC9XqFZHGwFgLN4LBaArUJa2R9gcSq-EfV1JDCg3=8QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36596 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdCNTfL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 15:35:11 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so77769649pge.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 12:35:10 -0700 (PDT)
In-Reply-To: <CAL-vruMC9XqFZHGwFgLN4LBaArUJa2R9gcSq-EfV1JDCg3=8QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vedant Nanda <vedant15114@iiitd.ac.in>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 14, 2017 at 3:08 PM, Vedant Nanda <vedant15114@iiitd.ac.in> wrote:
> I am working on this feature(http://tracker.ceph.com/issues/15835). It
> requires me to randomize the split threshold for each OSD so that all
> of them don't split together.
>
> I was looking at the documentation and I found that the variable
> 'mds_bal_split_size' sets the threshold and is defined in the MDS
> config file. I had some doubts regarding this:

You're looking at the wrong conf variable. I believe you want to look
at filestore_merge_threshold and filestore_split_multiple.

-- 
Patrick Donnelly
