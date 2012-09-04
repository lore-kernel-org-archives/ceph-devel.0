From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Very unbalanced storage
Date: Tue, 4 Sep 2012 08:59:19 -0700
Message-ID: <CADvuQRGGE9hcqO+NevwTdj97hmUe2eCPCO6mBT5B-oon0zaODw@mail.gmail.com>
References: <50409BDC.5010006@gmail.com> <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net>
 <5041785E.3040707@gmail.com> <alpine.DEB.2.00.1208312000160.27708@cobra.newdream.net>
 <5041B204.7000008@aktzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:50330 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085Ab2IDP7k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 11:59:40 -0400
Received: by ghrr11 with SMTP id r11so1260952ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 08:59:40 -0700 (PDT)
In-Reply-To: <5041B204.7000008@aktzero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 31, 2012 at 11:58 PM, Andrew Thompson <andrewkt@aktzero.com> wrote:
> Looking at old archives, I found this thread which shows that to mount a
> pool as cephfs, it needs to be added to mds:
>
> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/5685
>
> I started a `rados cppool data tempstore` a couple hours ago. When it
> finishes, will I need to remove the current pool from mds somehow(other than
> just deleting the pool)?
>
> Is `ceph mds add_data_pool <poolname>` still required? (It's not listed in
> `ceph --help`.)

If the pool you are trying to grow pg_num for really is a CephFS data
pool, I fear a "rados cppool" is nowhere near enough to perform a
migration. My understanding is that each of the inodes stored in
cephfs/on ceph-mds'es knows what pool the file data resides in; you
shoveling the objects into another pool with "rados cppool" doesn't
change these pointers, removing the old pool will just break the
filesystem.

Before we go too far down this road: is your problem pool *really*
being use as a cephfs data pool? Based on how it's not named "data"
and you're just now asking about "ceph mds add_data_pool", it seems
that's not likely..
