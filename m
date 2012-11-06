From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Large numbers of OSD per node
Date: Tue, 6 Nov 2012 10:36:32 +0100
Message-ID: <CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com>
References: <5097676B.5020200@gmail.com>
	<50979CA3.3060005@widodh.nl>
	<5097B4E5.8070706@inktank.com>
	<5098706A.9040506@gmail.com>
	<5098D3E8.9000503@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53899 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab2KFJgd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 04:36:33 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so119106eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 01:36:32 -0800 (PST)
In-Reply-To: <5098D3E8.9000503@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com

2012/11/6 Wido den Hollander <wido@widodh.nl>:
> You shouldn't only think about a complete failure solution. The distributed
> architecture of Ceph also gives you the freedom to take out a node whenever
> you want to do maintenance or just don't trust the node and you want to
> investigate.
>
> The scenario is still the same. Use smaller nodes so taking out one node
> (for what reason) doesn't impact your cluster that much.

Here:
http://ceph.com/docs/master/install/hardware-recommendations/
is wrote that a production cluster has been made with many R515 with
12 disks of 3TB each. This give us 36TB of storage.

is this configuration considered good ? I'm planning to have the same server.
