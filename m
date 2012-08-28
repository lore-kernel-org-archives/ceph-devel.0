From: Sage Weil <sage@inktank.com>
Subject: Re: mkcehfs: ** ERROR: error creating empty object store in /data/sd1:
 (2) No such file or directory
Date: Tue, 28 Aug 2012 10:14:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208281013360.25640@cobra.newdream.net>
References: <CAEj+kbmZs=x+8MVRwDs4PDbozFqSk+Qgd4EYEEe4HVQUYjxGLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55143 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2H1ROb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 13:14:31 -0400
In-Reply-To: <CAEj+kbmZs=x+8MVRwDs4PDbozFqSk+Qgd4EYEEe4HVQUYjxGLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Flavin <tim.flavin@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 28 Aug 2012, Tim Flavin wrote:
> Hi:
> 
> I am having a problem with mkcephfs.  I built ceph from the 48.1 tarball.
> 
> When I type:   sudo mkcephfs -a -c ceph.conf -k ceph.keyring
> 
> I get:
> 
> (monmap tool related stuff is ok)
> 
> 
> === osd.0 ===
> 2012-08-28 11:51:49.549651 b6f85000 -1 OSD::mkfs: FileStore::mkfs
> failed with error -2
> 2012-08-28 11:51:49.549767 b6f85000 -1  ** ERROR: error creating empty
> object store in /data/sd1: (2) No such file or directory
> failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.mKzTuonWuF
> --init-daemon osd.0'

That is not the most helpful error message, but:

> 
> 
> user1@ceph4:~$ cat ceph.conf
> [osd]
> 	osd journal size = 1000
> 	filestore xattr use omap = true
> 
> [mon.a]
> 	host = ceph4
> 	mon addr = 64.20.246.210
> 
> [osd.0]
> 	host = ceph4
>         osd data = /data/sd1
> 	; osd data = /dev/user1/data
> 	; osd journal = /dev/sdc1
> 	osd journal = /user1/log
> 
> 
> user1@ceph4:~$ ls /data/sd1
> current  d1  fsid  lost+found  store_version

...it looks like there is already data in that directory. Have you tried 
removing all of the files in /data/sd1 and retrying?

sage


> 
> /data/sd1 is an ext4 file system with -o noatime,user_xattr
> 
> Any ideas?
> 
> 
> Tim Flavin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
