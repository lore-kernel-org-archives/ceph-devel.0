From: Vineet Jain <vinjvinj@gmail.com>
Subject: btrfs devs
Date: Fri, 8 Jul 2011 10:09:20 -0400
Message-ID: <CAG_bnfx-mR0-2KtMGgYcfW9hA5TKn+TFqKmOPRSYfOwSn2=vcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36120 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab1GHOJV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2011 10:09:21 -0400
Received: by bwd5 with SMTP id 5so1764029bwd.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2011 07:09:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Looking at the documentation here:

http://ceph.newdream.net/wiki/Cluster_configuration

you define a btrfs device as:

	btrfs devs = /dev/sdx

Is there any way to change the device to use UUID instead since sdx
can change between boots or when you replace hard drives.
