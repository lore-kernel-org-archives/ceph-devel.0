From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: mds crash on snaptest-2
Date: Tue, 20 Jul 2010 16:50:11 +0200
Message-ID: <4C45B7A3.6030607@chaschperli.ch>
References: <i21p5k$fma$2@dough.gmane.org> <AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:49260 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652Ab0GTOuT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jul 2010 10:50:19 -0400
In-Reply-To: <AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org


Am Mon, 19 Jul 2010 14:16:14 -0700 schrieb Gregory Farnum:

> Can you turn on debugging and verify for me that it's crashing on
> "assert(p->second.first <= snapid && snapid <= p->first); "
> CInode::encode_inodestat:1617?
> I've hit this assert trying to reproduce your issue using cfuse and I
> think this is it, but I'm hitting some ext3 bugs in my kernel on a
> fairly regular basis while trying to reproduce, so a fix will need to
> wait until I've upgraded (tomorrow). :) Thanks!
> -Greg


i do start the daemons with vstart.sh - is that enough "turn on debugging"?

last 10 lines of all log files in src/log:

http://pastebin.com/VE05VXRF






