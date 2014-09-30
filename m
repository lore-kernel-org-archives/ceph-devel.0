From: Plato Zhang <sangongs@gmail.com>
Subject: design a rados-based distributed kv store support scan op
Date: Tue, 30 Sep 2014 17:23:15 +0800
Message-ID: <CAJu7gM0T0nMjFtnPKh1ZT+BjV_-OOWmB6X0zQDUwGkmGfM0uPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:45858 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaI3JXQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 05:23:16 -0400
Received: by mail-we0-f171.google.com with SMTP id w61so1869045wes.16
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 02:23:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

We plan to develop a new distributed key-value storage engine, which
would based on rados and supoort range-scan operation. Besides, it'll
be open source.

We know rados is already a kv storage engine, and can do pretty well
if we use KeyValueStore.
However, it lacks the ability of scanning a key range, since keys are
hashed into pgs.

In our scenarios, scanning is a common need. We considered the way of
splitting our key space into fixed number of ranges, mapping each
range to a rados object, and then storing key/value pairs in rados
objects. However, there are two main disadvantages:
1. We can not adjust the number of ranges as the cluster scales.
2. For a good splitting, we must properly predict the distribution of
keys, or we'll encounter serious load-balance problem.

So we decide to develop a new service based on rados (we want to use
rados for unifying our storage infrastructure).

Before we start, we want to do some inquiries:
1. Is there already any similar system/module(scan-supported &&
rados-based) existed?
2. Except for the basic key-value functions, what features are you
most interested in?
3. Other suggestions?

Thanks!
