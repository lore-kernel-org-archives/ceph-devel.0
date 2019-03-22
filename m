From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
Date: Fri, 22 Mar 2019 16:07:50 +0100
Message-ID: <CAK8P3a0NXVt3znez-BtVpCX61sNWoJ6Q9XmJw6mJVzQkG6VCdQ@mail.gmail.com>
References: <20190322140819.300740-1-arnd@arndb.de> <CAOi1vP_=5gBUFLCofhaCNbMkfdwYNSkJ06Rmw-bJkLXNC4v8fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_=5gBUFLCofhaCNbMkfdwYNSkJ06Rmw-bJkLXNC4v8fA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Alex Elder <elder@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 22, 2019 at 3:40 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Fri, Mar 22, 2019 at 3:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Arnd,
>
> I don't like this because the initialization is no longer contained to
> ceph_oid_init().  Now there are two things to patch instead of one.
>
> How is this going to be fixed in other places?

The only other warning like this that I encountered was in
DECLARE_WAIT_QUEUE_HEAD_ONSTACK().

So far, I have no idea for how to solve it, other than disabling
CONFIG_LOCKDEP when clang is used.

Would you prefer this version?

#define CEPH_OID_INITIALIZER(oid) { .name = (oid).inline_name }
#define CEPH_DEFINE_OID_ONSTACK(oid)                            \
        struct ceph_object_id oid = CEPH_OID_INITIALIZER(oid)

static inline void ceph_oid_init(struct ceph_object_id *oid)
{
        *oid = (struct ceph_object_id)CEPH_OID_INITIALIZER(*oid);
}




       Arnd
