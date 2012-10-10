From: Andrey Korolyov <andrey@xdel.ru>
Subject: Ignore O_SYNC for rbd cache
Date: Wed, 10 Oct 2012 15:30:30 +0400
Message-ID: <CABYiri87Kni9+XkS2JWymxocJF9bCYpPswYFiBkeEOk6CSeMQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44169 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab2JJLay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 07:30:54 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so245788wey.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 04:30:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Recent tests on my test rack with 20G IB(iboip, 64k mtu, default
CUBIC, CFQ, LSI SAS 2108 w/ wb cache) interconnect shows a quite
fantastic performance - on both reads and writes Ceph completely
utilizing all disk bandwidth as high as 0.9 of theoretical limit of
sum of all bandwidths bearing in mind replication level. The only
thing that may bring down overall performance is a O_SYNC|O_DIRECT
writes which will be issued by almost every database server in the
default setup. Assuming that the database config may be untouchable
and somehow I can build very reliable hardware setup which `ll never
fail on power, should ceph have an option to ignore these flags? May
be there is another real-world cases for including such or I am very
wrong even thinking on fool client application in this way.

Thank you for any suggestion!
