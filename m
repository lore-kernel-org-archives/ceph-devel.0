From: Christian Brunner <chb@muc.de>
Subject: Re: ceph and ext4
Date: Thu, 8 Dec 2011 23:59:29 +0100
Message-ID: <CAO47_-9vGg89HgxjT=dzSSsUxxdbZ=yJoYQk4Qge8WGPjeVmKw@mail.gmail.com>
References: <4EC10664.1080501@tuxadero.com>
	<CAO47_-9nfO32nwOAQMVdqw6iWGWK+FWb+MD=WeOz_vr4YrrKmw@mail.gmail.com>
	<20111115142246.GA7516@thunk.org>
	<246EA1CC-3C33-4D41-80C0-2331C426EBB0@whamcloud.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45313 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1LHW7a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 17:59:30 -0500
In-Reply-To: <246EA1CC-3C33-4D41-80C0-2331C426EBB0@whamcloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Dilger <adilger@whamcloud.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Jian Yu <yujian@whamcloud.com>

2011/11/15 Andreas Dilger <adilger@whamcloud.com>:
> Coincidentally, we have someone working in those patches again. The main obstacle for accepting the previous patch as-is was that Ted wanted to add support for "medium-sized" xattrs that are addressed as a string of blocks, instead of via an inode.
>
> This will allow xattrs up to 64kB in size (in total) to be stored as efficiently as an external xattr block.
>

Did you make progress with this. I'm still having serious trouble with
btrfs and would like to try these.

Thanks,
Christian
