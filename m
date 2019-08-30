From: Colin Ian King <colin.king@canonical.com>
Subject: bug report: libceph: follow redirect replies from osds
Date: Fri, 30 Aug 2019 15:05:28 +0100
Message-ID: <3a4ff829-7302-7201-81c2-a557fe35afc8@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, ceph-devel@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

Static analysis with Coverity has picked up an issue with commit:

commit 205ee1187a671c3b067d7f1e974903b44036f270
Author: Ilya Dryomov <ilya.dryomov@inktank.com>
Date:   Mon Jan 27 17:40:20 2014 +0200

    libceph: follow redirect replies from osds

Specifically in function ceph_redirect_decode in net/ceph/osd_client.c:

3485
3486        len = ceph_decode_32(p);

CID 17904: Unused value (UNUSED_VALUE)

3487        *p += len; /* skip osd_instructions */
3488
3489        /* skip the rest */
3490        *p = struct_end;

The double write to *p looks wrong, I suspect the *p += len; should be
just incrementing pointer p as in: p += len.  Am I correct to assume
this is the correct fix?

Colin
