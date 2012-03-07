From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Performance test on Ceph cluster
Date: Wed, 07 Mar 2012 12:31:09 +0100
Message-ID: <4F5746FD.6090508@widodh.nl>
References: <loom.20120222T102830-526@post.gmane.org> <loom.20120224T062854-915@post.gmane.org> <CAORUGqCJY3Q8uDJLoTeoHPiu9_YpOmE07_ivp28z4L9u0ieRxg@mail.gmail.com> <4352803.opIYE8Xzll@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:49704 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2CGLbM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Mar 2012 06:31:12 -0500
In-Reply-To: <4352803.opIYE8Xzll@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 03/07/2012 12:23 PM, Guido Winkelmann wrote:
> Am Freitag, 24. Februar 2012, 10:51:10 schrieb Tommi Virtanen:
>> On Fri, Feb 24, 2012 at 00:58, madhusudhana
>> <madhusudhana.u.acharya@gmail.com>  wrote:
>>> 4. If you don't mind, can you please give me a bit of insight on cluster
>>> network, what it is and how i can configure one for my ceph cluster ?
>>> Will there be a significant performance improvement with this ?
>>
>> When a client submits a write to Ceph, it needs to be replicated
>> (usually to two replicas). If all the ceph servers have two network
>> interfaces, and you have two separate networks you connect the servers
>> to, you can make the replication traffic go over the second interface,
>> and thus you'll have more available bandwidth between the cluster and
>> the clients in the first one.
>
> That sounds really interesting, any pointers on how that can be configured?

You should take a look at:

* public_addr
* cluster_addr
* public_network
* cluster_network

(From: src/common/config_opts.h)

[osd]
   cluster network = 192.168.0.0/16
   public network = 172.16.0.0/16

[osd.1]
   cluster addr = 192.168.0.1
   public addr = 172.16.0.1

I haven't played with those options, but that should do it (I think)

Wido

>
> As far as I can see, this is going to me I will have to assign to IP addresses
> to each node, one for internal traffic, one for external...
>
> Regards,
> 	Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

