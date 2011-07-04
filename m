From: Fusheng Han <fsh.han@gmail.com>
Subject: Availability question of RADOS
Date: Tue, 5 Jul 2011 00:25:18 +0800
Message-ID: <CAHq6muEghn-efzzgQLrkdRjsi40OhmeK9iN2nwB3OR_3AAJJ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39185 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab1GDQZS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 12:25:18 -0400
Received: by yxi11 with SMTP id 11so1632132yxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2011 09:25:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all

After reading the RADOS paper, I have some questions about
availability of RADOS. Nowhere I can find to discuss, so I'm here.
When adding new host to the cluster, some placement group will be
mapped to the new one. After the cluster info incremental propagates
to all the OSDs and clients, the client write operation will be
directed to the PG whose primary is at the new host. Before the new
host get the data migration down, it can not service these requests.
And due to the limitation of network bandwidth, the data migration may
take long. There is a long time that the new host can not service. I
got confused.
Do I miss something important in this paper?

Thank you all
Fusheng Han
