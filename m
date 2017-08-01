From: Oleg Kolosov <olekol@gmail.com>
Subject: Rados bench with a failed node
Date: Tue, 1 Aug 2017 14:41:50 +0300
Message-ID: <CAODUPsHkC153vq5O7TKjt+ZTgMofsyR7m7hdKdi2ASbKTMWpRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36419 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHALlv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Aug 2017 07:41:51 -0400
Received: by mail-oi0-f45.google.com with SMTP id g131so12299183oic.3
        for <ceph-devel@vger.kernel.org>; Tue, 01 Aug 2017 04:41:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I'm developing my own erasure code and I'm trying to run rados
benchmark on it. My experiment consists of writing objects, then while
reading them I stop an OSD and see how it affects latency.
While running this experiment with 'rados bench' I get an error after
stopping the osd:

benchmark_data_adm-1_3806_object8 is not correct!
read got -5
error during benchmark: -5
error 5: (5) Input/output error


Is it expected to fail like this?
Is there a way to bypass it or somehow perform my experiment?

Thanks,
Oleg
