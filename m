From: Ravi Pinjala <pstatic@gmail.com>
Subject: log messages about inconsistent data
Date: Sun, 23 Jan 2011 23:18:06 -0800
Message-ID: <AANLkTin=qOdFjTWz8sMQ3hmUvwyrnmEd3_zo6LPbaK3r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38143 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab1AXHSI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jan 2011 02:18:08 -0500
Received: by bwz15 with SMTP id 15so3290668bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 23 Jan 2011 23:18:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Do I need to be worried about this?

2011-01-23 23:12:06.328866   log 2011-01-23 23:12:05.316993 osd1
192.168.1.11:6801/9447 45 : [ERR] 1.1 scrub osd0 missing
10000017737.00000000/head
2011-01-23 23:12:06.328866   log 2011-01-23 23:12:05.317429 osd1
192.168.1.11:6801/9447 46 : [ERR] 1.1 scrub stat mismatch, got 7/136
objects, 0/0 clones, 12356/8682277 bytes, 17/8550 kb.
2011-01-23 23:12:08.230768    pg v129643: 270 pgs: 262 active+clean, 8
active+clean+inconsistent; 877 GB data, 1707 GB used, 1320 GB / 3036
GB avail

I would expect ceph to fix the inconsistent PGs at this point, but it
just continues background scrubbing. Does inconsistent data get
cleaned up automatically from other replicas, or is there something
that I need to fix manually here?

--Ravi
