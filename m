From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Auto-striping feature
Date: Tue, 25 Jan 2011 16:15:09 -0800
Message-ID: <AANLkTinw9OZprRD8XoK9rjBm5Q_5aez8n-ZK75+hihYo@mail.gmail.com>
References: <1408EC05-75B0-4DD8-B6D6-7F5D10AAC096@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58786 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1AZAPL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 19:15:11 -0500
Received: by eye27 with SMTP id 27so248759eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 16:15:09 -0800 (PST)
In-Reply-To: <1408EC05-75B0-4DD8-B6D6-7F5D10AAC096@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tatsuya Kawano <tatsuya6502@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 25, 2011 at 3:53 AM, Tatsuya Kawano <tatsuya6502@gmail.com> wrote:
>
> Hi,
>
> I have some questions about auto-striping feature in Ceph.
>
> - What is the default striping size?
The default is to stripe the file across 4MB objects, 4MB at a time.
You can also define your own striping strategy using cephfs. Make sure
that "stripe_unit" * "stripe_count" equals "object_size".

> - How can I specify the striping size for a specific file (via libceph and kernel driver)?
In the kernel, use the cephfs tool. It lets you use ioctls to specify
a single file layout or to define the default layout for newly created
files in a subtree of the fs. You can't do it in cfuse, unfortunately.
(Although you can set the default using the kernel client and cfuse
will follow that setting correctly.) If you're writing your own
application using libceph, you can also set it; use the cephfs source
as a model.

> - How many PGs will be involved on striping one file.
That depends on how large the file is, and is pseudorandom.
>
>
> I'm writing several files to Ceph and the size of each file will be about 64MB. There will be 10 to 20 OSDs in the cluster. I wonder how each file will be divided into objects and how these objects will be distributed in the cluster.
Well, the files will be divided into objects on 4MB blocks. (The last
block may be short.) The objects will be distributed pseudorandomly
into "placement groups" and those placement groups will be
pseudorandomly distributed across the OSDs in the cluster. If you're
interested in the specifics of how this works, I'd recommend reading
Sage's thesis, available on the Ceph website.
-Greg
