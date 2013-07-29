From: Samuel Just <sam.just@inktank.com>
Subject: blueprint: RADOS Object Temperature Monitoring
Date: Mon, 29 Jul 2013 16:04:40 -0700
Message-ID: <CA+4uBUYzoUYKx9MAkVT7V9USkcHXJvZbgEVcRQf138q_q6GOyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:60775 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab3G2XEl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 19:04:41 -0400
Received: by mail-vc0-f181.google.com with SMTP id hz10so2515852vcb.26
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 16:04:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've created a blueprint for a RADOS level mechanism for discovering
cold objects.

http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/RADOS_Object_Temperature_Monitoring

Such a mechanism will be crucial to future tiering implementations.
If you are interested in discussing this at CDS, please add yourself
as an interested party to the blueprint!
-Sam
