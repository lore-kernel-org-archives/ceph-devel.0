From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: Test infrastructure: 2 or more servers?
Date: Tue, 15 Jan 2013 15:30:47 -0700
Message-ID: <50F5D897.9080307@cs.utah.edu>
References: <CAJH6TXhBucB2t-ZRmXf5bCZyNaTRJoSHZhoJ9hsW8mR7NxhWnA@mail.gmail.com> <50F5D24B.70308@cs.utah.edu> <CAJH6TXjAv4mVBkcYbWg0u_CPmfkf8UEwXKTkrvST32B6u+Jg2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:36821 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab3AOWas (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 17:30:48 -0500
In-Reply-To: <CAJH6TXjAv4mVBkcYbWg0u_CPmfkf8UEwXKTkrvST32B6u+Jg2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

It seems to be: Ceph will shuffle data to rebalance in situations such 
as when we change the replica num or when some nodes or disks are down.

Xing

On 01/15/2013 03:26 PM, Gandalf Corvotempesta wrote:
> So it's absolutely safe to start with just 2 server, make all the
> necessary tests and when ready to go in production, increase the
> servers and replicas?

