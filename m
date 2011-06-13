From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: MDS configuration
Date: Sun, 12 Jun 2011 17:00:51 -0700
Message-ID: <73D7B453-4ADA-4D9C-A4C1-33AD725CFF9E@dreamhost.com>
References: <4DF266B9.3040407@ufm.su>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59546 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab1FMAAw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jun 2011 20:00:52 -0400
In-Reply-To: <4DF266B9.3040407@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

This depends very much on how many active files you have at once and how beefy your MDS machines are. By default the MDS will cache 100k dentries, and each dentry takes ~1KB of RAM. If you have sufficient RAM you can increase the size of the cache arbitrarily, though!

There's actually no required relationship between total filesystem size and MDS memory, though, since all the metadata is stored in on-disk objects. We haven't done serious memory profiling in a while, though, so there may be other constraints acting up that we're missing out on here.
-Greg

On Jun 10, 2011, at 11:47 AM, Fyodor Ustinov wrote:

> Hi!
> 
> Which configuration would you recommended for cluster with 50-80 million files?
> 
> WBR,
>    Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

