From: Drunkard Zhang <gongfan193@gmail.com>
Subject: new ceph-0.60 always crash mds
Date: Fri, 12 Apr 2013 12:01:21 +0800
Message-ID: <CAJiejCRunA9z=L2zTQP=b+=F2Pf17nG1CNoF1EN7rhvLwuqtKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:40809 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3DLEBm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 00:01:42 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so1019501qcs.26
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 21:01:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

My newly created ceph cluster in ceph-0.60 always crash mds, the last messages:

     0> 2013-04-12 11:48:53.034644 7f691cf64700 -1 mds/MDSTable.cc: In
function 'void MDSTable::load_2(int, ceph::bufferlist&, Context*)'
thread 7f691cf64700 time 2013-04-12 11:48:53.033488
mds/MDSTable.cc: 150: FAILED assert(0)

I thought it was cephx problem, but after disable cephx and restart
whole cluster, it's still that way.

auth cluster required = none
auth service required = none
auth client required = none

Previous setting:
;auth cluster required = cephx
;auth service required = cephx
;auth client required = cephx
;cephx require signatures = true
;cephx cluster require signatures = true
;cephx service require signatures = true
;cephx sign messages = true
