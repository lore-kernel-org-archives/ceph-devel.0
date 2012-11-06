From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Large numbers of OSD per node
Date: Tue, 06 Nov 2012 10:46:32 +0100
Message-ID: <5098DC78.1040303@widodh.nl>
References: <5097676B.5020200@gmail.com> <50979CA3.3060005@widodh.nl> <5097B4E5.8070706@inktank.com> <5098706A.9040506@gmail.com> <5098D3E8.9000503@widodh.nl> <CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:42302 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2KFJqd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 04:46:33 -0500
In-Reply-To: <CAJH6TXhscSv9-JpzP=+ZE421ojGh4NtgycNt929QVNXNwCmzMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Andrew Thrift <andyonfire@gmail.com>, ceph-devel@vger.kernel.org, mark.nelson@inktank.com



On 06-11-12 10:36, Gandalf Corvotempesta wrote:
> 2012/11/6 Wido den Hollander <wido@widodh.nl>:
>> You shouldn't only think about a complete failure solution. The distributed
>> architecture of Ceph also gives you the freedom to take out a node whenever
>> you want to do maintenance or just don't trust the node and you want to
>> investigate.
>>
>> The scenario is still the same. Use smaller nodes so taking out one node
>> (for what reason) doesn't impact your cluster that much.
>
> Here:
> http://ceph.com/docs/master/install/hardware-recommendations/
> is wrote that a production cluster has been made with many R515 with
> 12 disks of 3TB each. This give us 36TB of storage.
>
> is this configuration considered good ? I'm planning to have the same server.
> --

It works for them. There is no journaling though, but this setup is only 
being used for the RADOS Gateway, not for RBD.

You might want to insert a couple of SSDs in there to do journaling for you.

But the rule also applies here. When you use 3 of these machines, when 
loosing one, you will lose 33% of your cluster.

The setup described on that page has 90 nodes, so one node failing is a 
little over 1% of the cluster which fails.

Wido

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
