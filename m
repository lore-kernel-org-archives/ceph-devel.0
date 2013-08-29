From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: radosgw 0.67.2 update -> "ERROR: failed to initialize watch"
Date: Thu, 29 Aug 2013 11:53:48 +0200
Message-ID: <CAF6-1L66AG8a1N0ujFvAbYYgXTZ41ug6HtiLvPY8c_AEriHXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46941 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900Ab3H2Jxt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 05:53:49 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so710324pab.13
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 02:53:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I just updated our test cluster to 0.67.2+ (latest dumpling branch) (
from 0.61.x ) and radosgw refuses to start.


2013-08-29 11:46:34.915552 7ffccbc3d780  0 ceph version
0.67.2-19-gc81bc5b (c81bc5b59dda37f54c02039ca3d5aada64076624), process
lt-radosgw, pid 30404
2013-08-29 11:46:34.915598 7ffccbc3d780 -1 WARNING: libcurl doesn't
support curl_multi_wait()
2013-08-29 11:46:34.915612 7ffccbc3d780 -1 WARNING: cross zone /
region transfer performance may be affected
2013-08-29 11:46:34.935674 7ffcb2ffd700  2
RGWDataChangesLog::ChangesRenewThread: start
2013-08-29 11:46:34.937337 7ffccbc3d780 -1 ERROR: failed to initialize watch
2013-08-29 11:46:34.939135 7ffccbc3d780 -1 Couldn't init storage
provider (RADOS)

in RGWRados::init_watch(), it seems that :

const char *control_pool = zone.control_pool.name.c_str()

returns an empty string which is really suspect ...


Cheers,

    Sylvain
