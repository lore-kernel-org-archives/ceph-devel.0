From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: How to set MDS log size
Date: Wed, 11 Apr 2012 11:21:19 -0700
Message-ID: <4F85CB9F.5020201@dreamhost.com>
References: <loom.20120411T092920-80@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34512 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab2DKSVX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 14:21:23 -0400
In-Reply-To: <loom.20120411T092920-80@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 04/11/2012 12:33 AM, Madhusudhana U wrote:
> Hi all,
> In my MDS system of ceph cluster, my entire root partition is full bcz of
> one big mds log file
>
>
> [root@ceph-node-7 ceph]# du -sh *
> 0       mds.admin.log
> 27G     mds.ceph-node-7.log
>
> [root@ceph-node-7 ceph]# df -h
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/sda2              39G   39G     0 100% /
> tmpfs                  24G     0   24G   0% /dev/shm
> /dev/sda1             2.0G   76M  1.8G   5% /boot
> /dev/sda5              19G  409M   18G   3% /ceph
>
> How to set a max size for mds log ? does it auto rotate ? Bcz my root
> partition is full, will this affect read/write performance in
> my ceph cluster?

Ceph comes with a logrotate config, which should be in
/etc/logrotate.d/ceph on debian-based distros. If you changed the
location of the logs, you'll need to update the logrotate configuration
to match.

Josh
