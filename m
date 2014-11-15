From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: civetweb threads
Date: Sat, 15 Nov 2014 10:28:19 +0300
Message-ID: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:51266 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbaKOH2U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Nov 2014 02:28:20 -0500
Received: by mail-wi0-f180.google.com with SMTP id hi2so4709494wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 14 Nov 2014 23:28:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I am using civetweb in my radosgw, if I use "rgw thread pool size"
that is more than 1024, civetweb doesn't work.
e.g.
rgw thread pool size = 1024
rgw frontends = "civetweb port=80"

#ps aux -L | grep rados | wc -l
1096

everything works fine


If I use:
rgw thread pool size = 1025
rgw frontends = "civetweb port=80"

# ps aux -L | grep rados | wc -l
43

And http server is not listening.

If I don't use civetweb:
rgw thread pool size = 10240

# ps aux -L | grep rados | wc -l
10278

Regards

Mustafa Muhammad
