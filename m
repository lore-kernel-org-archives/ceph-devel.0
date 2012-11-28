From: Samuel Just <sam.just@inktank.com>
Subject: Re: error creating empty object store
Date: Tue, 27 Nov 2012 17:17:35 -0800
Message-ID: <CA+4uBUbjEBRR=m3rKEKMw_18KQCxzXUeWgzUwUGNzYsXafA8sw@mail.gmail.com>
References: <CA+kMGwCmOZt-=YnVq-yn4Yv9izCsfqDGSO7rBcxT_pF4OcbhrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64814 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2K1BRg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 20:17:36 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so7541663vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 17:17:35 -0800 (PST)
In-Reply-To: <CA+kMGwCmOZt-=YnVq-yn4Yv9izCsfqDGSO7rBcxT_pF4OcbhrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rick Richardson <rick.richardson@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It will return that error if the osd directory is not empty at create
time.  Can you confirm that the osd directory is empty and try again?
-Sam

On Tue, Nov 27, 2012 at 9:07 AM, Rick Richardson
<rick.richardson@gmail.com> wrote:
> I have 4 ubuntu 12.04 with 3.6.7 kernel that I'm trying to configure.
> Each will have 1 btrfs drive for an OSD, and 1 drive for its journal.
> both drives on each host are formatted with mkfs.btrfs.
>
> I am using github/ceph master.  I have osd.0-3 assigned to the 4
> hosts, then in [osd] I have
> osd journal = /dev/sdc1
>
> I'm hoping that it will universally apply to all 4 nodes.
>
> ------
>
> root@blargle1:/etc/ceph# mount
> ...
> /dev/sdb1 on /var/lib/ceph/osd/ceph-0 type btrfs (rw)
>
> root@blargle1:/etc/ceph# sudo mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring
> temp dir is /tmp/mkcephfs.54pDJ56uZN
> preparing monmap in /tmp/mkcephfs.54pDJ56uZN/monmap
> /usr/local/bin/monmaptool --create --clobber --add a 172.17.9.234:6789
> --add b 172.17.9.235:6789 --add c 172.17.9.236:6789 --add d
> 172.17.9.237:6789 --print /tmp/mkcephfs.54pDJ56uZN/monmap
> /usr/local/bin/monmaptool: monmap file /tmp/mkcephfs.54pDJ56uZN/monmap
> /usr/local/bin/monmaptool: generated fsid 8681d07b-d8f1-4f2a-8008-cd72997eb912
> epoch 0
> fsid 8681d07b-d8f1-4f2a-8008-cd72997eb912
> last_changed 2012-11-27 11:47:27.852699
> created 2012-11-27 11:47:27.852699
> 0: 172.17.9.234:6789/0 mon.a
> 1: 172.17.9.235:6789/0 mon.b
> 2: 172.17.9.236:6789/0 mon.c
> 3: 172.17.9.237:6789/0 mon.d
> /usr/local/bin/monmaptool: writing epoch 0 to
> /tmp/mkcephfs.54pDJ56uZN/monmap (4 monitors)
> === osd.0 ===
> SG_IO: bad/missing sense data, sb[]:  70 00 05 00 00 00 00 0a 00 00 00
> 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SG_IO: bad/missing sense data, sb[]:  70 00 05 00 00 00 00 0a 00 00 00
> 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SG_IO: bad/missing sense data, sb[]:  70 00 05 00 00 00 00 0a 00 00 00
> 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2012-11-27 11:47:30.461827 7faac2144780 -1 provided osd id 0 != superblock's -1
> 2012-11-27 11:47:30.463239 7faac2144780 -1  ** ERROR: error creating
> empty object store in /var/lib/ceph/osd/ceph-0: (22) Invalid argument
> failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.54pDJ56uZN
> --init-daemon osd.0'
>
> ----
>
> Thoughts?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
