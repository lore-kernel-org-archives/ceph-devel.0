From: Christian Brunner <chb@muc.de>
Subject: claims to be ... - wrong node!
Date: Fri, 12 Nov 2010 10:27:49 +0100
Message-ID: <AANLkTikN49QYMDw4WhatqtcQjBn_8cFsDfm+VPjyud0x@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60573 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab0KLJ1u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Nov 2010 04:27:50 -0500
Received: by iwn10 with SMTP id 10so3270037iwn.19
        for <ceph-devel@vger.kernel.org>; Fri, 12 Nov 2010 01:27:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Presumably I'm doing something wrong here, but I don't have clue what to...

After restarting one of our osd-servers I get the following messages
in the cosd-log:

2010-11-12 10:24:31.965058 7f5bac380710 -- 10.255.0.60:6802/17175 >>
10.255.0.60:6800/15859 pipe(0x7f5b98089300 sd=26 pgs=0 cs=0
l=0).connect claims to be 0.0.0.0:6800/17108 not
10.255.0.60:6800/15859 - wrong node!
2010-11-12 10:24:32.489423 7f5b955ea710 -- 10.255.0.60:6803/17175 >>
10.255.0.60:6801/17108 pipe(0x7f5b98000d40 sd=30 pgs=0 cs=0
l=0).connect claims to be 0.0.0.0:6801/17108 not
10.255.0.60:6801/17108 - presumably this is the same node!

The wrong node message is repeated a vew more times.

After this every write to the osd seems to block. What is the right
way to handle this?

Thanks,
Christian
