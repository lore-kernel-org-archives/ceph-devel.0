From: kefu chai <tchaikov@gmail.com>
Subject: NVMEDevice.cc fails to build
Date: Wed, 10 Feb 2016 20:07:51 +0800
Message-ID: <CAJE9aOPODHBXtUJfxY9YF6s5-0=yJey3BBm=gYJds5v-e8+yPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35137 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcBJMNi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 07:13:38 -0500
Received: by mail-yw0-f173.google.com with SMTP id g127so12335914ywf.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 04:13:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, haomai@xsky.org

hi haomai,

the build WITH_SPDK fails after
bd694d4a6d6367c29c1935c906fe8059dd1368dc and
b62318ea16d5830bb2b23b1a95ca39a5310fac34, could you update the
NVMEDevices accordingly?

thanks,

-- 
Regards
Kefu Chai
