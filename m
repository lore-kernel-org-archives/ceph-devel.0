From: Gregory Farnum <gfarnum@redhat.com>
Subject: deprecation and build warnings
Date: Tue, 5 Jan 2016 22:58:04 -0800
Message-ID: <CAJ4mKGZmuFy39rDW6JTfPUbJ7L3xpoq3ttje1CORVNY4eCkbHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37569 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcAFG6G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jan 2016 01:58:06 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so61885644wmf.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jan 2016 22:58:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I was annoyed again at our gitbuilders being all yellow because of
compile warnings so I went to check out how many of them are real and
how many of them are self-inflicted warnings. I just spot-checked
http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-amd64-basic/log.cgi?log=2694e1171f23166e8a11c57c7b284621498decd8,
but much to my pleasant surprise there are only two errors:

1) we have 16 uses of rados_ioctx_pool_required_alignment, which is deprecated.
2) we have two uses of libec_isa.so being linked against a loadable module.

Both of these are contained entirely in our unit tests. I don't know
exactly what's going on with the second one, but I imagine it's not a
difficult fix? For the first one, can we just stop testing it? Or in
some way suppress the warning for those callers? I'd love to have some
green show up on the dashboard again, so that it's not too hard to
notice when we introduce actual build regressions. ;)
-Greg
