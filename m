From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Using RADOS
Date: Tue, 20 Sep 2011 13:14:56 +0530
Message-ID: <CAMiHsJ+XqtaBJVAzf3NBPTp3Con-5R0tneyadKB9Nvb9wvWJVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40920 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1ITHpR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 03:45:17 -0400
Received: by bkbzt4 with SMTP id zt4so206272bkb.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2011 00:45:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello friends

Since there is no Ceph User's mailing list, I am posting my doubt here.

I want to use the Ceph object store capabilities. I have already
installed and setup a Ceph cluster.

As a first step, I want to be able to GET/PUT or read/write to the
object store of my cluster. I would prefer a HTTP/REST interface but
please let me know of other interfaces that exist for performing
read/writes to ceph object store/RADOS.

Final goal: Besides normal read/writes, I also want to be able to have
some objects, which point to no data. That is, I want to have a
special flag, which if set, would mean there is no data pointed to by
this Object ID. If its unset, it means its like a normal object
pointing to some data file(s). I want to have the freedom to be able
to set/unset this flag and hence be able to delete/re-insert the
corresponding data file(s) against the same object ID. Do we have an
API which could allow me such functionality?

Please point me to suitable links/starting points.

Thanks
Atish
