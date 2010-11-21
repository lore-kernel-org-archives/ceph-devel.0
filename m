From: Ravi Pinjala <pstatic@gmail.com>
Subject: persistent background write activity
Date: Sun, 21 Nov 2010 13:14:23 -0800
Message-ID: <AANLkTinWULKcXLmkyqtVc2T38OTh7ZTWOhYa1hfm==By@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49711 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0KUVOZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Nov 2010 16:14:25 -0500
Received: by bwz15 with SMTP id 15so5542113bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Nov 2010 13:14:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Watching my cluster nodes with gkrellm, it seems like there's some
inexplicable background write activity going on at a rate of about 1-4
MB/s. As far as I can tell, this starts any time there's disk activity
(even if there's very little activity), and continues for a minute or
so after. Does anybody know what this could be? I'm actually starting
to worry about the life of my disks, since they're constantly writing
when they should otherwise be idling.
