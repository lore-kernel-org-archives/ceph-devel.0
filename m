From: Nicheal <zay11022@gmail.com>
Subject: why index (collectionIndex) need a lock?
Date: Tue, 30 Sep 2014 15:08:58 +0800
Message-ID: <CALZt5jwhBNifcagmsGBZiEC99Q0TvDFPy45f05hidVZedKEK-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:38549 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaI3HI7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 03:08:59 -0400
Received: by mail-ob0-f194.google.com with SMTP id vb8so1184578obc.9
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 00:08:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear develops,

I go through the files (hashIndex, LFNIndex and CollectionIndex), I
cannot find any parameters need to grasp a lock. And basically,
(hashIndex, LFNIndex and CollectionIndex) is used to manage a
collection of objects.

Thus, just in one case, when the spilt or merge is on going, then
lookup() path function is called to get the object path. It may obtain
a wrong path, right?

If so, why not using a state parameter in the class CollectionIndex or
HashIndex indicating the current state of this collection (split,
merge on going or none) and grasp a lock when the state changes. Why
always lock the index before lookup() path or lfn_find()?

Any other reasons?

Nicheal
