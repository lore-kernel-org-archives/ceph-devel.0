From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Fwd: [ceph] Put obj sometimes got 405 (#794)
Date: Thu, 7 Nov 2013 09:30:56 -0800
Message-ID: <CABBk=J-ih=nPn7nJsgjM1EA4kwvZoBXxyFvHXB6Ax0SG02FB2A@mail.gmail.com>
References: <ceph/ceph/pull/794@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:41740 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3KGRa5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 12:30:57 -0500
Received: by mail-vb0-f44.google.com with SMTP id 11so598761vbe.31
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 09:30:56 -0800 (PST)
In-Reply-To: <ceph/ceph/pull/794@github.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiangyulv@gmail.com, ceph-devel <ceph-devel@vger.kernel.org>

Hey,

  I wanted to backport that fix to dumpling, but just noticed that the
commits were missing a signed-off-by line. Can I add it?

Thanks,
Yehuda


---------- Forwarded message ----------
From: Xiangyu (Ray) Lv <notifications@github.com>
Date: Wed, Oct 30, 2013 at 7:24 PM
Subject: [ceph] Put obj sometimes got 405 (#794)
To: ceph/ceph <ceph@noreply.github.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>


Fixes:

Bug #6672 (http://tracker.ceph.com/issues/6672)

Original discussion at #783
Branch reviewed by @yehudasa.

________________________________

You can merge this Pull Request by running

  git pull https://github.com/xylv/ceph put-obj-sometimes-got-405

Or view, comment on, or merge it at:

  https://github.com/ceph/ceph/pull/794

Commit Summary

[rgw] Set initialized to true after populating table in hex_to_num()
Wrap hex_to_num table into class HexTable

File Changes

M src/rgw/rgw_common.cc (20)

Patch Links:

https://github.com/ceph/ceph/pull/794.patch
https://github.com/ceph/ceph/pull/794.diff
