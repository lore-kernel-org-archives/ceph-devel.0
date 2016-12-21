From: Tone Zhang <tone.zhang@linaro.org>
Subject: Ceph installation packages on Ubuntu
Date: Wed, 21 Dec 2016 16:21:11 +0800
Message-ID: <CAOCf4An8SHRYgeKQ-t9h1TjGU9k8GCc0GGmZRCt0dikUG3Azeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34782 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934807AbcLUIVM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2016 03:21:12 -0500
Received: by mail-ua0-f175.google.com with SMTP id 34so9819185uac.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2016 00:21:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers,

In recent, I tried to deploy Ceph cluster on Ubuntu 16.04 on ARM
platform via "ceph-deploy".

When I ran "ceph-deploy install" command, I got "cannot find ceph-osd"
and "ceph-mon". I checked the ceph download center for Ubuntu on ARM
(https://download.ceph.com/debian-jewel/pool/main/c/ceph/), it seems
since Ceph 10.2.4, there is no deb packages for ARM any more. What's
happened? Does it mean ceph jewel delivery on ARM platform will be
stopped?

If I want to deploy Ceph jewel 10.2.2 via ceph-deploy, how shall I do?
Except download all the deb packaged for 10.2.2 and install ceph
manually, is there an easier way?

Thanks a lot!

Br,
Tone
