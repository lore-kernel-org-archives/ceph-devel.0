From: Colin Ian King <colin.king@canonical.com>
Subject: bug report: re: vfs: Convert ceph to use the new mount API
Date: Mon, 8 Jul 2019 22:31:32 +0100
Message-ID: <2b919604-282e-85d6-b9d8-827beefdcb0d@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

Static analysis with Coverity on linux-next has detected an
uninitialized variable error in the following commit:

commit 108f95bfaa5665724159e66e4a26206b5589f126
Author: David Howells <dhowells@redhat.com>
Date:   Mon Mar 25 16:38:32 2019 +0000

    vfs: Convert ceph to use the new mount API


Specifically, in fs/ceph/super.c in function ceph_real_mount, variable
err is not initialized, and when the if (!fsc->sb->s_root) code block is
not executed then err is never assigned and an uninitialized value is
returned:

 884        mutex_unlock(&fsc->client->mount_mutex);

Uninitialized scalar variable (UNINIT)
uninit_use: Using uninitialized value err.

 885        return err;
 886
 887 out:
 888        mutex_unlock(&fsc->client->mount_mutex);
 889        return err;
 890 }

Not sure what err should be returning, so I'm reporting this a as bug.

Colin
