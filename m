From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Disable logging for radosgw inside rados pool
Date: Wed, 8 Feb 2012 09:49:55 +0100
Message-ID: <CAMwB3ThXF20wHewK_NNgSkeEyD=XhaF=gbPDa9o_j7f5gKWv_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39630 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab2BHIt4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2012 03:49:56 -0500
Received: by wgbdt10 with SMTP id dt10so355741wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2012 00:49:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is there any way to disable logging inside rados for radosgw.

pool name       category                 KB      objects       clones
   degraded      unfound           rd        rd KB           wr
wr KB
=2Eintent-log     -                       5952           16            =
0
           0           0            0            0        29288
29288
=2Elog            -                     356198          497            =
0
           0           0            0            0      1473971
1473971
=2Ergw            -                          1           10            =
0
           0           0            1            0            9
    7
=2Ergw.buckets    -                    9756733        65589            =
0
           0           0       588675   4224301428      1000737
1699523842

Disable writes to .log ??

--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
