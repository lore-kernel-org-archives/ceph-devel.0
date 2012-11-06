From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: Large numbers of OSD per node
Date: Tue, 06 Nov 2012 12:51:11 +0100
Message-ID: <5098F9AF.7070905@unilogicnetworks.net>
References: <5097676B.5020200@gmail.com> <50979CA3.3060005@widodh.nl> <5097B4E5.8070706@inktank.com> <5098706A.9040506@gmail.com> <5098D3E8.9000503@widodh.nl> <CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com> <5098DC78.1040303@widodh.nl> <CAJH6TXi4r1d+c16fH0CQk1mDbd2zjdpzFqf1--mKCGo+nnySbw@mail.gmail.com> <5098EEEA.405@unilogicnetworks.net> <CAJH6TXgHs7BVAwrkE0tRvxAq_LgFuHJ0PGb085ErQ=N8FSKoKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out118.unilogicnetworks.net ([62.133.206.118]:44507 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751396Ab2KFLvN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 06:51:13 -0500
In-Reply-To: <CAJH6TXgHs7BVAwrkE0tRvxAq_LgFuHJ0PGb085ErQ=N8FSKoKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com

On 11/06/2012 12:31 PM, Gandalf Corvotempesta wrote:
> 2012/11/6 Stefan Kleijkers <stefan@unilogicnetworks.net>:
>> Well you have to keep in mind that when a node fails the PG's that resided
>> on that node have to be redistributed over all the other nodes. So you begin
>> moving about 1% of the data between all the remaining nodes/osds (coming
>> from an OSD that has the remaining replica of the pg to the new OSD that
>> will get a replica). So you move from and to all the remaining osd's and
>> that will give you a lot of bandwidth and therefor fast recorvery to a
>> consistent state.
> Ok, but in this case, 1% is still 36TB of data.
> There are no difference between 3 nodes with 36TB of data each or 90
> nodes with 36TB of data each.
> In case of a node failure, you always have to move 36TB of data, no
> matter on how many nodes do you have.
>
True, but it's a huge difference if you have to redistribute the 36T 
between 2 remaining nodes or between 89 remaining nodes. And with such a 
few nodes you hit probably a couple of other bottlenecks like CPU power 
per node, networking bandwidth per node, etc... I have noticed this the 
hard way with 3 nodes and 24 disks/osds per node.

Stefan
