From: Zhiqiang Wang <wonzhq@gmail.com>
Subject: Evict op on a watched object
Date: Mon, 11 Apr 2016 23:11:07 +0800
Message-ID: <CA+cZ7sid2YxNRcNzXS3CF=qPx3UWUw0jC0DaEpV9mxZ3E_piJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:32790 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbcDKPLI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 11:11:08 -0400
Received: by mail-io0-f170.google.com with SMTP id o126so190322787iod.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 08:11:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Currently it is not allowed to issue an evict op
(CEPH_OSD_OP_CACHE_EVICT) on an object which has watchers (e.g. the
rbd header). EBUSY is returned in this case. This leads to the the
flush-evict-all failure during removing a cache tier, something like
below:

rbd_header.4fc06b8b4567
failed to evict /rbd_header.4fc06b8b4567: (16) Device or resource busy

My question is that do we actually need to do so? The object in the
base pool should have the watcher information as well after the flush.
Probably we could remove this 'watcher' check to make flush-evict-all
happy?
