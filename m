From: Ankur Kemkar <ankur.kemkar@emc.com>
Subject: Re: vstart problem in master branch
Date: Fri, 15 Apr 2011 21:02:20 +0000 (UTC)
Message-ID: <loom.20110415T225346-950@post.gmane.org>
References: <B6DAFB0C-A321-499A-A21E-7CA59EFCDA5B@cs.ucsc.edu> <054B710EFF18497CB0B964DC9819B556@gmail.com> <20110331180652.GA12850@dreamer> <0A340955-01D3-4E72-AC72-0F9EFBC94227@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52384 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127Ab1DOVUH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Apr 2011 17:20:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QAqQv-0004Eq-2L
	for ceph-devel@vger.kernel.org; Fri, 15 Apr 2011 23:20:05 +0200
Received: from 137.69.117.57 ([137.69.117.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 23:20:05 +0200
Received: from ankur.kemkar by 137.69.117.57 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 23:20:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Noah Watkins <jayhawk <at> cs.ucsc.edu> writes:

> 
> That was it (/me adds to fstab).
> 
> Thanks,
> Noah
> 
> On Mar 31, 2011, at 11:06 AM, Tommi Virtanen wrote:
> 
> > On Thu, Mar 31, 2011 at 11:04:36AM -0700, Gregory Farnum wrote:
> >> I think that's the user_xattr error (if you don't have user xattrs enabled
on the mount).
> > 
> > Yup, I agree with this diagnosis.
> > 
> > We should make that error more obvious: http://tracker.newdream.net/issues/952
> > 
> > -- 
> > :(){ :|:&};:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
If all i need to do is get fresh sources and compile instead of installing the
package (apt-get), maybe I can try that to go past this.

I am using available ubuntu package and see this today. /data/osdN/ on a node
seems to be wiped in attempt to start ceph. mkfs creates it all right.

sysadmin@ubuntu3:~$ ls -R /data
/data:
osd2

/data/osd2:
sysadmin@ubuntu3:~$ ls -l /data/osd* <--- after makecpehfs
total 20
-rw-r--r-- 1 root root   37 2011-04-15 11:14 ceph_fsid
drwxr-xr-x 4 root root 4096 2011-04-15 11:14 current
-rw-r--r-- 1 root root    8 2011-04-15 11:14 fsid
-rw-r--r-- 1 root root   21 2011-04-15 11:14 magic
-rw-r--r-- 1 root root    2 2011-04-15 11:14 whoami
sysadmin@ubuntu3:~$ sync <-- after this I attempt to start ceph
sysadmin@ubuntu3:~$ ls -l /data/osd* 
total 0
drwxr-xr-x 1 root root 0 2011-04-15 09:26 current
sysadmin@ubuntu3:~$ sudo reboot

after reboot, I see:

sysadmin@ubuntu3:~$ mount
/dev/sda1 on / type ext4 (rw,user_xattr,errors=remount-ro)
proc on /proc type proc (rw,noexec,nosuid,nodev)
none on /sys type sysfs (rw,noexec,nosuid,nodev)
fusectl on /sys/fs/fuse/connections type fusectl (rw)
none on /sys/kernel/debug type debugfs (rw)
none on /sys/kernel/security type securityfs (rw)
none on /dev type devtmpfs (rw,mode=0755)
none on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
none on /dev/shm type tmpfs (rw,nosuid,nodev)
none on /var/run type tmpfs (rw,nosuid,mode=0755)
none on /var/lock type tmpfs (rw,noexec,nosuid,nodev)
/dev/sdb on /data/osd2 type btrfs (rw,noatime) <---  the directory is still
empty as above. So what is this?

thanks - 




