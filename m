From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/28] block: rdb: false-postive gcc-4.9 -Wmaybe-uninitialized
Date: Tue, 18 Oct 2016 12:04:37 +0200
Message-ID: <11351333.Y86c2RWQE1@wuerfel>
References: <20161017220342.1627073-1-arnd@arndb.de> <20161017221037.1781185-2-arnd@arndb.de> <CAOi1vP-N-Qp4_LU=MMoPp+wH5t+JoDxFsVgMa=65CBO=HTV_DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP-N-Qp4_LU=MMoPp+wH5t+JoDxFsVgMa=65CBO=HTV_DA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Mike Christie <mchristi@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tuesday, October 18, 2016 11:57:33 AM CEST Ilya Dryomov wrote:
> It already got silenced by initializing at declaration in one of the
> downstream trees, so I'd rather we do
> 
> @@ -3756,7 +3819,7 @@ static void rbd_watch_cb(void *arg, u64
> notify_id, u64 cookie,
>         struct rbd_device *rbd_dev = arg;
>         void *p = data;
>         void *const end = p + data_len;
> -       u8 struct_v;
> +       u8 struct_v = 0;
>         u32 len;
>         u32 notify_op;
>         int ret;
> 
> to reduce the churn.

Fair enough. I try to avoid adding extraneous initializations like
this, but my suggested change is not all that different here,
except if ceph_start_decoding() got changed in a way that could
lead to another uninitialized use.

> The "block" prefix is redundant and "rdb" should be "rbd" in the subject.

Oops.

	Arnd
