From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: Large numbers of OSD per node
Date: Tue, 06 Nov 2012 12:05:14 +0100
Message-ID: <5098EEEA.405@unilogicnetworks.net>
References: <5097676B.5020200@gmail.com> <50979CA3.3060005@widodh.nl> <5097B4E5.8070706@inktank.com> <5098706A.9040506@gmail.com> <5098D3E8.9000503@widodh.nl> <CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com> <5098DC78.1040303@widodh.nl> <CAJH6TXi4r1d+c16fH0CQk1mDbd2zjdpzFqf1--mKCGo+nnySbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out118.unilogicnetworks.net ([62.133.206.118]:50030 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751328Ab2KFLh0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 06:37:26 -0500
In-Reply-To: <CAJH6TXi4r1d+c16fH0CQk1mDbd2zjdpzFqf1--mKCGo+nnySbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com

On 11/06/2012 11:24 AM, Gandalf Corvotempesta wrote:
> 2012/11/6 Wido den Hollander <wido@widodh.nl>:
>> The setup described on that page has 90 nodes, so one node failing is a
>> little over 1% of the cluster which fails.
> I think i'm missing something.
> In case of a failure, they will always have to resync 36 TB of data,
> no matter if they have 90 servers.
> Each server is 36TB, so every times they  need to resync the whole server.
>
Well you have to keep in mind that when a node fails the PG's that 
resided on that node have to be redistributed over all the other nodes. 
So you begin moving about 1% of the data between all the remaining 
nodes/osds (coming from an OSD that has the remaining replica of the pg 
to the new OSD that will get a replica). So you move from and to all the 
remaining osd's and that will give you a lot of bandwidth and therefor 
fast recorvery to a consistent state.

Stefan
