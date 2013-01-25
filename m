From: =?ISO-8859-1?Q?Alexis_G=DCNST_HORN?=
	<alexis.gunsthorn@outscale.com>
Subject: RadosGW and credentials database
Date: Fri, 25 Jan 2013 08:49:52 +0100
Message-ID: <CAEqYNSY+hgVdTYboYM0+aHM0tfdbHze2MH+MdjrrM9A4-gGuPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:35220 "HELO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751135Ab3AYHtz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 Jan 2013 02:49:55 -0500
Received: by mail-ie0-f199.google.com with SMTP id 10so31017ied.6
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 23:49:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I've a very special question about Radosgw and creds database.

In fact, I have my own db with the (access_key, secret_key) couple. My
idea was to link my db with the radosgw one.

Is there a way to do so ? Or, a way to write a little plugin to give
Ceph the ability to speak directly with my db instead of its own ?

Thanks

Alexis
