From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Difference between "ceph osd crush reweight" and "ceph osd reweight"
Date: Thu, 11 Apr 2013 13:23:08 +0800
Message-ID: <CAJiejCRRQZoJv6sqz6ZC4V6t3po+wPj30BDtrMwiE0TG+EzhsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:33101 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab3DKFXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 01:23:30 -0400
Received: by mail-qe0-f49.google.com with SMTP id 6so695924qeb.36
        for <ceph-devel@vger.kernel.org>; Wed, 10 Apr 2013 22:23:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

Now I'm building another ceph cluster with 0.60, but I'm still running
v0.55.1 in production. I used to set 'ceph osd reweight' value same as
'ceph osd crush reweight', for example weight 3 for 3TB harddisk, but
it's impossible in v0.60, it ranges 0..1 now.

So, what changed? In my opinion, in v0.60, 'ceph osd crush reweight'
makes ceph distribute data across OSDs by their weight, and the 'ceph
osd reweight' controls migration speed of data in ceph cluster. Right
?

# id    weight    type name    up/down    reweight
-1    92    root default
-3    92        rack unknownrack
-2    26            host c15
0    3                osd.0    up    1
1    3                osd.1    up    1
10    2                osd.10    up    1
2    3                osd.2    up    1
3    3                osd.3    up    1
4    2                osd.4    up    1
5    2                osd.5    up    1
6    2                osd.6    up    1
7    2                osd.7    up    1
8    2                osd.8    up    1
9    2                osd.9    up    1
-4    33            host c16
11    3                osd.11    up    1
12    3                osd.12    up    1
13    3                osd.13    up    1
14    3                osd.14    up    1
15    3                osd.15    up    1
16    3                osd.16    up    1
17    3                osd.17    up    1
18    3                osd.18    up    1
19    3                osd.19    up    1
20    3                osd.20    up    1
21    3                osd.21    up    1
-5    33            host c18
22    3                osd.22    up    1
23    3                osd.23    up    1
24    3                osd.24    up    1
25    3                osd.25    up    1
26    3                osd.26    up    1
27    3                osd.27    up    1
28    3                osd.28    up    1
29    3                osd.29    up    1
30    3                osd.30    up    1
31    3                osd.31    up    1
32    3                osd.32    up    1
