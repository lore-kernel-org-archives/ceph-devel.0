From: Sugang Li <sugangli@winlab.rutgers.edu>
Subject: librados write operation
Date: Tue, 28 Jun 2016 17:06:58 -0400
Message-ID: <CAG0LszkAibL2q=1XF+iXjJZBGYUgLbfeq1H5-dsYN75FZOMpmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34673 "EHLO
	mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcF1VNr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 17:13:47 -0400
Received: by mail-qt0-f169.google.com with SMTP id m2so14654944qtd.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 14:13:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

I am looking into the ceph src code about how the write is
implemented. When I am using rados bench to perform write operation,
I can see that "void write(uint64_t off, bufferlist& bl, uint64_t
truncate_size, uint32_t truncate_seq)" in Objecter.h is called for
every write, and this operation is put into a queue named "ops". My
understand is that, another process/thread will dequeue this
operation, and look up the CRUSH maps to find a primary OSD and push
it the data (or ask it to pull the data). If this is the case, what
exactly function is doing this? If this is not the case, then what
will be the following operation?

Thanks,

Sugang
