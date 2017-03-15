From: Vedant Nanda <vedant15114@iiitd.ac.in>
Subject: Re: MDS dir split size threshold
Date: Wed, 15 Mar 2017 18:08:29 +0530
Message-ID: <CAL-vruPRWmedOSU-xEQmx-Zxg4c4h6EWEt7AuWg=ZN4HB9Vg0w@mail.gmail.com>
References: <CAL-vruMC9XqFZHGwFgLN4LBaArUJa2R9gcSq-EfV1JDCg3=8QQ@mail.gmail.com>
 <CA+2bHPYNC+0DBw1k013_W=MjJG_1SK_1vTy=X5FJzg9BuYthKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:34653 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdCOMia (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Mar 2017 08:38:30 -0400
Received: by mail-ot0-f176.google.com with SMTP id o24so16622551otb.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Mar 2017 05:38:29 -0700 (PDT)
In-Reply-To: <CA+2bHPYNC+0DBw1k013_W=MjJG_1SK_1vTy=X5FJzg9BuYthKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Oh alright.

filestore_split_multiple and filestore_merge_theshold are set in the
config_opts.h file. Is it wise to randomise these values here?

On Mar 15, 2017 1:05 AM, "Patrick Donnelly" <pdonnell@redhat.com> wrote:

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
