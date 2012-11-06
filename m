From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Large numbers of OSD per node
Date: Tue, 6 Nov 2012 11:20:45 +0100
Message-ID: <CAJH6TXjSwz-7pJcYWtjureXY_rTNZ6JB+SAfZmye6L6=mxQAxw@mail.gmail.com>
References: <5097676B.5020200@gmail.com>
	<50979CA3.3060005@widodh.nl>
	<5097B4E5.8070706@inktank.com>
	<5098706A.9040506@gmail.com>
	<5098D3E8.9000503@widodh.nl>
	<CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com>
	<5098DC78.1040303@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:55455 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab2KFKUs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 05:20:48 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so101816eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 02:20:46 -0800 (PST)
In-Reply-To: <5098DC78.1040303@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com

2012/11/6 Wido den Hollander <wido@widodh.nl>:
> It works for them. There is no journaling though, but this setup is only
> being used for the RADOS Gateway, not for RBD.
>
> You might want to insert a couple of SSDs in there to do journaling for you.

Yes, I'll add 2 SSD on each server, probably in RAID1, because i'll
also install the OS on it.

> But the rule also applies here. When you use 3 of these machines, when
> loosing one, you will lose 33% of your cluster.
>
> The setup described on that page has 90 nodes, so one node failing is a
> little over 1% of the cluster which fails.

Actually I'll start with 2 or 3  3TB disks for each node and I'll have
3 nodes as testbed and 5 as production.
