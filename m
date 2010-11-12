From: Wido den Hollander <wido@widodh.nl>
Subject: Re: claims to be ... - wrong node!
Date: Fri, 12 Nov 2010 13:51:06 +0100
Message-ID: <1289566266.4894.3.camel@wido-desktop>
References: <AANLkTikN49QYMDw4WhatqtcQjBn_8cFsDfm+VPjyud0x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54665 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab0KLMvJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Nov 2010 07:51:09 -0500
In-Reply-To: <AANLkTikN49QYMDw4WhatqtcQjBn_8cFsDfm+VPjyud0x@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Hi Christian,

From what I know, the OSD which is giving this messages sees his
connection/session was lost, since the other OSD has been restarted.

These messages are harmless, they only notify you a OSD has been
restarted/changed, but you already knew that since you restarted it.

10.255.0.60:6802/17175 is the local OSD on port 6802 with PID 17175,
where 10.255.0.60:6800/15859 is the old connection to a OSD on port 6800
with PID 15859, but after it's restart it got PID 17108, a few seconds
later you OSD notices this and prints:

"presumably this is the same node!"

If these messages start to appear when you did not restart anything,
something went wrong.

Correct me if I'm wrong, but that's what I know about it.

Wido

On Fri, 2010-11-12 at 10:27 +0100, Christian Brunner wrote:
> Presumably I'm doing something wrong here, but I don't have clue what to...
> 
> After restarting one of our osd-servers I get the following messages
> in the cosd-log:
> 
> 2010-11-12 10:24:31.965058 7f5bac380710 -- 10.255.0.60:6802/17175 >>
> 10.255.0.60:6800/15859 pipe(0x7f5b98089300 sd=26 pgs=0 cs=0
> l=0).connect claims to be 0.0.0.0:6800/17108 not
> 10.255.0.60:6800/15859 - wrong node!
> 2010-11-12 10:24:32.489423 7f5b955ea710 -- 10.255.0.60:6803/17175 >>
> 10.255.0.60:6801/17108 pipe(0x7f5b98000d40 sd=30 pgs=0 cs=0
> l=0).connect claims to be 0.0.0.0:6801/17108 not
> 10.255.0.60:6801/17108 - presumably this is the same node!
> 
> The wrong node message is repeated a vew more times.
> 
> After this every write to the osd seems to block. What is the right
> way to handle this?
> 
> Thanks,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

