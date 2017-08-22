From: Oleg Kolosov <olekol@gmail.com>
Subject: Matching shard to crush bucket in erasure coding
Date: Tue, 22 Aug 2017 20:47:35 +0300
Message-ID: <CAODUPsG=wnHdROuNvvCcxeDtahG2V2C24ttEETJtebCGnx6C8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33769 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdHVRrg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 13:47:36 -0400
Received: by mail-oi0-f47.google.com with SMTP id f11so193136894oic.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 10:47:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I'm working on a new erasure code, different than the one implemented
in ceph lrc plugin. I'm trying to understand how ceph lrc plugin
allocates shards in a layer, but it's not clear from the code.

For example, say I have a local group containing shards 0,1,2,5
While 0,1,2 are data and 5 is parity. I'd like to place all of these
shards in the same rack.

Where in lrc .cc code  these shards, which are composing a single
layer, are allocated to the same rack?

Thanks,
Oleg
