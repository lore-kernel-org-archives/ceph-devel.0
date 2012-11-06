From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Large numbers of OSD per node
Date: Tue, 6 Nov 2012 12:31:29 +0100
Message-ID: <CAJH6TXgHs7BVAwrkE0tRvxAq_LgFuHJ0PGb085ErQ=N8FSKoKw@mail.gmail.com>
References: <5097676B.5020200@gmail.com>
	<50979CA3.3060005@widodh.nl>
	<5097B4E5.8070706@inktank.com>
	<5098706A.9040506@gmail.com>
	<5098D3E8.9000503@widodh.nl>
	<CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com>
	<5098DC78.1040303@widodh.nl>
	<CAJH6TXi4r1d+c16fH0CQk1mDbd2zjdpzFqf1--mKCGo+nnySbw@mail.gmail.com>
	<5098EEEA.405@unilogicnetworks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61659 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab2KFLba (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 06:31:30 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so180317eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 03:31:29 -0800 (PST)
In-Reply-To: <5098EEEA.405@unilogicnetworks.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kleijkers <stefan@unilogicnetworks.net>
Cc: Wido den Hollander <wido@widodh.nl>, Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com

2012/11/6 Stefan Kleijkers <stefan@unilogicnetworks.net>:
> Well you have to keep in mind that when a node fails the PG's that resided
> on that node have to be redistributed over all the other nodes. So you begin
> moving about 1% of the data between all the remaining nodes/osds (coming
> from an OSD that has the remaining replica of the pg to the new OSD that
> will get a replica). So you move from and to all the remaining osd's and
> that will give you a lot of bandwidth and therefor fast recorvery to a
> consistent state.

Ok, but in this case, 1% is still 36TB of data.
There are no difference between 3 nodes with 36TB of data each or 90
nodes with 36TB of data each.
In case of a node failure, you always have to move 36TB of data, no
matter on how many nodes do you have.
