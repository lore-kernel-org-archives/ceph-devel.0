From: Vedant Nanda <vedant15114@iiitd.ac.in>
Subject: MDS dir split size threshold
Date: Wed, 15 Mar 2017 00:38:31 +0530
Message-ID: <CAL-vruMC9XqFZHGwFgLN4LBaArUJa2R9gcSq-EfV1JDCg3=8QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36761 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdCNTId (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 15:08:33 -0400
Received: by mail-ot0-f177.google.com with SMTP id i1so147019802ota.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 12:08:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am working on this feature(http://tracker.ceph.com/issues/15835). It
requires me to randomize the split threshold for each OSD so that all
of them don't split together.

I was looking at the documentation and I found that the variable
'mds_bal_split_size' sets the threshold and is defined in the MDS
config file. I had some doubts regarding this:

    Which config file is this referring to?
    Is it a good idea to randomize this value when the functions
should_split() and should_split_fast() are called?

Both these functions return boolean values(defined in CDir.cc and
CDir.h) based on whether we have reached the threshold, so i guess
randomizing while checking shouldn't really break anything. However,
each time we may be generating different values for this variable each
time the function is called.

What do you suggest? Is there a cleaner solution to this?

Cheers,

Vedant Nanda
