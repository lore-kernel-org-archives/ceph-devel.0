From: Haomai Wang <haomaiwang@gmail.com>
Subject: [RFC]About FileStore optimizations
Date: Thu, 30 Jan 2014 15:04:16 +0800
Message-ID: <499E8275-69B6-4758-84C3-77467D1D1AB3@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:45851 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaA3HE1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 02:04:27 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so2675221pde.41
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jan 2014 23:04:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, somnath.roy@sandisk.com

Hi all,

I noticed a pull request(https://github.com/ceph/ceph/pull/1152) which
make a deal of optimizations on FileStore. Although the way modify ObjecStore
and caller's codes are not accepted for me, it still seemed good for
performance purpose.

I agree with we need a session mechanism to cache "fd", "lock" and "path", etc.
For example, avoid multi lfn_open, lfn_find, in one transaction. In a simple
performance test with SSD backend by me, lfn_find and "fd" will be main
throttle.

So maybe a better idea is that introduce a structure called "TransactionStuff"
or other name in FileStore::_do_transactions, which cache path, object
existence and others to avoid extra works in actual operation
implementations(such as lfn_find in omap* functions). It may help to reduce a
mess of lock in DBObjectMap, CollectionIndex or FDCache. Especially, we already
have "apply_lock" in "OpSequencer", we could lock object in
init_transaction(new introduced) in ease without considering parallelism problem.

  t = init_transaction();

  for (list<Transaction*>::iterator p = tls.begin();
       p != tls.end();
       ++p, trans_num++) {
    r = _do_transaction(**p, op_seq, trans_num, handle);
    if (r < 0)
      break;
    if (handle)
      handle->reset_tp_timeout();
  }

  clean_transaction(t); 



Best regards,
Wheats



