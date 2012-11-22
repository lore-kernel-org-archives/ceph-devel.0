From: Andrey Korolyov <andrey@xdel.ru>
Subject: Hangup during scrubbing - possible solutions
Date: Thu, 22 Nov 2012 19:36:27 +0300
Message-ID: <CABYiri-YGDCCzVD2kcJeZQy4ggWBDt0cC8TrHQxTp4tOeabQew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38822 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab2KVTMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:12:06 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8353512obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 11:12:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

In the recent versions Ceph introduces some unexpected behavior for
the permanent connections (VM or kernel clients) - after crash
recovery, I/O will hang on the next planned scrub on the following
scenario:

- launch a bunch of clients doing non-intensive writes,
- lose one or more osd, mark them down, wait for recovery completion,
- do a slow scrub, e.g. scrubbing one osd per 5m, inside bash script,
or wait for ceph to do the same,
- observe a raising number of pgs stuck in the active+clean+scrubbing
state (they took a master role from ones which was on killed osd and
almost surely they are being written in time of crash),
- some time later, clients will hang hardly and ceph log introduce
stuck(old) I/O requests.

The only one way to return clients back without losing their I/O state
is per-osd restart, which also will help to get rid of
active+clean+scrubbing pgs.

First of all, I`ll be happy to help to solve this problem by providing
logs. Second question is not directly related to this problem, but I
have thought on for a long time - is there a planned features to
control scrub process more precisely, e.g. pg scrub rate or scheduled
scrub, instead of current set of timeouts which of course not very
predictable on when to run?

Thanks!
