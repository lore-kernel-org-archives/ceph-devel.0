From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Question in crush_add_tree_bucket_item
Date: Sat, 21 Apr 2012 21:29:03 +0800
Message-ID: <CALwGbPLPaAz3-NbXLtyQWt_QeA9v1bur7kygrAX47q8+_pyYzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59658 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab2DUN3E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Apr 2012 09:29:04 -0400
Received: by iagz16 with SMTP id z16so14560979iag.19
        for <ceph-devel@vger.kernel.org>; Sat, 21 Apr 2012 06:29:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, everyone.

While reading crush_remove_tree_bucket_item, I found that removed
items will still occupy its original position in the tree, but set its
weight to 0.
And in crush_add_tree_bucket_item, why don't we reuse these items with
0 weight since I don't see additional data migration if we reuse these
nodes?
