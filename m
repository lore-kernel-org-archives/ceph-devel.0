From: Alex Sla <4k3nd0@gmail.com>
Subject: Mutiple network port for a single osd
Date: Wed, 6 Mar 2013 18:27:20 +0100
Message-ID: <CALLyzeYeMNwzn6osF8BbZ+qnbotCLCuxEn8vv9UNhPgnQaMktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:62447 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab3CFR1W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 12:27:22 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so5212752wgh.3
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 09:27:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello guys,

first of all, thank you for Ceph. Such an amazon technology. Great
pleasure to work with.

Then to my question. I review Ceph in scope of security and need to
understand how the single osd is create network port (for iptables).
But i just saw some interesting thing:

Some of my osds running on more then one port.

for example:

Ports:

tcp        0      0 172.20.21.2:6902        0.0.0.0:*
LISTEN      1635/ceph-osd
tcp        0      0 172.20.21.2:6903        0.0.0.0:*
LISTEN      1635/ceph-osd
tcp        0      0 172.20.21.2:6904        0.0.0.0:*
LISTEN      1635/ceph-osd

ps aux|grep 1635

root      1635  1.9  0.2 1239708 172556 ?      Ssl  Feb23 301:34
/usr/bin/ceph-osd --cluster=ceph -i 1 -f

But some doesn't have this much ports. Why do this happen ? More
important to know, up to how many port will be used? In overall it
looks only 3.


so far
4k3nd0
