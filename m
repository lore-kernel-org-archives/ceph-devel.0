From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [NewStore]About PGLog Workload With RocksDB
Date: Tue, 8 Sep 2015 22:06:02 +0800
Message-ID: <CACJqLyanf82a60YrLmYio80ff+-xkdWUiSqhiiu3v8TqSa0K_w@mail.gmail.com>
References: <CACJqLybUOPaj3kFrn6b3-1O7fEd0zom2KR5ETC+DiPpid4HQew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35315 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbbIHOGE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 10:06:04 -0400
Received: by ykdu9 with SMTP id u9so44318080ykd.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Sep 2015 07:06:04 -0700 (PDT)
In-Reply-To: <CACJqLybUOPaj3kFrn6b3-1O7fEd0zom2KR5ETC+DiPpid4HQew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hit "Send" by accident for previous mail. :-(

some points about pglog:
1. short-alive but frequency(HIGH)
2. small and related to the number of pgs
3. typical seq read/write scene
4. doesn't need rich structure like LSM or B-tree to support apis, has
obvious different to user-side/other omap keys.
5. a simple loopback impl is efficient and simple


On Tue, Sep 8, 2015 at 9:58 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Hi Sage,
>
> I notice your post in rocksdb page about make rocksdb aware of short
> alive key/value pairs.
>
> I think it would be great if one keyvalue db impl could support
> different key types with different store behaviors. But it looks like
> difficult for me to add this feature to an existing db.
>
> So combine my experience with filestore, I just think let
> NewStore/FileStore aware of this short-alive keys(Or just PGLog keys)
> could be easy and effective. PGLog owned by PG and maintain the
> history of ops. It's alike Journal Data but only have several hundreds
> bytes. Actually we only need to have several hundreds MB at most to
> store all pgs pglog. For FileStore, we already have FileJournal have a
> copy of PGLog, previously I always think about reduce another copy in
> leveldb to reduce leveldb calls which consumes lots of cpu cycles. But
> it need a lot of works to be done in FileJournal to aware of pglog
> things. NewStore doesn't use FileJournal and it should be easier to
> settle down my idea(?).
>
> Actually I think a rados write op in current objectstore impl that
> omap key/value pairs hurts performance hugely. Lots of cpu cycles are
> consumed and contributes to short-alive keys(pglog). It should be a
> obvious optimization point. In the other hands, pglog is dull and
> doesn't need rich keyvalue api supports. Maybe a lightweight
> filejournal to settle down pglogs keys is also worth to try.
>
> In short, I think it would be cleaner and easier than improving
> rocksdb to impl a pglog-optimization structure to store this.
>
> PS(off topic): a keyvaluedb benchmark http://sphia.org/benchmarks.html
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
