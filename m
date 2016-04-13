From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: rdb - RAW image snapshot protected failed
Date: Wed, 13 Apr 2016 12:35:24 +0530
Message-ID: <CANA9Uk5WTSm89xwpCQfLkeJbJ9_gJ0enOs0MTYGssOsPsaUE6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33984 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbcDMHFZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 03:05:25 -0400
Received: by mail-vk0-f50.google.com with SMTP id e185so57310813vkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 00:05:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hello,

have imported a RAW image to rbd 'images' pool and created a snapshot
from that image...when I tried to set the protected for this snapshot,
its failing with below error.

==
bd --pool images snap  protect   --snap snap
a88c6600-5781-475c-8806-9723a976425c rbd: protecting snap failed: (38)
 Function not implemented 2016-04-13 06:47:11.879706 7f9697d4f780 -1
librbd: snap_protect: image must  support layering
==


and an option to add as "--image-features layering", but its working
with RAW foramat images..

is there issue with RAW images?
How to set the features layering for RAW images?

Thanks
Swami
