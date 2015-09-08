From: Haomai Wang <haomaiwang@gmail.com>
Subject: [NewStore]About PGLog Workload With RocksDB
Date: Tue, 8 Sep 2015 21:58:07 +0800
Message-ID: <CACJqLybUOPaj3kFrn6b3-1O7fEd0zom2KR5ETC+DiPpid4HQew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36479 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbbIHN6J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 09:58:09 -0400
Received: by ykcf206 with SMTP id f206so119513781ykc.3
        for <ceph-devel@vger.kernel.org>; Tue, 08 Sep 2015 06:58:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

I notice your post in rocksdb page about make rocksdb aware of short
alive key/value pairs.

I think it would be great if one keyvalue db impl could support
different key types with different store behaviors. But it looks like
difficult for me to add this feature to an existing db.

So combine my experience with filestore, I just think let
NewStore/FileStore aware of this short-alive keys(Or just PGLog keys)
could be easy and effective. PGLog owned by PG and maintain the
history of ops. It's alike Journal Data but only have several hundreds
bytes. Actually we only need to have several hundreds MB at most to
store all pgs pglog. For FileStore, we already have FileJournal have a
copy of PGLog, previously I always think about reduce another copy in
leveldb to reduce leveldb calls which consumes lots of cpu cycles. But
it need a lot of works to be done in FileJournal to aware of pglog
things. NewStore doesn't use FileJournal and it should be easier to
settle down my idea(?).

Actually I think a rados write op in current objectstore impl that
omap key/value pairs hurts performance hugely. Lots of cpu cycles are
consumed and contributes to short-alive keys(pglog). It should be a
obvious optimization point. In the other hands, pglog is dull and
doesn't need rich keyvalue api supports. Maybe a lightweight
filejournal to settle down pglogs keys is also worth to try.

In short, I think it would be cleaner and easier than improving
rocksdb to impl a pglog-optimization structure to store this.

PS(off topic): a keyvaluedb benchmark http://sphia.org/benchmarks.html



-- 
Best Regards,

Wheat
