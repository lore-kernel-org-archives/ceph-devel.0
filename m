From: Christian Brunner <christian@brunner-muc.de>
Subject: protocol version mismatch
Date: Fri, 2 Mar 2012 10:19:57 +0100
Message-ID: <CAJafhzSp7eHZ_nQBFAtGO3p02470munOPKswpR3BOtVb9K69-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32931 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757836Ab2CBJT6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 04:19:58 -0500
Received: by wibhm2 with SMTP id hm2so469550wib.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Mar 2012 01:19:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've just updated our ceph-cluster from 0.39 to 0.42.2. Now I'm seeing
a lot of messages like these in the OSD log:

Mar  2 10:15:43 os00 osd.003[15096]: 7f0b9831c700 --
10.255.0.60:6821/15095 >> 10.255.0.61:6812/22474 pipe(0x2e74100 sd=47
pgs=0 cs=0 l=0).connect protocol version mismatch, my 9 != 0
Mar  2 10:15:44 os00 osd.000[14377]: 7fa07d660700 --
10.255.0.60:6802/14376 >> 10.255.0.61:6818/22919 pipe(0x2c92d00 sd=24
pgs=0 cs=0 l=0).connect protocol version mismatch, my 9 != 0
Mar  2 10:15:44 os00 osd.000[14377]: 7fa07d55f700 --
10.255.0.60:6802/14376 >> 10.255.0.61:6815/22697 pipe(0x32a9900 sd=32
pgs=0 cs=0 l=0).connect protocol version mismatch, my 9 != 0
Mar  2 10:15:44 os00 osd.002[14898]: 7f1e52ea6700 --
10.255.0.60:6817/14897 >> 10.255.0.63:6813/10357 pipe(0x3a82800 sd=32
pgs=0 cs=0 l=0).connect protocol version mismatch, my 9 != 0
Mar  2 10:15:44 os00 osd.002[14898]: 7f1e52fa7700 --
10.255.0.60:6817/14897 >> 10.255.0.63:6806/10448 pipe(0x3a81180 sd=30
pgs=0 cs=0 l=0).connect protocol version mismatch, my 9 != 0
Mar  2 10:15:44 os00 osd.002[14898]: 7f1e531a9700 --
10.255.0.60:6817/14897 >> 10.255.0.63:6807/10265 pipe(0x3a80280 sd=34
pgs=0 cs=0 l=0).connect protocol version mismatch, my 9 != 0
Mar  2 10:15:45 os00 osd.002[14898]: 7f1e542ba700 --
10.255.0.60:6817/14897 >> 10.255.0.61:6821/23156 pipe(0x413d000 sd=40
pgs=0 cs=0 l=0).connect protocol version mismatch, my 9 != 0

10.255.0.60 - 10.255.0.63 are our OSD hosts.

Is there anything I can do about this? (Everything seems to be working...).

Regards,
Christian
