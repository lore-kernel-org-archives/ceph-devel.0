From: sheng qiu <herbert1984106@gmail.com>
Subject: ondisk_read/write lock
Date: Wed, 8 Feb 2017 16:10:24 -0800
Message-ID: <CAB7xdin7da09+NC5qjXu7Yoz6wmGCVFztDDUmtUXPSk5+m=eJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35653 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbdBIAKZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 19:10:25 -0500
Received: by mail-ua0-f169.google.com with SMTP id y9so122898853uae.2
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 16:10:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi cepher,

I noticed that when PG worker is processing the op, it may acquire
obc->ondisk_read_lock or obc->ondisk_write_lock. it's used to protect
concurrent read and write to same object.

But to my understanding, the PG lock is held while worker is
processing op which already prevent concurrent access for the same
object. Does that mean those locks are not actually needed?

Thanks,
Sheng
