From: Alyona Kiselyova <akiselyova@mirantis.com>
Subject: Tool for ceph performance analysis
Date: Tue, 24 Feb 2015 12:40:30 +0400
Message-ID: <CAONhiy7Bu1aqML80D_7Xu42qS1ZTSMwa_W3mZ+t4ivXdwE1szQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:43569 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbbBXIkb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 03:40:31 -0500
Received: by mail-qa0-f54.google.com with SMTP id x12so26089580qac.13
        for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2015 00:40:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

This topic was raised several times, but we since have no such thing.

We are interested in some tool, which allow us to collect all or any
counters from whole cluster. Now we have internal way to get counters
via admin socket, but we need to do it directly on each node or use
some external network commands.

There are similar message from Sage Weil in ceph-devel maillist some
weeks ago. It was about perf-watch.py script, which is available from
ceph repository, but it provides only per-node work too (and works on
vbstart cluster, so to use it on working system some changes must be
done).

We are working now on tool, which has similar possibilities, but it
can collect counters either from one node, or from all ceph nodes.
Also tool provide possibility to check system resources usage by ceph
processes.Now it uses ssh, so it doesn't work good, if you have no
password-less access to all nodes.

The first version of this tool is available on github
(https://github.com/Ved-vampir/ceph-perf-tool). May be, after
improvements, this tool will be useful for other people and it can
appear in ceph in some way. It would be cose, if such utility will be
in ceph "out of the box". May be, we can merge it?

It would be great, if there will be internal possibility to collect
info about whole cluster from one node. May be, something like
extension for "tell" command, which can call any node directly and
replace external network connections. Or improved version of "ceph osd
perf" command, which would allow to get more info.

-------------------------------
Best regards,
Alyona Kiseleva
