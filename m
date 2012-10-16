From: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?=
	<maciejgalkiewicz@ragnarson.com>
Subject: Re: Poor performance with rbd volumes
Date: Tue, 16 Oct 2012 22:24:34 +0200
Message-ID: <CAGqxmDO9VqNT0-ZqCCTbtNZ_BciiGsKf3EzA429Cq8nafQkFAw@mail.gmail.com>
References: <CAGqxmDPs2TWb0-XpXSWtT3HHCOGPu9NkcP264XK702FeYuiuaw@mail.gmail.com>
	<CAPYLRzh5HEiKBR_FZ2aX5cgP+2Rohpw1qWkKqNu-6WoOkEM4qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51415 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab2JPUYf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 16:24:35 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so6620412obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 13:24:35 -0700 (PDT)
In-Reply-To: <CAPYLRzh5HEiKBR_FZ2aX5cgP+2Rohpw1qWkKqNu-6WoOkEM4qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

> What's this data showing us? Write requests to any disk on the node o=
f any size?
> That's more than I'd expect to see, but Ceph is going to engage in
> some background chatter, and I notice you have at least a little bit
> of logging enabled.

Graphs show writes per second to partition on which are stored all
ceph data, journals (except n14c1 which has separate volume for it but
it is still on the same disk), mon/mds files. Logs are stored on a
separate partition but it is on the same disk (actually 2 disks in
raid0). All nodes have the same partition size. Writes per second from
different partition/volumes are not higher than 7-10.

> That's pretty hilariously slow =97 patterns like this usually mean th=
at
> you have one OSD in particular which is very slow at serving writes.
> Have you run any benchmarks on the backing filesystems without Ceph i=
n
> the way?
> These results combined with the fact that you're using old btrfs
> nodes, which have been supporting database access patterns, makes me
> think that you've just got a workload that fragments btrfs horribly
> and so your backing filesystems are themselves not supporting any rea=
l
> throughput.

I have made benchmarks (rados) when the cluster had 3 osds (n11c1,
n12c1, n14c1), n11c1 was shut down, n12c1 was 1 day old, n14c1 was 2
weeks old. The results were basically the same. Of course all pgs were
active+clean.

Benchmark from cc (staging) after ceph shut down:

root@cc[staging]:/srv/ceph# bonnie++ -u root:root
Using uid:0, gid:0.
Writing a byte at a time...done
Writing intelligently...done
Rewriting...done
Reading a byte at a time...done
Reading intelligently...done
start 'em...done...done...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version  1.96       ------Sequential Output------ --Sequential Input- -=
-Random-
Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- -=
-Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  =
/sec %CP
cc              12G   302  98 76010   7 32724   6   892  97 69298   7 1=
75.9   6
Latency             59095us     795ms    1393ms   16691us     663ms    =
 262ms
Version  1.96       ------Sequential Create------ --------Random Create=
--------
cc                  -Create-- --Read--- -Delete-- -Create-- --Read--- -=
Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  =
/sec %CP
                 16  5212  11 +++++ +++  7669  26  5681  13 +++++ +++  =
7638  25
Latency              1814us     738us   17132us     490us      98us    =
2290us
1.96,1.96,cc,1,1350429404,12G,,302,98,76010,7,32724,6,892,97,69298,7,17=
5.9,6,16,,,,,5212,11,+++++,+++,7669,26,5681,13,+++++,+++,7638,25,59095u=
s,795ms,1393ms,16691us,663ms,262ms,1814us,738us,17132us,490us,98us,2290=
us

> Also this is interesting =97 what are the pools used for? With an
> average size of 11 PGs/pool on production, and 4 OSDs, then you're
> likely to have some pretty distributions of writes on a per-pool
> basis, which would exacerbate any slow OSD problems on the pools whic=
h
> map heavily to that OSD.

The pools are used for authentication. I want clients to only be able
to map volumes from the pool to which they have keyring. What do you
mean by 'pools which map heavily to that osd'. Arent they supposed to
be spread among all osds equally? How to enhance this configuration?

--=20
Regards
Maciej Galkiewicz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
