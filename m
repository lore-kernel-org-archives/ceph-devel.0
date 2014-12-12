From: Joe Landman <joe.landman@gmail.com>
Subject: Re: crush: straw is dead, long live straw2
Date: Fri, 12 Dec 2014 11:39:08 -0500
Message-ID: <548B1A2C.2050605@gmail.com>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net> <20141212091408.GN4150@thinkpad.thebehrens.net> <alpine.DEB.2.00.1412120644340.23559@cobra.newdream.net> <548B0C16.4000509@gmail.com> <alpine.DEB.2.00.1412120814050.23559@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:50468 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666AbaLLQjL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 11:39:11 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so1745318igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Dec 2014 08:39:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412120814050.23559@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Thorsten Behrens <tbehrens@suse.com>, ceph-devel@vger.kernel.org

On 12/12/2014 11:20 AM, Sage Weil wrote:
>
> We can't use floating point. The code needs to run in the kernel.  We also
> need the rseults to be perfectly deterministic and consistent across all
> architectures; I'm not sure if all floating point implementations (and log
> implementations) will do that?

Nope ... that is a whole different subject.  Ok, why not start looking 
at what some of the GFX folks do?

https://graphics.stanford.edu/~seander/bithacks.html#IntegerLog


