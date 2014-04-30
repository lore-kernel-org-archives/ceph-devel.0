From: Thorwald Lundqvist <thorwald@jumpstarter.io>
Subject: Fwd: Kernel-client crash when adding OSDs
Date: Wed, 30 Apr 2014 16:16:06 +0200
Message-ID: <CAPZO0-OGSB==YAPejRPYX_PEAWTADKcrvj1j_JbLnnkSPKP8og@mail.gmail.com>
References: <CAPZO0-PHskHZD+ToWxC6tuor3wN5=-dDhdv3Q-ZfjzBx1uyGmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:54507 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759018AbaD3OQI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Apr 2014 10:16:08 -0400
Received: by mail-la0-f43.google.com with SMTP id c6so1301419lan.30
        for <ceph-devel@vger.kernel.org>; Wed, 30 Apr 2014 07:16:06 -0700 (PDT)
In-Reply-To: <CAPZO0-PHskHZD+ToWxC6tuor3wN5=-dDhdv3Q-ZfjzBx1uyGmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

A few days ago I added a bunch of new OSDs to hour production servers,
we have 3 hosts that maps and unmaps hundreds of RBD devices every
day. with aprox 100 RBD devs mapped at each host at any given time.

Adding OSDs is usually quite smooth if you do it the right way. I
usually follow the Manual adding/remove of osd as explained in the
documentation. Except when it comes to the crush add, i prefer
decompiling and compiling my own crush map.

So I preceded as usuall, prepared the OSD disks, keyring and so on,
and then I started up 4 new ceph-osd (osd.{9,10,11,12}) on the new OSD
host. BAM; a host that had a bunch of RBD devs mapped crashed and
rebooted with this in the log: http://pastebin.com/YKJSdWLv

I realise that this is not much to go on since there's no stack trace
or anything, but if anyone can help me reproduce this, I'd be
grateful. And if anyone had the same issue would really like to hear
from them too.

I'm running Linux 3.14.1 and ceph 0.72.2.

Thank you for your time,
Thorwald Lundqvist.
Jumpstarter AB
