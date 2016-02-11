From: Jens Rosenboom <j.rosenboom@x-ion.de>
Subject: deep-scrub and .rgw.index pool
Date: Thu, 11 Feb 2016 11:24:13 +0100
Message-ID: <CADr68WaQW0-MY60qyN-B8bRufJ1odG7GZ9DL5q7pGtzLQFfBrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33738 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcBKKYQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Feb 2016 05:24:16 -0500
Received: by mail-lb0-f182.google.com with SMTP id x4so25302817lbm.0
        for <ceph-devel@vger.kernel.org>; Thu, 11 Feb 2016 02:24:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph <ceph-devel@vger.kernel.org>

Does the digest of an object also include its metadata? Or is possibly
deep-scrubbing a pool full of objects of size 0 completely pointless?

I'm asking because we are seeing lot of blocked requests during
deep-scrubs for one particular PG in our index pool for a cluster
containing around 200M objects. The scrub also takes a couple of
minutes instead of a couple of seconds that we see for all the other
PGs in that pool, but I haven't yet found out what makes this
particular PG so special.
