From: Ning Yao <zay11022@gmail.com>
Subject: centos7 systemd issue for two different clusters on the same host
Date: Tue, 22 Mar 2016 11:06:59 +0800
Message-ID: <CALZt5jwoVxYmF8z9cdmNQtq-t_n0GuXAy7Ar6pQLVfBR5e10Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35937 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcCVDHB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 23:07:01 -0400
Received: by mail-wm0-f49.google.com with SMTP id r129so74263783wmr.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 20:07:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

we deploy two different clusters on the same bunch of bare metal
machines. However, systemd task the Environment parameter to tell
which cluster we operate. Thus, we need to use the first cluster
CLUSTER=cephrbd to startup the osd,mon for our first cluster, and then
switch to the CLUSTER=cephrgw to start the components of the second
cluster. And  now, we operate directly with the ceph-osd command to
start osd in different cluster for a convenience. Any solutions such
like a outlier wrapper shell script we can pass the parameter to tell
which cluster we want to start.

Regards
Ning Yao
