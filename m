From: Joe Landman <joe.landman@gmail.com>
Subject: Re: crush: straw is dead, long live straw2
Date: Fri, 12 Dec 2014 13:18:57 -0500
Message-ID: <548B3191.4040605@gmail.com>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net> <20141212091408.GN4150@thinkpad.thebehrens.net> <alpine.DEB.2.00.1412120644340.23559@cobra.newdream.net> <548B0C16.4000509@gmail.com> <alpine.DEB.2.00.1412120814050.23559@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53155 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031125AbaLLSTA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 13:19:00 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so7144285iec.25
        for <ceph-devel@vger.kernel.org>; Fri, 12 Dec 2014 10:18:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412120814050.23559@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Thorsten Behrens <tbehrens@suse.com>, ceph-devel@vger.kernel.org

On 12/12/2014 11:20 AM, Sage Weil wrote:

> We can't use floating point. The code needs to run in the kernel. We 
> also need the rseults to be perfectly deterministic and consistent 
> across all architectures; I'm not sure if all floating point 
> implementations (and log implementations) will do that? 

Have a look at this (using the code I pointed to before): 
https://gist.github.com/joelandman/ec6f3abef9bc5f1c7b0e

Running on my desktop box, library double function (with casts) is about 
3x slower than the local log_2 version.


