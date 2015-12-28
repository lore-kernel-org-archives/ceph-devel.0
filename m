From: Sage Weil <sweil@redhat.com>
Subject: Re: How to configure if there are tow network cards in Client
Date: Mon, 28 Dec 2015 08:47:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512280846380.14656@cobra.newdream.net>
References: <57b6c7ee.cffc.151d9741bd2.Coremail.cymengxiang@126.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbbL1Qru (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Dec 2015 11:47:50 -0500
In-Reply-To: <57b6c7ee.cffc.151d9741bd2.Coremail.cymengxiang@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-2022-JP?Q?=1B$Bhq5#=1B=28J?= <cymengxiang@126.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-cn@lists.ceph.com

On Fri, 25 Dec 2015, ?? wrote:
> Hi all,
>     When we read the code, we haven?t find the function that the client can bind a specific IP. In Ceph?s configuration, we could only find the parameter ?public network?, but it seems acts on the OSD but not the client.
>     There is a scenario that the client has two network cards named NIC1 and NIC2. The NIC1 is responsible for communicating with cluster (monitor and RADOS) and the NIC2 has other services except Ceph?s client. So   we need the client can bind specific IP in order to differentiate the IP communicating with cluster from another IP serving other applications. We want to know is there any configuration in Ceph to achieve this function? If there is, how could we configure the IP? if not, could we add this function in Ceph? Thank you so much.

Right.  There isn't a configurable to do this now--we've always just let 
the kernel network layer sort it out. Is this just a matter of calling 
bind on the socket before connecting? I've never done this before..

sage
