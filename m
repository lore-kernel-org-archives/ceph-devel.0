From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: protect pending flags in ceph_con_keepalive()
Date: Mon, 14 Jan 2019 21:37:25 +0100
Message-ID: <CAOi1vP-FC+X+DeLMBcefYuSjxzLgAsxQg+RNskaZsUvVbmXuYA@mail.gmail.com>
References: <20181227190842.GA19565@myunghoj-Precision-5530>
 <CAOi1vP9G=-ZLBKH6Y5MoDRUjX4YkN6GUWKm1=fnM02odQX8GWA@mail.gmail.com> <20190103035027.GA26674@myunghoj-Precision-5530>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103035027.GA26674@myunghoj-Precision-5530>
Sender: linux-kernel-owner@vger.kernel.org
To: Myungho Jung <mhjungk@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Jan 3, 2019 at 4:50 AM Myungho Jung <mhjungk@gmail.com> wrote:
> I reproduced on vm using syzkaller utils and verified the fix by syzbot.

Hi Myungho,

I think this might be a better fix:

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d5718284db57..c5f5313e3537 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3205,10 +3205,11 @@ void ceph_con_keepalive(struct ceph_connection *con)
 {
        dout("con_keepalive %p\n", con);
        mutex_lock(&con->mutex);
+       con_flag_set(con, CON_FLAG_KEEPALIVE_PENDING);
        clear_standby(con);
        mutex_unlock(&con->mutex);
-       if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
-           con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
+
+       if (con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
                queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_keepalive);

WRITE_PENDING can be set without con->mutex held from socket callbacks.
This is the reason we use atomic bit ops here, so testing WRITE_PENDING
under the lock didn't make sense to me.

At the same time, KEEPALIVE_PENDING could have been a non-atomic flag.
I spent some time trying to make sense of conditioning queue_con() call
on the previous value of KEEPALIVE_PENDING and couldn't see any, so I'm
setting it with con_flag_set(), making ceph_con_keepalive() symmetric
with ceph_con_send().

Thanks,

                Ilya
