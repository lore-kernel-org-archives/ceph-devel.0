From: John Axel Eriksson <john@insane.se>
Subject: Ceph questions regarding auth and return on PUT from radosgw
Date: Mon, 11 Jun 2012 14:32:53 +0200
Message-ID: <CAMmJxtJyzaqwV2+BgrHwMZSWiLJKhM7948MUuEme-MGjZofuWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59497 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab2FKMcx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 08:32:53 -0400
Received: by obbtb18 with SMTP id tb18so6679421obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 05:32:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is there a point to having auth enabled if I run ceph on an internal
network, only for use with radosgw (i.e the object storage part)?
It seems to complicate the setup unnecessarily and ceph doesn't use
encryption anyway as far as I understand, it's only auth.
If my network is trusted and I know who has access (and I trust them)
- is there a point to complicate the setup with key-based auth?

Also, when PUTting something through radosgw, does ceph/rgw return as
soon as all data has been received or does it return
when it has ensured N replicas? (I've seen quite a delay after all
data has been sent before my PUT returns). I'm using nginx (1.2) by
the way.

Thanks!

John
