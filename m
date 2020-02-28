From: Colin Ian King <colin.king@canonical.com>
Subject: re: libceph: follow redirect replies from osds
Date: Fri, 28 Feb 2020 12:46:11 +0000
Message-ID: <6ea7e486-a3f3-7def-1f88-2e645e3b9780@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.co>, ceph-devel@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

Static analysis with Coverity has detected a potential issue in the
following commit in function ceph_redirect_decode():

commit 205ee1187a671c3b067d7f1e974903b44036f270
Author: Ilya Dryomov <ilya.dryomov@inktank.com>
Date:   Mon Jan 27 17:40:20 2014 +0200

    libceph: follow redirect replies from osds

The issue is as follows:


3486        len = ceph_decode_32(p);

Unused value (UNUSED_VALUE)
assigned_pointer: Assigning value from len to *p here, but that stored
value is overwritten before it can be used.

3487        *p += len; /* skip osd_instructions */
3488
3489        /* skip the rest */

value_overwrite: Overwriting previous write to *p with value from
struct_end.

3490        *p = struct_end;

The *p assignment in line 3487 is effectively being overwritten by the
*p assignment in 3490.  Maybe the following is correct:

        len = ceph_decode_32(p);
-       p += len; /* skip osd_instructions */
+       struct_end = *p + len;  /* skip osd_instructions */

        /* skip the rest */
        *p = struct_end;

I'm not familiar with the ceph structure here, so I'm not sure what the
correct fix would be.

Colin
