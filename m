From: Sage Weil <sage@newdream.net>
Subject: Re: kernel client debugging
Date: Fri, 4 Feb 2011 12:48:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102041245070.26364@cobra.newdream.net>
References: <AANLkTikp+VsT5Bbu8a2_Z4Crqnnwkawm7VDm8KPWVRYo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42683 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1BDUrp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Feb 2011 15:47:45 -0500
In-Reply-To: <AANLkTikp+VsT5Bbu8a2_Z4Crqnnwkawm7VDm8KPWVRYo@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

You need

CONFIG_DYNAMIC_DEBUG=y

Then, after you've loaded the module, you can manipulate which dout 
callsites are activated.  To turn it all on:

echo 'module ceph +p' > /sys/kernel/debug/dynamic_debug/control
echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control
echo 'module rbd +p' > /sys/kernel/debug/dynamic_debug/control

I usually turn down the messenger logging so that I only see messages 
coming in and going out:

echo 'file net/ceph/messenger.c -p' > /sys/kernel/debug/dynamic_debug/control
echo 'file' `grep -- --- /sys/kernel/debug/dynamic_debug/control | grep ceph \
	| awk '{print $1}' | sed 's/:/ line /'` '+p' > /sys/kernel/debug/dynamic_debug/control
echo 'file' `grep -- === /sys/kernel/debug/dynamic_debug/control | grep ceph \ 
	| awk '{print $1}' | sed 's/:/ line /'` '+p' > /sys/kernel/debug/dynamic_debug/control

In general, though, if you're hunting a specific bug you'll probably only 
enable the output for the file or functions or whatever you're interested 
in!

sage



On Fri, 4 Feb 2011, Brian Chrisman wrote:

> I'm looking to capture some of the douts from the kernel client.
> If someone can instruct me as to what kernel compile flags would be
> needed and which /proc or /sys files need to be twiddled, I'd
> appreciate it, use it, and document it on the wiki.
> 
> -Brian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
