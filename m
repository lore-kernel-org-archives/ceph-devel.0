From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Thu, 19 Jul 2012 21:49:58 +0930
Message-ID: <5007FB6E.1080307@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:43148 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab2GSMUK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:20:10 -0400
In-Reply-To: <5006D5FB.8030700@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org


> Try to determine how much of the 200ms avg latency comes from osds vs
> the qemu block driver.
Look like that osd.0 performs with low latency but osd.1 latency is way 
too high and on average it appears as 200ms. osd is backed by btrfs over 
LVM2. May be issue lie in backing fs selection? All four osds running 
similar setup: btrfs over LVM2 so I have some doubts that it may be a 
reason as osd.0 performs well.

I have read full log between osd_op for 3670 and osd_reply and there's 
number of pings from other osds (which were responded to quickly) and 
good number of osd_op_reply writes (osd_sub_op for these writes came 10 
seconds before). So it appears 3670 was delayed by backlog of operations.
>
> Once the latency is under control, you might look into changing guest 
> settings to send larger requests and readahead more.
>
> Josh


