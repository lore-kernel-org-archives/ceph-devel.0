From: Stefan Majer <stefan.majer@gmail.com>
Subject: rados df does not report reads (rd and rd KB stays constant)
Date: Fri, 23 Mar 2012 15:07:29 +0100
Message-ID: <CADdPHGs-e-MwD6Cr5L9W_JgH0UmZSTJhN2NBuPtpOUBiih9GDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48073 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab2CWOH3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 10:07:29 -0400
Received: by ghrr11 with SMTP id r11so2756890ghr.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Mar 2012 07:07:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

i use rados df to collect several statistics of our ceph cluster for
monitoring purpose. But the reporting of rd and rd KB is broken,
because it does not change over time.
wr and wr KB reflect really well our storage usage.

So this seems to be broken. We have ceph-0.4.2 installed.

here are two outputs of rados df with 2 seconds inbetween.
[root@sc00 ~]# rados df
pool name       category                 KB      objects       clones
   degraded      unfound           rd        rd KB           wr
wr KB
data                -                       499713          123
       0                0                0            0            0
       123       499713
metadata         -                                 0            0
         0                0                0            0            0
           0            0
rbd                  -                 3229400110       798827
   0                0               0         7429        24682
371028901  17579250219
  total used      6474458716       798950
  total avail    56006434852
  total space    62480893568

[root@sc00 ~]# rados df
pool name       category                 KB      objects       clones
   degraded      unfound           rd        rd KB           wr
wr KB
data                -                     499713          123
       0                0                0            0
0          123       499713
metadata         -                               0            0
         0                0                0            0
 0            0            0
rbd                  -                 3229400110       798827
  0                 0                0         7429        24682
371028936  17579250619
  total used      6474458716       798950
  total avail    56006434852
  total space    62480893568


Greetings

-- 
Stefan Majer
