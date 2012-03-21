From: "Plaetinck, Dieter" <dieter@vimeo.com>
Subject: platform requirements / centos 6.2
Date: Wed, 21 Mar 2012 12:16:19 +0100
Message-ID: <20120321121619.4bca22b4@dieter-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ny-iacmail.iac.com ([63.119.10.45]:25245 "EHLO
	ny-iacmail.iac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab2CULXk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 07:23:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
Ceph/Rados looks very well designed and engineered.
I would like to build a cluster to test the rados distributed object storage (not the distributed FS or block devices)
I've seen the list of dependencies on the wiki, but it doesn't mention specific versions for the libraries and tools, nor lists anything about the Linux kernel version.

Btrfs is getting updates every kernel release, so the sane thing would probably be using the most recent kernel possible (3.3, released a few days ago even has more btrfs improvements)
However, we prefer using Centos 6.2, which uses Linux 2.6.32, and since we don't need the snapshotting feature, I would opt for xfs instead of btrfs.  AFAICT btrfs is only recommended if you want snapshots.

Does this seem like a good plan?  Or would this platform be too outdated?  What are the required or recommended versions of the dependencies?
(for example, in centos 6.2 libuuid is at 2.17.2, libedit 2.11)
Anyone else running on centos 6.2?


Thanks guys,
Dieter

PS: links to http://ceph.newdream.net/docs/master/ and
http://ceph.newdream.net/wiki/ from the menu on the homepage would be useful.
