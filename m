From: Zhiqiang Wang <wonzhq@gmail.com>
Subject: Snap handling in the cache tiering case
Date: Thu, 26 May 2016 14:40:08 +0800
Message-ID: <CA+cZ7sjxwa=AZYiQEQA7Han97QcuCSYKZqt_RNwG9Z5N2BTQ3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36991 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbcEZGqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 02:46:16 -0400
Received: by mail-it0-f41.google.com with SMTP id z123so41679251itg.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2016 23:46:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

In the current implementation, the base pool's snap info is well
propagated to the cache pool. However, this is not vice verse. When
creating a pool snap on the cache pool, this information is not shared
with the base. And it could potentially be overwritten by the later
snap operations on the base pool. Should we allow pool snap operations
on the cache pool?

Another question is that is it safe to clear all the snap infos on the
cache pool when removing the cache tiering? This seems ok to me if the
base and cache pools' snap infos are identical. I'm asking this
because if the snap infos are not cleared on the cache pool, it
prevents us from using this pool as a cache pool again.
