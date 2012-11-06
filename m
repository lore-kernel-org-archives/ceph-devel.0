From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Large numbers of OSD per node
Date: Tue, 6 Nov 2012 13:51:30 +0100
Message-ID: <CAJH6TXhw7RbbD-dRcJWhKW45QBW7wh-xZ5Or449Gg=c_+RVNSA@mail.gmail.com>
References: <5097676B.5020200@gmail.com>
	<50979CA3.3060005@widodh.nl>
	<5097B4E5.8070706@inktank.com>
	<5098706A.9040506@gmail.com>
	<5098D3E8.9000503@widodh.nl>
	<CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com>
	<5098DC78.1040303@widodh.nl>
	<CAJH6TXi4r1d+c16fH0CQk1mDbd2zjdpzFqf1--mKCGo+nnySbw@mail.gmail.com>
	<5098EEEA.405@unilogicnetworks.net>
	<CAJH6TXgHs7BVAwrkE0tRvxAq_LgFuHJ0PGb085ErQ=N8FSKoKw@mail.gmail.com>
	<5098F9AF.7070905@unilogicnetworks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:51173 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab2KFMvb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 07:51:31 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so156154eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 04:51:30 -0800 (PST)
In-Reply-To: <5098F9AF.7070905@unilogicnetworks.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kleijkers <stefan@unilogicnetworks.net>
Cc: Wido den Hollander <wido@widodh.nl>, Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com

2012/11/6 Stefan Kleijkers <stefan@unilogicnetworks.net>:
> True, but it's a huge difference if you have to redistribute the 36T between
> 2 remaining nodes or between 89 remaining nodes. And with such a few nodes
> you hit probably a couple of other bottlenecks like CPU power per node,
> networking bandwidth per node, etc... I have noticed this the hard way with
> 3 nodes and 24 disks/osds per node.

Ok, now it's clear.
In a 90 nodes cluster, 36TB will move 400GB for each node while in a
10 nodes cluster, the same 36TB will move 3.6TB for each node.
