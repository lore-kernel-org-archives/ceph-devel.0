From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Large numbers of OSD per node
Date: Tue, 6 Nov 2012 11:24:07 +0100
Message-ID: <CAJH6TXi4r1d+c16fH0CQk1mDbd2zjdpzFqf1--mKCGo+nnySbw@mail.gmail.com>
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
Received: from mail-ea0-f174.google.com ([209.85.215.174]:55555 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab2KFKYI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 05:24:08 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so103078eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 02:24:07 -0800 (PST)
In-Reply-To: <5098DC78.1040303@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com

2012/11/6 Wido den Hollander <wido@widodh.nl>:
> The setup described on that page has 90 nodes, so one node failing is a
> little over 1% of the cluster which fails.

I think i'm missing something.
In case of a failure, they will always have to resync 36 TB of data,
no matter if they have 90 servers.
Each server is 36TB, so every times they  need to resync the whole server.
