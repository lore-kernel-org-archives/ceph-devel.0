From: liuchang0812 <liuchang0812@gmail.com>
Subject: Question about Logging Level
Date: Thu, 12 Jan 2017 16:12:10 +0800
Message-ID: <CACKY0b-_ZaLCVUwdW4-p6BtPeaAHQ10B-KqjmxuM+Nh5h_xj5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177]:35323 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdALIML (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 03:12:11 -0500
Received: by mail-yb0-f177.google.com with SMTP id l23so3565420ybj.2
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 00:12:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

In our documentation, it says that:

        Ceph=E2=80=99s logging levels operate on a scale of 1 to 20, where =
1
is terse and 20 is verbose.

http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/#subsy=
stem-log-and-debug-settings


But, it seems that there are some logging levels 25 :


mds/MDBalancer.cc:276:  dout(25) << "=3D=3D=3D got heartbeat " <<
m->get_beat() << " from " << m->get_source().num() << " " <<
m->get_load() << dendl;
mds/CInode.cc:4189:  dout(25) << __func__ << dendl;
mds/MDCache.cc:11656:    //dout(25) << "saw depth " << d << " " <<
*dir << dendl;
mds/MDCache.cc:11666:   //dout(25) << " saw sub " << **p << dendl;
mds/journal.cc:373:      dout(25) << "EMetaBlob::add_dir_context(" <<
dir << ")      maybe " <<


So, shoud we update our documentation, or update logging level to 20?
