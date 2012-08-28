From: Tim Flavin <tim.flavin@gmail.com>
Subject: Re: mkcehfs: ** ERROR: error creating empty object store in
 /data/sd1: (2) No such file or directory
Date: Tue, 28 Aug 2012 13:38:09 -0400
Message-ID: <CAEj+kbmaQRQbWtj_+e6tw+UjE0HqxGU=aQY8DTbmxC5XUDoJLw@mail.gmail.com>
References: <CAEj+kbmZs=x+8MVRwDs4PDbozFqSk+Qgd4EYEEe4HVQUYjxGLg@mail.gmail.com>
	<alpine.DEB.2.00.1208281013360.25640@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43572 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2H1RiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 13:38:10 -0400
Received: by vcbfk26 with SMTP id fk26so6171984vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 10:38:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208281013360.25640@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Sage:  Yes I tried that.

user1@ceph4:~/ceph-0.48.1argonaut$ cd /data
user1@ceph4:/data$ cd sd1
user1@ceph4:/data/sd1$ ls
current  d1  fsid  lost+found  store_version

user1@ceph4:/data/sd1$ sudo rm -rf current d1 fsid store_version
user1@ceph4:/data/sd1$ ls
lost+found

user1@ceph4:/data/sd1$ cd
user1@ceph4:~$ sudo mkcephfs -a -c ceph.conf -k ceph.keyring


...

=== osd.0 ===
2012-08-28 12:29:38.299530 b6fd0000 -1 OSD::mkfs: FileStore::mkfs
failed with error -2
2012-08-28 12:29:38.299634 b6fd0000 -1  ** ERROR: error creating empty
object store in /data/sd1: (2) No such file or directory
failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.syrvDQZU6f
--init-daemon osd.0'


user1@ceph4:~$ cd /data/sd1
user1@ceph4:/data/sd1$ lsn
total 28K
drwxr-xr-x 3 root root 4.0K Aug 28 12:29 current
-rw-r--r-- 1 root root    4 Aug 28 12:29 store_version
-rw-r--r-- 1 root root   37 Aug 28 12:29 fsid
drwx------ 2 root root  16K Aug 28 10:40 lost+found


Note that mkcephfs was able to create current, store_version and fsid.





On Tue, Aug 28, 2012 at 1:14 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 28 Aug 2012, Tim Flavin wrote:
>> Hi:
>>
>> I am having a problem with mkcephfs.  I built ceph from the 48.1 tarball.
>>
>> When I type:   sudo mkcephfs -a -c ceph.conf -k ceph.keyring
>>
>> I get:
>>
>> (monmap tool related stuff is ok)
>>
>>
>> === osd.0 ===
>> 2012-08-28 11:51:49.549651 b6f85000 -1 OSD::mkfs: FileStore::mkfs
>> failed with error -2
>> 2012-08-28 11:51:49.549767 b6f85000 -1  ** ERROR: error creating empty
>> object store in /data/sd1: (2) No such file or directory
>> failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.mKzTuonWuF
>> --init-daemon osd.0'
>
> That is not the most helpful error message, but:
>
>>
>>
>> user1@ceph4:~$ cat ceph.conf
>> [osd]
>>       osd journal size = 1000
>>       filestore xattr use omap = true
>>
>> [mon.a]
>>       host = ceph4
>>       mon addr = 64.20.246.210
>>
>> [osd.0]
>>       host = ceph4
>>         osd data = /data/sd1
>>       ; osd data = /dev/user1/data
>>       ; osd journal = /dev/sdc1
>>       osd journal = /user1/log
>>
>>
>> user1@ceph4:~$ ls /data/sd1
>> current  d1  fsid  lost+found  store_version
>
> ...it looks like there is already data in that directory. Have you tried
> removing all of the files in /data/sd1 and retrying?
>
> sage
>
>
>>
>> /data/sd1 is an ext4 file system with -o noatime,user_xattr
>>
>> Any ideas?
>>
>>
>> Tim Flavin
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
