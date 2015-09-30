From: "Yan, Zheng" <zyan@redhat.com>
Subject: [BUG] commit "namei: d_is_negative() should be checked before ->d_seq validation" breaks ceph-fuse
Date: Wed, 30 Sep 2015 20:53:22 +0800
Message-ID: <C096DBE6-9E22-48BA-B449-375F5AD6E177@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi, Al

I found that commit 766c4cbfac "namei: d_is_negative() should be checke=
d before ->d_seq validation=E2=80=9D  breaks ceph-fuse. After that comm=
it,  lookup_fast can return -ENOENT before calling d_revalidate(). This=
 breaks remote filesystems which allows creating/deleting files from mu=
ltiple machines.=20

Regards
Yan, Zheng--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
