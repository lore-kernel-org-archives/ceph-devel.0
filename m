From: Sage Weil <sage@inktank.com>
Subject: Re: Any API to get metadata?
Date: Wed, 26 Dec 2012 08:46:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212260845170.32156@cobra.newdream.net>
References: <000101cde36f$66d36f20$347a4d60$@com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56535 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab2LZQqo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Dec 2012 11:46:44 -0500
In-Reply-To: <000101cde36f$66d36f20$347a4d60$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lollipop <lollipop_jin@126.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 26 Dec 2012, lollipop wrote:
> hello,there.
> I am wondering if there is any API to get the metadata of a file .
> I have the ceph file system run by mounting it to the /mnt/ceph
> I want to know how many chunks the file has been parted,and where the chunks
> have been stored.
> Is there any API I can use to get the information?
> Thank you very much!

This is available via an ioctl on the mounted file system (see 
linux.git/include/linux/ceph/ioctl.h) or via libcephfs 
(see ceph.git/src/include/cephfs/libcephfs.h):

/* expose file layout */
int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int fh);
int ceph_get_file_pool(struct ceph_mount_info *cmount, int fh);
int ceph_get_file_replication(struct ceph_mount_info *cmount, int fh);
int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int fd, loff_t offset,
				 struct sockaddr_storage *addr, int naddr);

sage
