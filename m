From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] wired output of ceph df : Firefly 0.80.5
Date: Thu, 21 Aug 2014 09:06:27 -0700
Message-ID: <CAPYLRzi2ROL+xMekqVAbH7M6T6ODmf1zzT8EgAZjmQJVuMRp1w@mail.gmail.com>
References: <F690D436-ABCA-45D4-9583-492EED969300@csc.fi>
	<97499908-D142-4F14-92BB-5214561F04B3@csc.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:50193 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaHUQG2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 12:06:28 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so8451152qab.32
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 09:06:27 -0700 (PDT)
In-Reply-To: <97499908-D142-4F14-92BB-5214561F04B3@csc.fi>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karan Singh <karan.singh@csc.fi>, Joao Luis <joao.luis@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yeah, this is pretty weird. Can you run "df" on each of your OSDs and
see if any of them individually have a strange output?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Tue, Aug 12, 2014 at 6:52 AM, Karan Singh <karan.singh@csc.fi> wrote=
:
> Forgot to mention i am observing  EB  in ceph -s output  ,  does it m=
ean
> Exabyte  ;-)
>
>
> # ceph -s
>     cluster 009d3518-e60d-4f74-a26d-c08c1976263c
>      health HEALTH_WARN 'cache-pool' at/near target max
>      monmap e3: 3 mons at
>      mdsmap e14: 1/1/1 up {0=3Dstorage0101-ib=3Dup:active}
>      osdmap e194215: 402 osds: 402 up, 402 in
>       pgmap v743051: 31168 pgs, 22 pools, 8 EB data, 378 kobjects
>             17508 GB used, 1284 TB / 1301 TB avail
>                31168 active+clean
>
>
> - Karan Singh -
>
>
> On 12 Aug 2014, at 16:45, Karan Singh <karan.singh@csc.fi> wrote:
>
> Hello Developers
>
> I have encountered some wired output of ceph df command , suddenly
>
>
> When i was writing some data on cache-pool , and checked its used % ,=
 i
> found some used as 8E ( don=E2=80=99t know what is this ) and the use=
d % for
> cache-pool was 0
>
>
> # ceph df
> GLOBAL:
>     SIZE      AVAIL     RAW USED     %RAW USED
>     1301T     1284T     17518G       1.31
> POOLS:
>     NAME                   ID     USED       %USED     OBJECTS
>     data                   0      801M       0         2
>     metadata               1      801M       0         22
>     rbd                    2      0          0         0
>     .rgw                   3      3524       0         26
>     .rgw.root              4      778        0         3
>     .rgw.control           5      0          0         8
>     .rgw.buckets           6      8201M      0         2298
>     .rgw.buckets.index     7      0          0         13
>     .users.swift           8      7          0         1
>     volumes                9      1106G      0.08      283387
>     images                 10     40960k     0         8
>     backups                11     0          0         0
>     .rgw.gc                12     0          0         32
>     .users.uid             13     848        0         5
>     .users                 14     16         0         2
>     .log                   15     153k       0         37
>                            16     0          0         0
>     hpsl4540               21     110G       0         28152
>     hpdl380                22     245G       0.02      62688
>     EC-2-2                 23     6338G      0.48      4859
>     cache-pool             24     8E         0         5849        ##=
 What
> is the meaning of E here , also please note used % for cache-pool is =
0 here
>     ssd                    25     25196M     0         5464
>
>
> After some time when cache-poo used value changed to 7E and used % as
> 644301.19  . While there were no objects in the cache-pool
>
>
> # ceph df
> GLOBAL:
>     SIZE      AVAIL     RAW USED     %RAW USED
>     1301T     1284T     17508G       1.31
> POOLS:
>     NAME                   ID     USED       %USED         OBJECTS
>     data                   0      801M       0             2
>     metadata               1      801M       0             22
>     rbd                    2      0          0             0
>     .rgw                   3      3524       0             26
>     .rgw.root              4      778        0             3
>     .rgw.control           5      0          0             8
>     .rgw.buckets           6      8201M      0             2298
>     .rgw.buckets.index     7      0          0             13
>     .users.swift           8      7          0             1
>     volumes                9      1106G      0.08          283387
>     images                 10     40960k     0             8
>     backups                11     0          0             0
>     .rgw.gc                12     0          0             32
>     .users.uid             13     848        0             5
>     .users                 14     16         0             2
>     .log                   15     153k       0             37
>                            16     0          0             0
>     hpsl4540               21     110G       0             28152
>     hpdl380                22     245G       0.02          62688
>     EC-2-2                 23     6338G      0.48          4843
>     cache-pool             24     7E         644301.19     1056
> ## The used % for cache-pool has become 644301.19
>     ssd                    25     25196M     0             5464
> #
>
>
> # rados -p cache-pool ls
> #
>
>
>
>
> Is this a bug , if yes , then is is already known. Do you want me to =
raise a
> bug ticket in tracker.ceph.com ?
>
>
>
> ****************************************************************
> Karan Singh
> Cloud computing group
> CSC - IT Center for Science,
> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
> tel. +358 9 4572001
> fax +358 9 4572302
> http://www.csc.fi/
> ****************************************************************
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
