From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: Can we have mutiple OSD in a single machine
Date: Wed, 11 Apr 2012 16:33:18 +0200
Message-ID: <4F85962E.8040405@unilogicnetworks.net>
References: <loom.20120411T093935-734@post.gmane.org> <4F853882.8010001@unilogicnetworks.net> <loom.20120411T143907-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:56609 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760151Ab2DKOdU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Apr 2012 10:33:20 -0400
In-Reply-To: <loom.20120411T143907-211@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hello,

You will get something like this:

[osd.0]
         host = ceph-node-1
         btrfs devs = /dev/sda6

[osd.1]
         host = ceph-node-1
         btrfs devs = /dev/sda7

[osd.2]
         host = ceph-node-1
         btrfs devs = /dev/sda8

[osd.3]
         host = ceph-node-1
         btrfs devs = /dev/sda9


[osd.4]
         host = ceph-node-2
         btrfs devs = /dev/sda6

[osd.5]
         host = ceph-node-2
         btrfs devs = /dev/sda7

etc...

But as Tomasz mentions, you get no extra performance, because in most cases the disk is the bottleneck.

Besides I recommend to not use btrfs devs anymore, they want to deprecate that option. So you only get the "osd data =<directory>" option.

If you really want to add performance use more disks or use a fast journal device (I use a SSD).

Stefan




On 04/11/2012 02:42 PM, Madhusudhana U wrote:
> Stefan Kleijkers<stefan<at>  unilogicnetworks.net>  writes:
>
>> Hello,
>>
>> Yes that's no problem. I'm using that configuration for some time now.
>> Just generate a config with multiple OSD clauses with the same node/host.
>>
>> With the newer ceph version mkcephfs is smart enough to detect the osd's
>> on the same node and will generate a crushmap whereby the objects get
>> replicated to different nodes.
>>
>> I didn't see any impact on the performance (if you have enough
>> processing power, because you need more of that).
>>
>> I wanted to use just a few OSD's per node with mdraid, so I could use
>> RAID6. This way I could swap a faulty disk without bringing the node
>> down. But I couldn't get it stable with mdraid.
>>
> This is how my OSD part in ceph.conf looks like
>
> [osd.0]
>          host = ceph-node-1
>          btrfs devs = /dev/sda6
>
> [osd.1]
>          host = ceph-node-2
>          btrfs devs = /dev/sda6
>
> [osd.2]
>          host = ceph-node-3
>          btrfs devs = /dev/sda6
>
> [osd.3]
>          host = ceph-node-4
>          btrfs devs = /dev/sda6
>
>
>
> Can you please help me how I can add multiple OSD in the same machine
> considering that i have 4 partition created for OSD ?
>
> I have powerful machines having 6 quad core Intel Xeon with 48G of RAM
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

