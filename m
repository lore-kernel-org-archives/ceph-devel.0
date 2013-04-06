From: Lorieri <lorieri@gmail.com>
Subject: pg dump --format crashes all mon nodes
Date: Fri, 5 Apr 2013 21:49:15 -0300
Message-ID: <CAPHxCcS+bHq5Roc6g6WZkn_hYn667Eod5b3fPv3Q4oU7JwatSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53804 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477Ab3DFAtP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 20:49:15 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so4973512iea.38
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 17:49:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

My colleague run ceph pg dump --format with no other arguments.
It crashes all mon daemons in the cluster.

happens in ceph 0.60 and 0.56
3 mon, 3 osd, default crush map

# ceph pg dump --format
2013-04-05 21:21:42.198843 7f3b1e58b700  0 monclient: hunting for new mon
2013-04-05 21:21:42.210685 7f3b1e58b700  0 monclient: hunting for new mon
2013-04-05 21:21:42.229632 7f3b1e58b700  0 monclient: hunting for new mon
2013-04-05 21:21:42.230233 7f3b22ca4700  0 -- 10.134.35.70:0/3005 >>
10.134.35.68:6789/0 pipe(0x7f3b14005130 sd=3 :0 pgs=0 cs=0 l=1).fault
2013-04-05 21:21:45.178005 7f3b1c486700  0 -- 10.134.35.70:0/3005 >>
10.134.35.69:6789/0 pipe(0x7f3b18000f90 sd=3 :0 pgs=0 cs=0 l=1).fault
2013-04-05 21:21:48.178089 7f3b22ca4700  0 -- 10.134.35.70:0/3005 >>
10.134.35.70:6789/0 pipe(0x7f3b18003010 sd=4 :0 pgs=0 cs=0 l=1).fault

# ceph health
2013-04-05 21:24:22.365023 7f59371ec700  0 -- :/3114 >>
10.134.35.70:6789/0 pipe(0x1e51540 sd=3 :0 pgs=0 cs=0 l=1).fault
2013-04-05 21:24:25.365819 7f593d909700  0 -- :/3114 >>
10.134.35.69:6789/0 pipe(0x7f592c000c00 sd=4 :0 pgs=0 cs=0 l=1).fault
2013-04-05 21:24:28.365786 7f59371ec700  0 -- :/3114 >>
10.134.35.70:6789/0 pipe(0x7f592c003010 sd=4 :0 pgs=0 cs=0 l=1).fault
