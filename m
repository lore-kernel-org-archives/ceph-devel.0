From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Re: Auto-striping feature
Date: Wed, 26 Jan 2011 20:56:13 +0900
Message-ID: <DE9C2852-6E7E-4CA8-80B7-356A774C0154@gmail.com>
References: <1408EC05-75B0-4DD8-B6D6-7F5D10AAC096@gmail.com> <AANLkTinw9OZprRD8XoK9rjBm5Q_5aez8n-ZK75+hihYo@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47420 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab1AZL5H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 06:57:07 -0500
Received: by iyj18 with SMTP id 18so281972iyj.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jan 2011 03:57:06 -0800 (PST)
In-Reply-To: <AANLkTinw9OZprRD8XoK9rjBm5Q_5aez8n-ZK75+hihYo@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks, Greg and Sage for the answers. I just started to read the Distributed Object Storage chapter of Sage's thesis as well.

--
Tatsuya Kawano (Mr.)
Tokyo, Japan


On Jan 26, 2011, at 9:15 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:

> On Tue, Jan 25, 2011 at 3:53 AM, Tatsuya Kawano <tatsuya6502@gmail.com> wrote:
>> 
>> Hi,
>> 
>> I have some questions about auto-striping feature in Ceph.
>> 
>> - What is the default striping size?
> The default is to stripe the file across 4MB objects, 4MB at a time.
> You can also define your own striping strategy using cephfs. Make sure
> that "stripe_unit" * "stripe_count" equals "object_size".
> 
>> - How can I specify the striping size for a specific file (via libceph and kernel driver)?
> In the kernel, use the cephfs tool. It lets you use ioctls to specify
> a single file layout or to define the default layout for newly created
> files in a subtree of the fs. You can't do it in cfuse, unfortunately.
> (Although you can set the default using the kernel client and cfuse
> will follow that setting correctly.) If you're writing your own
> application using libceph, you can also set it; use the cephfs source
> as a model.
> 
>> - How many PGs will be involved on striping one file.
> That depends on how large the file is, and is pseudorandom.
>> 
>> 
>> I'm writing several files to Ceph and the size of each file will be about 64MB. There will be 10 to 20 OSDs in the cluster. I wonder how each file will be divided into objects and how these objects will be distributed in the cluster.
> Well, the files will be divided into objects on 4MB blocks. (The last
> block may be short.) The objects will be distributed pseudorandomly
> into "placement groups" and those placement groups will be
> pseudorandomly distributed across the OSDs in the cluster. If you're
> interested in the specifics of how this works, I'd recommend reading
> Sage's thesis, available on the Ceph website.
> -Greg
