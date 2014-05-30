From: Gregory Farnum <greg@inktank.com>
Subject: Re: xattr spillout appears broken :(
Date: Fri, 30 May 2014 11:06:30 -0700
Message-ID: <CAPYLRzi8HpyxEmJgyde9yrmpZP2t9_1odEwff_9Tck40tCiSCA@mail.gmail.com>
References: <CAPYLRzh7bno0Ppb7hayJrc-TQM24iO-+RgtHYWZmYYVAtBYjVg@mail.gmail.com>
	<CACJqLybuxRR1hgL+b+ijmRzySFH054ZHqOYm50PmLNf-W01JOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:37698 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbaE3SGb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 May 2014 14:06:31 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so6361626qgz.2
        for <ceph-devel@vger.kernel.org>; Fri, 30 May 2014 11:06:30 -0700 (PDT)
In-Reply-To: <CACJqLybuxRR1hgL+b+ijmRzySFH054ZHqOYm50PmLNf-W01JOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 30, 2014 at 2:18 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Hi Gregory,
>
> I try to reproduce the bug in my local machine but failed.
>
> My test cmdline:
> ./ceph_test_rados --op read 100 --op write 100 --op delete 50
> --max-ops 400000 --objects 1024 --max-in-flight 64 --size 4000000
> --min-stride-size 400000 --max-stride-size 800000 --max-seconds 600
> --op copy_from 50 --op snap_create 50 --op snap_remove 50 --op
> rollback 50 --op setattr 25 --op rmattr 25 --pool unique_pool_0
>
> Is there any tip to reproduce it?

Hmm. I've been directly running the teuthology tests that failed; that
is the command line it's running though so I think the only difference
would be that I've got OSD thrashing (ie, recovery) happening while
the test is running.
Most of the other failures were scrub turning up inconsistencies in
the xattrs at each replica/shard of an object. I didn't see any
obvious mechanism by which storing values in xattrs versus leveldb
would impact these higher-level primitives, but maybe you have some
idea?
-Greg
