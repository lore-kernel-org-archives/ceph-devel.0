From: Christian Brunner <christian@brunner-muc.de>
Subject: Inconsistent rbd header
Date: Fri, 16 Mar 2012 13:21:02 +0100
Message-ID: <CAJafhzSgAK==zLvHNE+Dve70xgTRBz++a5nnrk1JqZRYny-N7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40627 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2CPMVE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 08:21:04 -0400
Received: by wejx9 with SMTP id x9so3843629wej.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Mar 2012 05:21:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is probably going in the same direction as the report by Oliver Francke.

Ceph is reporting an inconsistent PG. Running a scrub on the PG gave
me the folling messages:

2012-03-16 12:55:17.287415   log 2012-03-16 12:55:12.179529 osd.14
10.255.0.63:6818/2014 34280 : [ERR] 2.117 osd.0: soid
818bc117/vol-FTU86AEJ.rbd/headsize 0 != known size 112
2012-03-16 12:55:17.287415   log 2012-03-16 12:55:12.179555 osd.14
10.255.0.63:6818/2014 34281 : [ERR] 2.117 scrub 0 missing, 1
inconsistent objects
2012-03-16 12:55:17.287415   log 2012-03-16 12:55:12.181397 osd.14
10.255.0.63:6818/2014 34282 : [ERR] scrub 2.117
818bc117/vol-FTU86AEJ.rbd/head on disk size (112) does not match
object info size (0)
2012-03-16 12:55:17.287415   log 2012-03-16 12:55:12.181925 osd.14
10.255.0.63:6818/2014 34283 : [ERR] 2.117 scrub stat mismatch, got
956/955 objects, 0/0 clones, 3951263856/3951263744 bytes.
2012-03-16 12:55:17.287415   log 2012-03-16 12:55:12.181947 osd.14
10.255.0.63:6818/2014 34284 : [ERR] 2.117 scrub 2 errors


A "PG repair" fixed one error:

2012-03-16 12:56:27.288690   log 2012-03-16 12:56:21.598432 osd.14
10.255.0.63:6818/2014 34285 : [ERR] 2.117 osd.0: soid
818bc117/vol-FTU86AEJ.rbd/headsize 0 != known size 112
2012-03-16 12:56:27.288690   log 2012-03-16 12:56:21.598457 osd.14
10.255.0.63:6818/2014 34286 : [ERR] 2.117 repair 0 missing, 1
inconsistent objects
2012-03-16 12:56:27.288690   log 2012-03-16 12:56:21.600277 osd.14
10.255.0.63:6818/2014 34287 : [ERR] repair 2.117
818bc117/vol-FTU86AEJ.rbd/head on disk size (112) does not match
object info size (0)
2012-03-16 12:56:27.288690   log 2012-03-16 12:56:21.600805 osd.14
10.255.0.63:6818/2014 34288 : [ERR] 2.117 repair stat mismatch, got
956/955 objects, 0/0 clones, 3951263856/3951263744 bytes.
2012-03-16 12:56:27.288690   log 2012-03-16 12:56:21.600849 osd.14
10.255.0.63:6818/2014 34289 : [ERR] 2.117 repair 2 errors, 1 fixed


On the filesystem (XFS) I can see the corresponding file:

# ls -l  /ceph/osd.014/current/2.117_head/DIR_7/DIR_1/DIR_1/vol-FTU86AEJ.rbd__head_818BC117
-rw-r--r-- 1 root root 112 Mar  1 20:32 vol-FTU86AEJ.rbd__head_818BC117

and I can read the object with rbd info:

# rbd info vol-FTU86AEJ
rbd image 'vol-FTU86AEJ':
        size 102400 MB in 25600 objects
        order 22 (4096 KB objects)
        block_name_prefix: rb.0.32
        parent:  (pool -1)

What I do not understand, is the fact that ceph seems to think that
the object should not exist any longer.

Any hint's on how to proceed? - Please note that I can do only limited
testing, because the cluster is in production.

Thanks,
Christian
