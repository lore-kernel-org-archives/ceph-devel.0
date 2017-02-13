From: liuchang0812 <liuchang0812@gmail.com>
Subject: question about default leveldb block_size
Date: Mon, 13 Feb 2017 11:34:21 +0800
Message-ID: <CACKY0b-5bnPp40mvx2TMfAwu6_-fVoqaxN-Uhxcfmqd0-ccknw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34474 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdBMDeW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Feb 2017 22:34:22 -0500
Received: by mail-yw0-f171.google.com with SMTP id w75so44499896ywg.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Feb 2017 19:34:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I saw that we use 0 as leveldb_block_size [1] as following:

     OPTION(leveldb_block_size, OPT_U64, 0) // leveldb block size

It seems that leveldb don't process 0 as a special value.

 Any reasons for this configuration? why not 4KB or 32KB?



[1] https://github.com/ceph/ceph/blob/master/src/common/config_opts.h#L887
