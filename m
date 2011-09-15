From: Martin Mailand <martin@tuxadero.com>
Subject: Re: ceph kernel bug
Date: Thu, 15 Sep 2011 23:10:41 +0200
Message-ID: <4E7269D1.6010804@tuxadero.com>
References: <4E6BD2B4.7050709@tuxadero.com> <Pine.LNX.4.64.1109101546370.19147@cobra.newdream.net> <4E6BF6C3.5010202@tuxadero.com> <4E7254D6.9020509@tuxadero.com> <Pine.LNX.4.64.1109151302160.17623@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:35295 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934775Ab1IOVKw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 17:10:52 -0400
In-Reply-To: <Pine.LNX.4.64.1109151302160.17623@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
that's quite a bit of output, I put it in a pastebin. 
http://pastebin.com/9CNJk0Pw.

Best Regards,
  martin

Sage Weil schrieb:
> On Thu, 15 Sep 2011, Martin Mailand wrote:
>> Hi Sage,
>> I am still hitting this in -rc6. It happeneds every time I stop an OSD.
>> Do you need more information to reproduce it?
> 
> Oh, great to hear it's easy to reproduce!  I was trying (in my uml 
> environment) and failing.
> 
> Can run the script below right before stopping the osd, and send the dmesg 
> output along?  (Or attach to http://tracker.newdream.net/issues/1382)
> 
> Thanks!
> sage
> 
> 
> #!/bin/sh -x
> 
> p() {
>  echo "$*" > /sys/kernel/debug/dynamic_debug/control
> }
> 
> p 'module ceph +p'
> p 'module libceph +p'
> p 'module rbd +p'
> p 'file net/ceph/messenger.c -p'
> p 'file' `grep -- --- /sys/kernel/debug/dynamic_debug/control | grep ceph \
> 	| awk '{print $1}' | sed 's/:/ line /'` '+p'
> p 'file' `grep -- === /sys/kernel/debug/dynamic_debug/control | grep ceph \
> 	| awk '{print $1}' | sed 's/:/ line /'` '+p'
> 
