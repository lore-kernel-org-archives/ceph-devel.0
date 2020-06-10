From: norman <norman.kern@gmx.com>
Subject: Questions of QoS on ceph
Date: Wed, 10 Jun 2020 16:38:00 +0800
Message-ID: <b8eca4d9-e368-0f35-f3dc-6049d9a213fd@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:58897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgFJIiG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:38:06 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@redhat.com

Hi guys,

I want to setup a=C2=A0 ceph cluster for teams, using fs and s3 interface.=
 I
met a problem about the QoS: How can I limit the

bw or qps of a client to avoid the someone blocking others by running
lots of threads?

Best regards,

Norman Kern
