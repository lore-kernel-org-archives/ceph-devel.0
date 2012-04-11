From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: Can we have mutiple OSD in a single machine
Date: Wed, 11 Apr 2012 09:53:38 +0200
Message-ID: <4F853882.8010001@unilogicnetworks.net>
References: <loom.20120411T093935-734@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:52450 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753619Ab2DKHxk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Apr 2012 03:53:40 -0400
In-Reply-To: <loom.20120411T093935-734@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hello,

Yes that's no problem. I'm using that configuration for some time now. 
Just generate a config with multiple OSD clauses with the same node/host.

With the newer ceph version mkcephfs is smart enough to detect the osd's 
on the same node and will generate a crushmap whereby the objects get 
replicated to different nodes.

I didn't see any impact on the performance (if you have enough 
processing power, because you need more of that).

I wanted to use just a few OSD's per node with mdraid, so I could use 
RAID6. This way I could swap a faulty disk without bringing the node 
down. But I couldn't get it stable with mdraid.

Stefan

On 04/11/2012 09:42 AM, Madhusudhana U wrote:
> Hi all,
> I have a system with 2T SATA drive and I want to add it to my ceph
> cluster. I was thinking instead of creating one large OSD, can't
> I have 44 osd's of 450G each ? Is this possible ? if possible, will
> this improve read/write performance ?
>
> Thanks
> __Madhusudhana
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

