From: Asias He <asias.hejun@gmail.com>
Subject: [wiki] debian package setup error
Date: Wed, 26 May 2010 10:39:08 +0800
Message-ID: <1274841548.11302.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62314 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933384Ab0EZCjB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 22:39:01 -0400
Received: by pxi18 with SMTP id 18so2267438pxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 May 2010 19:39:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Can anybody update the wiki page[1] for debian package setup.

From:
deb http://ceph.newdream.net/debian/ lenny ceph-testing
deb-src http://ceph.newdream.net/debian/ lenny ceph-testing
To:
deb http://ceph.newdream.net/debian/ testing ceph-testing
deb-src http://ceph.newdream.net/debian/ testing ceph-testing

From:
deb http://ceph.newdream.net/debian/ lenny ceph-unstable
deb-src http://ceph.newdream.net/debian/ lenny ceph-unstable
To:
deb http://ceph.newdream.net/debian/ unstable ceph-unstable
deb-src http://ceph.newdream.net/debian/ unstable ceph-unstable


[1] http://ceph.newdream.net/wiki/Debian
-- 
Best Regards
Asias He

