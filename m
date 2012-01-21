From: Wido den Hollander <wido@widodh.nl>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Sat, 21 Jan 2012 17:25:40 +0100
Message-ID: <4F1AE704.6010005@widodh.nl>
References: <4F1ABD5C.1000907@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51754 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2AUQZn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Jan 2012 11:25:43 -0500
In-Reply-To: <4F1ABD5C.1000907@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-devel@vger.kernel.org

Hi,

On 01/21/2012 02:27 PM, Smart Weblications GmbH - Florian Wiessner wrote:
> Hi List,
>
>
> i today upgraded from 0.39 to 0.40 and also from linux 3.1.5 to 3.2.1 and now
> have the following problems:
>
> first of all, i have a 4 node ceph cluster running.
>
> after the kernel upgrade, 2 of 4 osds failed starting because of btrfs-bugs so i
> now only have two osds available ( i set replication level to 3 so the data
> should be save)
>
> i upgraded to
> ceph version 0.40-1-g7ce8b7a (commit:7ce8b7ae3bbad70fe257db00b6fc566f57f17132)
>
> my ceph.conf looks like this:
>
> node03:/etc/ceph# cat ceph.conf
> [global]
>         pid file = /var/run/ceph/$name.pid
>         debug ms = 1
> #       auth supported = cephx
>         osd journal = /data/ceph.journal
>         osd_journal_size = 512
> #       filestore journal writeahead = true
> #       filestore journal parallel = true
>          mds max = 4
>
> [mon]
>         mon data = /data/ceph/mon
> [mon.0]
>         host = node01
>         mon addr = 192.168.0.4:6789
> [mon.1]
>         host = node02
>         mon addr = 192.168.0.5:6789
> [mon.2]
>         host = node03
>         mon addr = 192.168.0.6:6789
> [mon.3]
>         host = node04
>         mon addr = 192.168.0.7:6789

Although I don't think it is related I'd advise you to switch from 
numeric monitor names to alphanumeric names:

mon.alpha
mon.beta
mon.charlie
mon.delta

