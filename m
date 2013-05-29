From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: High CPU usage when enabling mon leveldb compression
Date: Wed, 29 May 2013 11:47:21 +0200
Message-ID: <CAF6-1L7H2cw9Rx+Y2ibS7AZvU0rwSHLStcRMyTwmaZ3Xry9RmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:64312 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964948Ab3E2JrX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 05:47:23 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf20so3322589bkc.35
        for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 02:47:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


In an attempt to reduce the high IO usage of the mon, I tried to
enable the LevelDB snappy compression.

The good news is that it did reduce the IO substantially (~ 3.5x less
IO) and also the disk space (by about the same ratio).

Unfortunately, it seems it also takes a LOT of CPU. ( ~ 50/60% of one
core on some Xeon server). And I'm not exactly sure why.
I write a quick snappy benchmark and it compresses on that server at
nearly 500 MB/s and decompresses even faster (all single threaded
test).
The test data I used was a binary PGMap I took from the cluster (so I
get data with same patterns as in reality).


Cheers,

    Sylvain
