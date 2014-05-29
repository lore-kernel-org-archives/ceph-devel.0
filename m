From: Gregory Farnum <greg@inktank.com>
Subject: xattr spillout appears broken :(
Date: Thu, 29 May 2014 16:15:24 -0700
Message-ID: <CAPYLRzh7bno0Ppb7hayJrc-TQM24iO-+RgtHYWZmYYVAtBYjVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36686 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaE2XPZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 May 2014 19:15:25 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so3220182qgd.29
        for <ceph-devel@vger.kernel.org>; Thu, 29 May 2014 16:15:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I got a bug report a little while ago that we were hitting leveldb on
every xattr lookup with Firefly, and after looking into it I indeed
discovered that we never set the XATTR_SPILL_OUT_NAME xattr when
creating new files.
I pushed a branch wip-xattr-spillout containing a fix for that, plus
some more general FileStore cleanups Sam asked for, but (much to my
surprise) it didn't pass testing. I tried backing off and bisecting
down to the broken commit, and although the test failures aren't
consistent, it appears that simply setting the spillout xattr is
enough to sporadically break tests (patch "FileStore: set
XATTR_NO_SPILL_OUT when creating new files.").

I've done some code inspection to see if I can find the issue and am
drawing a blank. It's possible my setup patch is just wrong, but I
think the issue must be elsewhere in the code. I wonder if you could
take a look and try to figure it out?

My test logs (these are against two slightly different branches; so
check the sha1s) are:
Test Run: gregf-2014-05-22_15:27:32-rados-wip-xattr-spillout-basic-testing-basic-plana
=================================================================
info:   http://pulpito.ceph.com/gregf-2014-05-22_15:27:32-rados-wip-xattr-spillout-basic-testing-basic-plana/
logs:   http://qa-proxy.ceph.com/teuthology/gregf-2014-05-22_15:27:32-rados-wip-xattr-spillout-basic-testing-basic-plana/

Test Run: gregf-2014-05-20_15:45:53-rados-wip-xattr-spillout-testing-basic-plana
=================================================================
info:   http://pulpito.ceph.com/gregf-2014-05-20_15:45:53-rados-wip-xattr-spillout-testing-basic-plana/
logs:   http://qa-proxy.ceph.com/teuthology/gregf-2014-05-20_15:45:53-rados-wip-xattr-spillout-testing-basic-plana/

If you don't think you'll have a chance, let me know and I'll dig into
it more. Thanks!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
