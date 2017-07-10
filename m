From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: fix old style declaration warnings
Date: Mon, 10 Jul 2017 15:17:55 +0200
Message-ID: <CAOi1vP_xde-57RUacagm=gr9Q5sXsw44DZPqbyKrKU4wmnoduw@mail.gmail.com>
References: <20170710111734.856154-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710111734.856154-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Jul 10, 2017 at 1:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The new macros don't follow the usual style for declarations,
> which we get a warning for with 'make W=1':
>
> In file included from fs/ceph/mds_client.c:16:0:
> include/linux/ceph/ceph_features.h:74:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]
>
> This moves the 'static' keyword to the front of the
> declaration.
>
> Fixes: f179d3ba8cb9 ("libceph: new features macros")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

Thanks,

                Ilya
