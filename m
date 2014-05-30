From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: xattr spillout appears broken :(
Date: Fri, 30 May 2014 17:18:31 +0800
Message-ID: <CACJqLybuxRR1hgL+b+ijmRzySFH054ZHqOYm50PmLNf-W01JOg@mail.gmail.com>
References: <CAPYLRzh7bno0Ppb7hayJrc-TQM24iO-+RgtHYWZmYYVAtBYjVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64322 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbaE3JSe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 May 2014 05:18:34 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so724432wib.11
        for <ceph-devel@vger.kernel.org>; Fri, 30 May 2014 02:18:32 -0700 (PDT)
In-Reply-To: <CAPYLRzh7bno0Ppb7hayJrc-TQM24iO-+RgtHYWZmYYVAtBYjVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Gregory,

I try to reproduce the bug in my local machine but failed.

My test cmdline:
./ceph_test_rados --op read 100 --op write 100 --op delete 50
--max-ops 400000 --objects 1024 --max-in-flight 64 --size 4000000
--min-stride-size 400000 --max-stride-size 800000 --max-seconds 600
--op copy_from 50 --op snap_create 50 --op snap_remove 50 --op
rollback 50 --op setattr 25 --op rmattr 25 --pool unique_pool_0

Is there any tip to reproduce it?

On Fri, May 30, 2014 at 7:15 AM, Gregory Farnum <greg@inktank.com> wrote:
> I got a bug report a little while ago that we were hitting leveldb on
> every xattr lookup with Firefly, and after looking into it I indeed
> discovered that we never set the XATTR_SPILL_OUT_NAME xattr when
> creating new files.
> I pushed a branch wip-xattr-spillout containing a fix for that, plus
> some more general FileStore cleanups Sam asked for, but (much to my
> surprise) it didn't pass testing. I tried backing off and bisecting
> down to the broken commit, and although the test failures aren't
> consistent, it appears that simply setting the spillout xattr is
> enough to sporadically break tests (patch "FileStore: set
> XATTR_NO_SPILL_OUT when creating new files.").
>
> I've done some code inspection to see if I can find the issue and am
> drawing a blank. It's possible my setup patch is just wrong, but I
> think the issue must be elsewhere in the code. I wonder if you could
> take a look and try to figure it out?
>
> My test logs (these are against two slightly different branches; so
> check the sha1s) are:
> Test Run: gregf-2014-05-22_15:27:32-rados-wip-xattr-spillout-basic-testing-basic-plana
> =================================================================
> info:   http://pulpito.ceph.com/gregf-2014-05-22_15:27:32-rados-wip-xattr-spillout-basic-testing-basic-plana/
> logs:   http://qa-proxy.ceph.com/teuthology/gregf-2014-05-22_15:27:32-rados-wip-xattr-spillout-basic-testing-basic-plana/
>
> Test Run: gregf-2014-05-20_15:45:53-rados-wip-xattr-spillout-testing-basic-plana
> =================================================================
> info:   http://pulpito.ceph.com/gregf-2014-05-20_15:45:53-rados-wip-xattr-spillout-testing-basic-plana/
> logs:   http://qa-proxy.ceph.com/teuthology/gregf-2014-05-20_15:45:53-rados-wip-xattr-spillout-testing-basic-plana/
>
> If you don't think you'll have a chance, let me know and I'll dig into
> it more. Thanks!
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com



-- 
Best Regards,

Wheat
