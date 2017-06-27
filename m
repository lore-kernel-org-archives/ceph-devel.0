From: Ning Yao <zay11022@gmail.com>
Subject: cls_rbd copyup and write
Date: Tue, 27 Jun 2017 16:22:46 +0800
Message-ID: <CALZt5jzk+8yS7SY6L+5BNvKuTGDZV+KOW5b=vDqO=R7t_o9Vfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33319 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdF0IWr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 04:22:47 -0400
Received: by mail-io0-f172.google.com with SMTP id h64so13640133iod.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 01:22:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

currently I find that when do copy on write for a clone image. librbd
call the cls copyup function to write the data, reading from its
parent, to the child.

However, there is a issue here:  if an object in the parent image -->
[0, 8192] with data and [8192, end] without data, then after COW
operation, it will filling the whole object [0, end] to the children
object with [8192, end] all zeros. This phenomenon also occurs in
flatten images.

Actually, we already have sparse_read to just read data without holes.
However, copyup function does not support to write serveral fragments
such as {[0, 8192], [16384,20480]}.

So it that possible to direct send OSDOp {[cow write], [cow write],
[user write]} instead of  OSDOp {[copyup], [user write]} ?



Regards
Ning Yao
