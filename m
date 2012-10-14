From: Dan Mick <dan.mick@inktank.com>
Subject: Re: OSD::mkfs: couldn't mount FileStore: error -22
Date: Sun, 14 Oct 2012 14:28:17 -0700
Message-ID: <507B2E71.4040706@inktank.com>
References: <k5dqro$s4d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41401 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab2JNV20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Oct 2012 17:28:26 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4339111pbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 14 Oct 2012 14:28:26 -0700 (PDT)
In-Reply-To: <k5dqro$s4d$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

The immediate cause of the problem is that the osd's "commit_op_seq" 
file is reading back '0',
which is invalid; it's created with an initial value of 1.  Try removing 
the osd data dir
(/var/lib/ceph/osd/ceph-0) completely and let it be recreated; perhaps 
something got there somehow by mistake.

If the error persists you can look more deeply.

On 10/14/2012 12:50 AM, Adam Nielsen wrote:
> Hi all,
>
> I'm attempting to set up a Ceph cluster for testing, initially with 
> only one node so I can add others next.  I think I've followed the 
> guides as closely as I could, but now when running mkcephfs it fails 
> and I can't find much about the error through Google.
>
> What am I doing wrong?  This is on Debian Squeeze with the stable repo 
> from ceph.com.
>
> $ mkcephfs -a -c /etc/ceph/ceph.conf
> temp dir is /tmp/mkcephfs.FqyH7RCFY1
> preparing monmap in /tmp/mkcephfs.FqyH7RCFY1/monmap
> /usr/bin/monmaptool --create --clobber --add 0 192.168.0.6:6789 
> --print /tmp/mkcephfs.FqyH7RCFY1/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.FqyH7RCFY1/monmap
> /usr/bin/monmaptool: generated fsid 77b0e551-b545-42df-957e-b99292539501
> epoch 0
> fsid 77b0e551-b545-42df-957e-b99292539501
> last_changed 2012-10-14 17:40:11.128447
> created 2012-10-14 17:40:11.128447
> 0: 192.168.0.6:6789/0 mon.0
> /usr/bin/monmaptool: writing epoch 0 to 
> /tmp/mkcephfs.FqyH7RCFY1/monmap (1 monitors)
> === osd.0 ===
>  ** WARNING: 'filestore btrfs snap' is enabled (for safe transactions,
>              rollback), but btrfs does not support the SNAP_CREATE_V2 
> ioctl
>              (added in Linux 2.6.37).  Expect slow btrfs sync/commit
>              performance.
> 2012-10-14 17:40:12.768973 b732b710 -1 
> filestore(/var/lib/ceph/osd/ceph-0) mount initial op seq is 0; 
> something is wrong
> 2012-10-14 17:40:12.769238 b732b710 -1 OSD::mkfs: couldn't mount 
> FileStore: error -22
> 2012-10-14 17:40:12.769522 b732b710 -1  ** ERROR: error creating empty 
> object store in /var/lib/ceph/osd/ceph-0: (22) Invalid argument
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.FqyH7RCFY1 --init-daemon osd.0'
>
> $ cat /etc/ceph/ceph.conf
> [osd]
>         osd journal size = 10000
>
> [mon.0]
>         host = node1
>         mon addr = 192.168.0.6:6789
>         mon data = /var/lib/ceph/osd/$cluster-$id/
>
> [osd.0]
>         host = node1
>
> [mds.0]
>         host = node1
>
> Any suggestions?  I tried commenting out "mon data" but it didn't make 
> a difference (and I need this in because the test machine's root 
> filesystem is on a 4GB CF card, so I need all non-OS data to be stored 
> on the disks assigned to Ceph.)
>
> Thanks,
> Adam.
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

