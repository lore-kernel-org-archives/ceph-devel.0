From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: ceph -s loops/hangs! ubuntu raring ceph bug?
Date: Wed, 19 Dec 2012 17:42:45 +0000
Message-ID: <50D1FC95.3090705@inktank.com>
References: <loom.20121219T172747-957@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:36923 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2LSRuU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 12:50:20 -0500
Received: by mail-bk0-f51.google.com with SMTP id ik5so1173681bkc.24
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 09:50:18 -0800 (PST)
In-Reply-To: <loom.20121219T172747-957@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tibet Himalkaya <himalkaya@hotmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/19/2012 04:48 PM, Tibet Himalkaya wrote:
> Hello CephTeam,Community
> I m doing just my first steps with ceph.
> I have upgraded my 3 test system to ubuntu/raring and run mkcephfs below is
> output,ceph.conf and ceph -s output...any help would be appreciated.
> Thanks
> Tibet

Have you started your monitors?

If so, what version are you using and what does the monitor logs say?

   -Joao

> ----------------------
> root@host1:/var/lib/ceph# mkcephfs -a -c /etc/ceph/ceph.conf --mkbtrfs
> temp dir is /tmp/mkcephfs.TWKgOA0wXY
> preparing monmap in /tmp/mkcephfs.TWKgOA0wXY/monmap
> /usr/bin/monmaptool --create --clobber --add a 10.255.255.1:6789
> --add b 10.255.255.2:6789 --add c 10.255.255.3:6789 --print
> /tmp/mkcephfs.TWKgOA0wXY/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.TWKgOA0wXY/monmap
> /usr/bin/monmaptool: generated fsid 29ac4f55-e174-4544-999e-b0cf2eeecda6
> epoch 0
> fsid 29ac4f55-e174-4544-999e-b0cf2eeecda6
> last_changed 2012-12-19 17:09:16.156323
> created 2012-12-19 17:09:16.156323
> 0: 10.255.255.1:6789/0 mon.a
> 1: 10.255.255.2:6789/0 mon.b
> 2: 10.255.255.3:6789/0 mon.c
> /usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.TWKgOA0wXY/monmap
> (3 monitors)
> === osd.0 ===
> no devs defined for osd.0
> 2012-12-19 17:09:16.437947 7f53401237c0 -1 journal check: ondisk
> fsid dafd4de1-3e82-4607-b124-63f8010a6a43 doesn't match expected
> 68b54f67-46d6-4eff-bb0b-ac5ceb9c62d9, invalid (someone else's?) journal
> 2012-12-19 17:09:16.779841 7f53401237c0 -1 filestore(/var/lib/ceph/osd/ceph-0)
>   could not find 23c2fcde/osd_superblock/0//-1 in index:
> (2) No such file or directory
> 2012-12-19 17:09:17.004905 7f53401237c0 -1 created object store
> /var/lib/ceph/osd/ceph-0 journal /tmpfs/osd.0.journal for osd.0 fsid
> 29ac4f55-e174-4544-999e-b0cf2eeecda6
> 2012-12-19 17:09:17.004961 7f53401237c0 -1 auth: error reading file:
> /var/lib/ceph/osd/ceph-0/keyring: can't open /var/lib/ceph/osd/ceph-0/keyring:
>   (2) No such file or directory
> 2012-12-19 17:09:17.005045 7f53401237c0 -1 created new key in keyring
> /var/lib/ceph/osd/ceph-0/keyring
> === osd.1 ===
> pushing conf and monmap to host2:/tmp/mkfs.ceph.45272
> no devs defined for osd.1
> 2012-12-19 17:09:19.544529 7f1f158837c0 -1 journal check: ondisk
> fsid 31f1b4ed-8cc8-493a-a62e-5d705736cc60 doesn't match expected
> bebd309d-e726-47d2-9ba7-324589b82a55, invalid (someone else's?) journal
> 2012-12-19 17:09:19.853172 7f1f158837c0 -1 filestore(/var/lib/ceph/osd/ceph-1)
> could not find 23c2fcde/osd_superblock/0//-1 in index:
> (2) No such file or directory
> 2012-12-19 17:09:20.094822 7f1f158837c0 -1 created object store
> /var/lib/ceph/osd/ceph-1 journal /tmpfs/osd.1.journal for osd.1 fsid
> 29ac4f55-e174-4544-999e-b0cf2eeecda6
> 2012-12-19 17:09:20.094871 7f1f158837c0 -1 auth: error reading
> file: /var/lib/ceph/osd/ceph-1/keyring: can't open
> /var/lib/ceph/osd/ceph-1/keyring: (2) No such file or directory
> 2012-12-19 17:09:20.094951 7f1f158837c0 -1 created new key in
> keyring /var/lib/ceph/osd/ceph-1/keyring
> collecting osd.1 key
> === osd.2 ===
> pushing conf and monmap to host3:/tmp/mkfs.ceph.45272
> no devs defined for osd.2
> 2012-12-19 17:09:23.370067 7f1e3fe5c7c0 -1 journal check: ondisk
> fsid fa149ab5-3ec7-4a23-abc5-ef8ac61aca9b doesn't match expected
> b059d5b8-19cc-4921-bc37-e6e54fa508cb, invalid (someone else's?) journal
> 2012-12-19 17:09:23.686918 7f1e3fe5c7c0 -1 filestore(/var/lib/ceph/osd/ceph-2)
> could not find 23c2fcde/osd_superblock/0//-1 in index:
> (2) No such file or directory
> 2012-12-19 17:09:23.878634 7f1e3fe5c7c0 -1 created object store
> /var/lib/ceph/osd/ceph-2 journal /tmpfs/osd.2.journal for osd.2
> fsid 29ac4f55-e174-4544-999e-b0cf2eeecda6
> 2012-12-19 17:09:23.878684 7f1e3fe5c7c0 -1 auth: error reading
> file: /var/lib/ceph/osd/ceph-2/keyring: can't open
> /var/lib/ceph/osd/ceph-2/keyring: (2) No such file or directory
> 2012-12-19 17:09:23.878765 7f1e3fe5c7c0 -1 created new key in
> keyring /var/lib/ceph/osd/ceph-2/keyring
> collecting osd.2 key
> === mds.a ===
> creating private key for mds.a keyring /var/lib/ceph/mds/ceph-a/keyring
> creating /var/lib/ceph/mds/ceph-a/keyring
> === mds.b ===
> pushing conf and monmap to host2:/tmp/mkfs.ceph.45272
> creating private key for mds.b keyring /var/lib/ceph/mds/ceph-b/keyring
> creating /var/lib/ceph/mds/ceph-b/keyring
> collecting mds.b key
> === mds.c ===
> pushing conf and monmap to host3:/tmp/mkfs.ceph.45272
> creating private key for mds.c keyring /var/lib/ceph/mds/ceph-c/keyring
> creating /var/lib/ceph/mds/ceph-c/keyring
> collecting mds.c key
> Building generic osdmap from /tmp/mkcephfs.TWKgOA0wXY/conf
> /usr/bin/osdmaptool: osdmap file '/tmp/mkcephfs.TWKgOA0wXY/osdmap'
> /usr/bin/osdmaptool: writing epoch 1 to /tmp/mkcephfs.TWKgOA0wXY/osdmap
> Generating admin key at /tmp/mkcephfs.TWKgOA0wXY/keyring.admin
> creating /tmp/mkcephfs.TWKgOA0wXY/keyring.admin
> Building initial monitor keyring
> added entity mds.a auth auth(auid = 18446744073709551615
> key=AQC05tFQ4MiXKBAAs0puNKyZwKKRqpMloWwnIA== with 0 caps)
> added entity mds.b auth auth(auid = 18446744073709551615
> key=AQC25tFQAPB9IxAAMQAOPah3ehsLENKnGn/keA== with 0 caps)
> added entity mds.c auth auth(auid = 18446744073709551615
> key=AQC55tFQWC2jDhAAZJsDqe3m69c43wKF+2Xztw== with 0 caps)
> added entity osd.0 auth auth(auid = 18446744073709551615
> key=AQCt5tFQWMpLABAA6QOTvUx06ZmM+9sconRTvw== with 0 caps)
> added entity osd.1 auth auth(auid = 18446744073709551615
> key=AQCw5tFQYLGnBRAAQ5YuQ16gn0OEw6g2eL6yCQ== with 0 caps)
> added entity osd.2 auth auth(auid = 18446744073709551615
> key=AQCz5tFQ6LpfNBAAWZ4rWZLLiIryBt5cjhmynw== with 0 caps)
> === mon.a ===
> /usr/bin/ceph-mon: created monfs at /var/lib/ceph/mon/ceph-a for mon.a
> === mon.b ===
> pushing everything to host2
> /usr/bin/ceph-mon: created monfs at /var/lib/ceph/mon/ceph-b for mon.b
> === mon.c ===
> pushing everything to host3
> /usr/bin/ceph-mon: created monfs at /var/lib/ceph/mon/ceph-c for mon.c
> placing client.admin keyring in /etc/ceph/keyring
> -----------------------
> [global]
>          auth supported = none
>          auth cluster required = none
>          auth service required = none
>          auth client required = none
>          public network = 10.0.1.171/24
>          cluster network = 10.255.255.1/24
>          debug ms = 1
>
>
> [osd]
>          journal dio = false
>          osd journal size = 2000
>          osd journal = /tmpfs/osd.$id.journal
>          filestore fiemap = false
>          debug osd = 20
>          debug filestore = 20
>          debug journal = 20
>          debug monc = 20
>
> [mon]
>          debug mon = 20
>          debug paxos = 20
>          debug auth = 20
>
> [mon.a]
>          host = host1
>          mon addr = 10.255.255.1:6789
>
> [mon.b]
>          host = host2
>          mon addr = 10.255.255.2:6789
>
> [mon.c]
>          host = host3
>          mon addr = 10.255.255.3:6789
>
> [osd.0]
>          host = host1
>          public addr = 10.0.1.171
>          cluster addr = 10.255.255.1
>
> [osd.1]
>          host = host2
>          public addr = 10.0.1.172
>          cluster addr = 10.255.255.2
>
> [osd.2]
>          host = host3
>          public addr = 10.0.1.173
>          cluster addr = 10.255.255.3
>
> [mds]
>          debug mds = 20
>          debug mds balancer = 20
>          debug mds log = 20
>          debug mds migrator = 20
>
> [mds.a]
>          host = host1
>          public addr = 10.0.1.171
>          cluster addr = 10.255.255.1
>
> [mds.b]
>          host = host2
>          public addr = 10.0.1.172
>          cluster addr = 10.255.255.2
>
> [mds.c]
>          host = host3
>          public addr = 10.0.1.173
>          cluster addr = 10.255.255.3
>
> [client]
>          rbd cache = true
>
> -----------------------
> root@host1:/var/lib/ceph# ceph -s
> 2012-12-19 17:25:55.381735 7f0ab4250780  1 -- :/0 messenger.start
> 2012-12-19 17:25:55.382437 7f0ab4250780  1 -- :/52134 --> 10.255.255.2:6789/0
> -- auth(proto 0 30 bytes epoch 0) v1
> -- ?+0 0x7f0ab5d28a  50 con 0x7f0ab5d28610 2012-12-19 17:25:55.382836
> 7f0ab424e700  1
> -- 10.255.255.1:0/52134 learned my addr 10.255.255.1:0/52134
> 2012-12-19 17:25:58.382411 7f0aaf2cd700  1
> -- 10.255.255.1:0/52134 mark_down 0x7f0ab5d28610 -- 0x7f0ab5d283d0
> 2012-12-19 17:25:58.382525 7f0aaf2cd700  1
> -- 10.255.255.1:0/52134 --> 10.255.255.3:6789/0 -- auth(proto 0 30 bytes
> epoch 0) v1 -- ?+0   0x7f0aa4001330 con 0x7f0aa4000e40
> 2012-12-19 17:26:01.382653 7f0aaf2cd700  1 -- 10.255.255.1:0/52134 mark_down
> 0x7f0aa4000e40 -- 0x7f0aa4000c00
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

