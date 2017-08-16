From: sheng qiu <herbert1984106@gmail.com>
Subject: assert in can_discard_replica_op
Date: Wed, 16 Aug 2017 08:42:05 +0800
Message-ID: <CAB7xdikmXB_r=YS_FSKe7yUrUpPBf6Eej5025rVYNeYgg-LciQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36096 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbdHPAmG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Aug 2017 20:42:06 -0400
Received: by mail-oi0-f51.google.com with SMTP id g131so22393786oic.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Aug 2017 17:42:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

recently, we got an assert in function can_discard_replica_op() when
osd is handling replica op reply. The assert is caused by
get_down_at() which checks if the source osd is still exists(),
otherwise it assert.

seems in our testing environment, the source osd send an op reply to
primary osd and then died.

My question should we first check exists() and avoid the assert happen
in get_down_at() or it's expected to be always exists() at this
situation.

Thanks,
Sheng
