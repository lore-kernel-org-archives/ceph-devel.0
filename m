From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: mkcehfs: ** ERROR: error creating empty object store in
 /data/sd1: (2) No such file or directory
Date: Tue, 28 Aug 2012 20:07:36 +0200
Message-ID: <20120828180736.GB9872@oder.mch.fsc.net>
References: <CAEj+kbmZs=x+8MVRwDs4PDbozFqSk+Qgd4EYEEe4HVQUYjxGLg@mail.gmail.com>
 <alpine.DEB.2.00.1208281013360.25640@cobra.newdream.net>
 <CAEj+kbmaQRQbWtj_+e6tw+UjE0HqxGU=aQY8DTbmxC5XUDoJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:58251 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2H1SIk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 14:08:40 -0400
Content-Disposition: inline
In-Reply-To: <CAEj+kbmaQRQbWtj_+e6tw+UjE0HqxGU=aQY8DTbmxC5XUDoJLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Flavin <tim.flavin@gmail.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dieter Kasper (KD)" <d.kasper@kabelmail.de>

Tim,
in a similar case I put 'strace -f' in front of ceph-osd in /sbin/mkcephfs

original
        $BINDIR/ceph-osd -c $conf --monmap $dir/monmap -i $id --mkfs --mkkey
change to
        strace -f $BINDIR/ceph-osd -c $conf --monmap $dir/monmap -i $id --mkfs --mkkey 2> err > out

run the test and look in 'err' for 'ENOENT'

Cheers,
-Dieter


On Tue, Aug 28, 2012 at 07:38:09PM +0200, Tim Flavin wrote:
> Sage:  Yes I tried that.
> 
> user1@ceph4:~/ceph-0.48.1argonaut$ cd /data
> user1@ceph4:/data$ cd sd1
> user1@ceph4:/data/sd1$ ls
> current  d1  fsid  lost+found  store_version
> 
> user1@ceph4:/data/sd1$ sudo rm -rf current d1 fsid store_version
> user1@ceph4:/data/sd1$ ls
> lost+found
> 
> user1@ceph4:/data/sd1$ cd
> user1@ceph4:~$ sudo mkcephfs -a -c ceph.conf -k ceph.keyring
> 
> 
> ...
> 
> === osd.0 ===
> 2012-08-28 12:29:38.299530 b6fd0000 -1 OSD::mkfs: FileStore::mkfs
> failed with error -2
> 2012-08-28 12:29:38.299634 b6fd0000 -1  ** ERROR: error creating empty
> object store in /data/sd1: (2) No such file or directory
> failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.syrvDQZU6f
> --init-daemon osd.0'
> 
> 
> user1@ceph4:~$ cd /data/sd1
> user1@ceph4:/data/sd1$ lsn
> total 28K
> drwxr-xr-x 3 root root 4.0K Aug 28 12:29 current
> -rw-r--r-- 1 root root    4 Aug 28 12:29 store_version
> -rw-r--r-- 1 root root   37 Aug 28 12:29 fsid
> drwx------ 2 root root  16K Aug 28 10:40 lost+found
> 
> 
> Note that mkcephfs was able to create current, store_version and fsid.
> 
> 
> 
> 
> 
> On Tue, Aug 28, 2012 at 1:14 PM, Sage Weil <sage@inktank.com> wrote:
> > On Tue, 28 Aug 2012, Tim Flavin wrote:
> >> Hi:
> >>
> >> I am having a problem with mkcephfs.  I built ceph from the 48.1 tarball.
> >>
> >> When I type:   sudo mkcephfs -a -c ceph.conf -k ceph.keyring
> >>
> >> I get:
> >>
> >> (monmap tool related stuff is ok)
> >>
> >>
> >> === osd.0 ===
> >> 2012-08-28 11:51:49.549651 b6f85000 -1 OSD::mkfs: FileStore::mkfs
> >> failed with error -2
> >> 2012-08-28 11:51:49.549767 b6f85000 -1  ** ERROR: error creating empty
> >> object store in /data/sd1: (2) No such file or directory
> >> failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.mKzTuonWuF
> >> --init-daemon osd.0'
> >
> > That is not the most helpful error message, but:
> >
> >>
> >>
> >> user1@ceph4:~$ cat ceph.conf
> >> [osd]
> >>       osd journal size = 1000
> >>       filestore xattr use omap = true
> >>
> >> [mon.a]
> >>       host = ceph4
> >>       mon addr = 64.20.246.210
> >>
> >> [osd.0]
> >>       host = ceph4
> >>         osd data = /data/sd1
> >>       ; osd data = /dev/user1/data
> >>       ; osd journal = /dev/sdc1
> >>       osd journal = /user1/log
> >>
> >>
> >> user1@ceph4:~$ ls /data/sd1
> >> current  d1  fsid  lost+found  store_version
> >
> > ...it looks like there is already data in that directory. Have you tried
> > removing all of the files in /data/sd1 and retrying?
> >
> > sage
> >
> >
> >>
> >> /data/sd1 is an ext4 file system with -o noatime,user_xattr
> >>
> >> Any ideas?
> >>
> >>
> >> Tim Flavin
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

