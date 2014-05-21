From: Haomai Wang <haomaiwang@gmail.com>
Subject: [Performance] Improvement on DB Performance
Date: Wed, 21 May 2014 18:15:45 +0800
Message-ID: <CACJqLyY5VSQubaPvk2N3BrRx=YZ7EpiyRJZbWnNM=bQMfNA8=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43382 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaEUKPr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 May 2014 06:15:47 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so7376354wib.5
        for <ceph-devel@vger.kernel.org>; Wed, 21 May 2014 03:15:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I remember there exists discuss about DB(mysql) performance on rbd.
Recently I test mysql-bench with rbd and found awful performance. So I
dive into it and find that main cause is "flush" request from guest.
As we know, applications such as mysql, ceph has own journal for
durable and journal usually send sync&direct io. If fs barrier is on,
each sync io operation make kernel issue "sync"(barrier) request to
block device. Here, qemu will call "rbd_aio_flush" to apply.

Via systemtap, I found a amazing thing:
aio_flush                          sum: 4177085    avg: 24145  count:
173      max: 28172  min: 22747
flush_set                          sum: 4172116    avg: 24116  count:
173      max: 28034  min: 22733
flush                              sum: 3029910    avg: 4      count:
670477   max: 1893   min: 3

This statistic info is gathered in 5s. Most of consuming time is on
"ObjectCacher::flush". What's more, with time increasing, the flush
count will be increasing.

After view source, I find the root cause is "ObjectCacher::flush_set",
it will iterator the "object_set" and look for dirty buffer. And
"object_set"  contains all objects ever opened.  For example:

2014-05-21 18:01:37.959013 7f785c7c6700  0 objectcacher flush_set
total: 5919 flushed: 5
2014-05-21 18:01:37.999698 7f785c7c6700  0 objectcacher flush_set
total: 5919 flushed: 5
2014-05-21 18:01:38.038405 7f785c7c6700  0 objectcacher flush_set
total: 5920 flushed: 5
2014-05-21 18:01:38.080118 7f785c7c6700  0 objectcacher flush_set
total: 5920 flushed: 5
2014-05-21 18:01:38.119792 7f785c7c6700  0 objectcacher flush_set
total: 5921 flushed: 5
2014-05-21 18:01:38.162004 7f785c7c6700  0 objectcacher flush_set
total: 5922 flushed: 5
2014-05-21 18:01:38.202755 7f785c7c6700  0 objectcacher flush_set
total: 5923 flushed: 5
2014-05-21 18:01:38.243880 7f785c7c6700  0 objectcacher flush_set
total: 5923 flushed: 5
2014-05-21 18:01:38.284399 7f785c7c6700  0 objectcacher flush_set
total: 5923 flushed: 5

These logs record the iteration info, the loop will check 5920 objects
but only 5 objects are dirty.

So I think the solution is make "ObjectCacher::flush_set" only
iterator the objects which is dirty.

-- 
Best Regards,

Wheat
