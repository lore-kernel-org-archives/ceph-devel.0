From: Tommi Virtanen <tv@inktank.com>
Subject: ioping: tool to monitor I/O latency in real time
Date: Tue, 10 Jul 2012 09:08:53 -0700
Message-ID: <CADvuQRExKeedqo9-GPynQ+cEF01+hoLeL1LYyBnScVxNp_gLCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:45982 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab2GJQJP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 12:09:15 -0400
Received: by gglu4 with SMTP id u4so160093ggl.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 09:09:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. I stumbled on this over the weekend, and thought people here might
be interested in seeing whether it's useful in figuring out things
like btrfs health:

http://code.google.com/p/ioping/
