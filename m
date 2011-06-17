From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Cluster expansion : adding monitor
Date: Fri, 17 Jun 2011 14:49:28 -0700
Message-ID: <06D7760D-C3B5-47F4-A2A1-6438F42606D5@dreamhost.com>
References: <BANLkTi=fZuWfzHQe+TptCaotOrXPWkf-QQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49260 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1FQVt3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2011 17:49:29 -0400
In-Reply-To: <BANLkTi=fZuWfzHQe+TptCaotOrXPWkf-QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Cc: ceph-devel@vger.kernel.org

You just want to copy the monitor's data dir (in your case, /data/mon$id). It looks like when somebody wrote the wiki they used their own data dir, perhaps they didn't make that clear enough. Feel free to update it with better wording! :)
-Greg

On Jun 17, 2011, at 2:13 PM, Wilfrid Allembrand wrote:

> Hi,
> 
> I'm still doing some tests and wanted to test reinstallation of a
> monitor on a previously crashed machine.
> After OS and ceph reinstallation, I then follow the wiki
> (http://ceph.newdream.net/wiki/Monitor_cluster_expansion) but I have a
> problem for step 2) :
> 
> 
> 2) Copy the mon data from an existing, online monitor.
> alpha$ rsync -av /srv/ceph/mon.alpha/ beta:/srv/ceph/mon.beta
> 
> On all my existing and online monitors, I don't have a /srv/ceph/
> directory. Ceph version is 0.29.1 on Ubuntu 11.04 server 64.
> Is the wiki page obsolete for newer ceph versions ?
> 
> Extract from my ceph.conf :
> 
> [global]
>    user = root
>    log file = /var/log/ceph/$name.log
>    pid file = /var/run/ceph/$name.pid
> 
> [mon]
>        mon data = /data/mon$id
>        ; some minimal logging (just message traffic) to aid debugging
>        debug ms = 1
> 
> [mon.1]
>        host = test2
>        mon addr = 10.1.56.232:6789
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

