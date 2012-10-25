From: Sage Weil <sage@inktank.com>
Subject: Re: Can't copy folder with data to ceph storage.
Date: Thu, 25 Oct 2012 08:32:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210250831530.25762@cobra.newdream.net>
References: <5088DB0A.4040704@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59165 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759553Ab2JYPcO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 11:32:14 -0400
In-Reply-To: <5088DB0A.4040704@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 25 Oct 2012, Roman Alekseev wrote:
> Hi,
> 
> I've  simple  installation of ceph on Debian server with the
> following configuration:
> ************************
> [global]
>      debug ms = 0
> [osd]
>      osd journal size = 1000
>      filestore xattr use omap = true
> 
> [mon.a]
> 
>      host = serv1
>      mon addr = 192.168.0.10:6789
> 
> [osd.0]
>       host = serv1
> 
> [mds.a]
>      host = serv1
> ************************
> 
> So, I've mounted ceph storage on another server (mount -t ceph
> 192.168.0.10:6789:/ /mnt/mycephfs2/)
> and begun copying process (size of folder is 1.9Gb) , this process has not
> been finished over 12 hours and I'm not able to kill this process at all, only
> way  to do that restart server.  Kindly help me to find the reason of this
> problem. Thanks.

What kernel version is the client running?  Does 'ceph health' report any 
problems?

sage

