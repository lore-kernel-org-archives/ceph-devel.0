From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Primary mds failure
Date: Wed, 27 Jul 2011 13:26:40 -0700
Message-ID: <CAJD3hpXvxQD94MO+RHrtXcHV5sFxXvarJdOxEs3o-U0NyD4eqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46515 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab1G0U0l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 16:26:41 -0400
Received: by yxi11 with SMTP id 11so1035320yxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 13:26:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi
   We are observing that when the primary mds goes away(say OOM killer
victim), the client keeps on trying (forever) to write to it(try_write
method in the messenger) and eventually results in filesystem hang. So
the question is :

 - Why does the kernel client attempt another mds?
 - Is replication (mds) guaranteed to take place before the primary
mds goes down? In other words, is replication done preemtively or due
to a trigger (scheduled or event based)?

thanks again
Jojy