A while ago this changed, I also think the configuration doesn't even 
allow numeric monitors anymore? (correct me if I'm wrong!)

>
> [mds]
> #       keyring = /etc/ceph/keyring.$name
> #       mds dir max commit size 32
>
> [mds.0]
>         host = node01
> [mds.1]
>         host = node02
> [mds.2]
>         host = node03
> [mds.3]
>         host = node04
>
>
> [osd]
>         sudo = true
>         osd data = /data/ceph/osd
> #       keyring = /etc/ceph/keyring.$name
> [osd.0]
>         host = node01
> [osd.1]
>         host = node02
> [osd.2]
>         host = node03
> [osd.3]
>         host = node04
>
> i did set up ceph without cephx

When did you enable cephx? Did you do so from the upgrade to 0.39 to 
0.40 or earlier?

>
> so now i upgraded to 0.40 and i have this problem:
>
> node03:/etc/ceph# ceph -w
> 2012-01-21 14:24:16.177441 7f7c45cc0760 -- :/0 messenger.start
> 2012-01-21 14:24:16.177628 7f7c45cc0760 -- :/11220 -->  192.168.0.5:6789/0 --
> auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f60 con 0x22f3ce0
> 2012-01-21 14:24:16.177926 7f7c45cbf700 -- 192.168.0.6:0/11220 learned my addr
> 192.168.0.6:0/11220
> 2012-01-21 14:24:19.177703 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f3ce0 -- 0x22f3a70
> 2012-01-21 14:24:19.177798 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f60 con
> 0x22f51d0
> 2012-01-21 14:24:22.177921 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f51d0 -- 0x22f4f60
> 2012-01-21 14:24:22.177999 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f60 con
> 0x22f3ce0
> 2012-01-21 14:24:25.178187 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f3ce0 -- 0x22f3a70
> 2012-01-21 14:24:25.178268 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f60 con
> 0x22f4a50
> 2012-01-21 14:24:28.178358 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f4a50 -- 0x22f47e0
> 2012-01-21 14:24:28.178431 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4310 con
> 0x22f41d0
> 2012-01-21 14:24:31.178511 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f41d0 -- 0x22f3f60
> 2012-01-21 14:24:31.178582 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4310 con
> 0x22f4a50
> 2012-01-21 14:24:34.178661 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f4a50 -- 0x22f47e0
> 2012-01-21 14:24:34.178729 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4310 con
> 0x22f41d0
> 2012-01-21 14:24:37.178863 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f41d0 -- 0x22f3f60
> 2012-01-21 14:24:37.178928 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4310 con
> 0x22f4a50
> 2012-01-21 14:24:40.179067 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f4a50 -- 0x22f47e0
> 2012-01-21 14:24:40.179156 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.4:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4b90 con
> 0x22f4320
> 2012-01-21 14:24:43.179312 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f4320 -- 0x22f40b0
> 2012-01-21 14:24:43.179380 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4b90 con
> 0x22f4a50
> 2012-01-21 14:24:46.179464 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f4a50 -- 0x22f47e0
> 2012-01-21 14:24:46.179533 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4b90 con
> 0x22f41d0
> 2012-01-21 14:24:49.179671 7f7c42244700 -- 192.168.0.6:0/11220 mark_down
> 0x22f41d0 -- 0x22f3f60
> 2012-01-21 14:24:49.179746 7f7c42244700 -- 192.168.0.6:0/11220 -->
> 192.168.0.5:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4310 con
> 0x22f4a50
> ^C*** Caught signal (Interrupt) **
>   in thread 7f7c45cc0760. Shutting down.
>
>
> node03:/etc/ceph# rbd ls
> 2012-01-21 14:25:27.876338 7f80bcf9e760 -- :/0 messenger.start
> 2012-01-21 14:25:27.876499 7f80bcf9e760 -- :/1011679 -->  192.168.0.4:6789/0 --
> auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0xa3c020 con 0xa3bda0
> 2012-01-21 14:25:27.876787 7f80bcf9d700 -- 192.168.0.6:0/1011679 learned my addr
> 192.168.0.6:0/1011679
> 2012-01-21 14:25:30.876586 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0xa3bda0 -- 0xa3bb30
> 2012-01-21 14:25:30.876675 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0xa3c020 con 0xa402c0
> 2012-01-21 14:25:33.876794 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0xa402c0 -- 0xa40050
> 2012-01-21 14:25:33.876871 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0xa3bc80 con 0xa3c9f0
> 2012-01-21 14:25:36.876987 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0xa3c9f0 -- 0xa3c780
> 2012-01-21 14:25:36.877068 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.4:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b40008d0
> con 0xa3c290
> 2012-01-21 14:25:39.877248 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0xa3c290 -- 0xa3c020
> 2012-01-21 14:25:39.877324 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4000af0
> con 0x7f80b40008b0
> 2012-01-21 14:25:42.877424 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0x7f80b40008b0 -- 0x7f80b4000e00
> 2012-01-21 14:25:42.877496 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.5:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4001450
> con 0x7f80b4001310
> 2012-01-21 14:25:45.877624 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0x7f80b4001310 -- 0x7f80b4000af0
> 2012-01-21 14:25:45.877706 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b40010c0
> con 0x7f80b40008b0
> 2012-01-21 14:25:48.877815 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0x7f80b40008b0 -- 0x7f80b4001450
> 2012-01-21 14:25:48.877889 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.5:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b40010c0
> con 0x7f80b40012e0
> 2012-01-21 14:25:51.877988 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0x7f80b40012e0 -- 0x7f80b4000d70
> 2012-01-21 14:25:51.878060 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4000a90
> con 0x7f80b4000950
> 2012-01-21 14:25:54.878187 7f80b9569700 -- 192.168.0.6:0/1011679 mark_down
> 0x7f80b4000950 -- 0x7f80b4000fe0
> 2012-01-21 14:25:54.878260 7f80b9569700 -- 192.168.0.6:0/1011679 -->
> 192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4000a90
> con 0x7f80b4000e90
> 2012-01-21 14:25:57.876601 7f80bcf9e760 monclient(hunting): authenticate timed
> out after 30
> 2012-01-21 14:25:57.876648 7f80bcf9e760 librados: client.admin authentication
> error (110) Connection timed out
> 2012-01-21 14:25:57.876768 7f80bcf9e760 -- 192.168.0.6:0/1011679 shutdown complete.
> error: couldn't connect to the cluster!
>
> i am now unable to mount ceph directly as fs, nor access my rbd images.
>
> reverting to 0.39 also does not work, the osds then fail starting claiming that
> the filestore does not belong to the osd
>
> Please advise!
>
>

