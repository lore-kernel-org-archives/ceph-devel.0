From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: platform requirements / centos 6.2
Date: Wed, 21 Mar 2012 10:26:51 -0600
Message-ID: <4F6A014B.3050701@sandia.gov>
References: <20120321121619.4bca22b4@dieter-ws>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:47787 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758943Ab2CUQ1I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 12:27:08 -0400
In-Reply-To: <20120321121619.4bca22b4@dieter-ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Plaetinck, Dieter" <dieter@vimeo.com>
Cc: ceph-devel@vger.kernel.org

On 03/21/2012 05:16 AM, Plaetinck, Dieter wrote:
> Hello,
> Ceph/Rados looks very well designed and engineered.
> I would like to build a cluster to test the rados distributed object storage (not the distributed FS or block devices)
> I've seen the list of dependencies on the wiki, but it doesn't mention specific versions for the libraries and tools, nor lists anything about the Linux kernel version.
>

The ceph configure script is pretty good about checking for
minimum required versions of libs, etc.

> Btrfs is getting updates every kernel release, so the sane thing would probably be using the most recent kernel possible (3.3, released a few days ago even has more btrfs improvements)
> However, we prefer using Centos 6.2, which uses Linux 2.6.32, and since we don't need the snapshotting feature, I would opt for xfs instead of btrfs.  AFAICT btrfs is only recommended if you want snapshots.
>
> Does this seem like a good plan?  Or would this platform be too outdated?  What are the required or recommended versions of the dependencies?
> (for example, in centos 6.2 libuuid is at 2.17.2, libedit 2.11)
> Anyone else running on centos 6.2?

I have a ceph testbed running on RHEL 6.2 using kernel.org kernels.
I use both stable series kernels, and Linus's master branch (usually
after -rc3 or so on each new kernel).  Occasionally a new driver
version for my hardware wants a new firmware blob, which is easy
to get from the kernel.org linux-firmware tree.

-- Jim

>
>
> Thanks guys,
> Dieter
>
> PS: links to http://ceph.newdream.net/docs/master/ and
> http://ceph.newdream.net/wiki/ from the menu on the homepage would be useful.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


