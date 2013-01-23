From: Wido den Hollander <wido@widodh.nl>
Subject: Re: MDS placement
Date: Wed, 23 Jan 2013 11:35:54 +0100
Message-ID: <50FFBD0A.2050300@widodh.nl>
References: <CAJH6TXhux_1-LMDrnUVZWFm2eUCkypwrh6_3czauCANE+RaC2g@mail.gmail.com> <50FF9A5F.4090801@widodh.nl> <CAJH6TXjdnrDYi0Zk+_OFSfLixCz4jsAE7X-0-SeyBiuNHtNXKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54810 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab3AWKf4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 05:35:56 -0500
In-Reply-To: <CAJH6TXjdnrDYi0Zk+_OFSfLixCz4jsAE7X-0-SeyBiuNHtNXKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/23/2013 10:44 AM, Gandalf Corvotempesta wrote:
> 2013/1/23 Wido den Hollander <wido@widodh.nl>:
>> It should be located in the public network since clients need to be able to
>> interact with it.
>
> Ok.
> Cluster network is only needed by OSDs ? No other devices should be
> able to access it ?
>

Indeed. The "cluster network" is only used by the OSDs for their 
replication and heartbeat traffic.

No other daemon or client needs access to it.

Wido
