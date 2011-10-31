From: sheng qiu <herbert1984106@gmail.com>
Subject: profiling ceph
Date: Sun, 30 Oct 2011 22:40:26 -0500
Message-ID: <CAB7xdik94Dc5C=PGaiknk-9fVDGJ35hTUfsoeOdCt+G5_oAXuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51637 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab1JaDk1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Oct 2011 23:40:27 -0400
Received: by iaby12 with SMTP id y12so6708672iab.19
        for <ceph-devel@vger.kernel.org>; Sun, 30 Oct 2011 20:40:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,

is there any way to see how much time spend on each part of ceph when
running it. i just want to see which part of ceph codes spend more
time or have larger cost.
i tried to config ceph adding -pg, but when i use gprof command, it
said no gmon.out.
i also checked the ceph wiki, the profiling on cpu part do get an
output on time cost. but it does not show details on ceph (how much
time spend on each part).

Thanks,
Sheng

-- 
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
