From: Dan Mick <dan.mick@inktank.com>
Subject: erasure coding / jerasure: topic of interest?
Date: Fri, 20 Sep 2013 22:22:59 -0700
Message-ID: <523D2D33.1030407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59508 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3IUFXE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Sep 2013 01:23:04 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1165058pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Sep 2013 22:23:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <loic@dachary.org>

At SDC this week, Ethan Miller presented about some work he has done 
along with others including Jim Plank, who also was involved with 
jerasure; it seems like this work may be useful for optimizing the
erasure code calculations on Intel CPUs, at least:

http://bitbucket.org/ethanmiller/gf-complete

Paper here: http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
looks very much like the presentation Ethan gave at the conference.

-- 
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs
