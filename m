From: sheng qiu <herbert1984106@gmail.com>
Subject: question about snapset
Date: Thu, 2 Feb 2017 11:04:45 -0800
Message-ID: <CAB7xdi=b=HxAepvKna-Rfi9z9Wd+SAxADsbZUkYk-TuEkYJnjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33720 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbdBBTEq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 14:04:46 -0500
Received: by mail-vk0-f54.google.com with SMTP id k127so17575426vke.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2017 11:04:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi cephers,

We are reading the codes of Ceph I/O path. We found within the
do_op(), it tries to get the object context each time as well as the
snapset context.

may i ask what's the usage of the snapset context and what's the
relationship between snapset context and the individual object? Does
each object has a snapset context ? Does it stores as attribute within
the onode that associated with the object?
i read some articles said only head object has snapset context, may i
ask what's the head object and what's the relationship between a head
object and other non-head objects?

Thanks in advance.

Thanks,
Sheng
