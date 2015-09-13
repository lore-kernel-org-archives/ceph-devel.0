From: Ilya Dryomov <idryomov@gmail.com>
Subject: size_t and related types on mn10300
Date: Sun, 13 Sep 2015 14:07:10 +0300
Message-ID: <CAOi1vP9T8q5asgfdECVNxhSUAwCFN9SapPp3h-0ySc1Wg4s6wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Sep 10, 2015 at 10:57 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   22dc312d56ba077db27a9798b340e7d161f1df05
> commit: 5f1c79a71766ba656762636936edf708089bdb14 [12335/12685] libceph: check data_len in ->alloc_msg()
> config: mn10300-allmodconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 5f1c79a71766ba656762636936edf708089bdb14
>   # save the attached .config to linux build tree
>   make.cross ARCH=mn10300
>
> All warnings (new ones prefixed by >>):
>
>    net/ceph/osd_client.c: In function 'get_reply':
>>> net/ceph/osd_client.c:2865:3: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]
>       pr_warn("%s osd%d tid %llu data %d > preallocated %zu, skipping\n",
>       ^
>
> vim +2865 net/ceph/osd_client.c
>
>   2849                       req->r_reply, req->r_reply->con);
>   2850          ceph_msg_revoke_incoming(req->r_reply);
>   2851
>   2852          if (front_len > req->r_reply->front_alloc_len) {
>   2853                  pr_warn("%s osd%d tid %llu front %d > preallocated %d\n",
>   2854                          __func__, osd->o_osd, req->r_tid, front_len,
>   2855                          req->r_reply->front_alloc_len);
>   2856                  m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front_len, GFP_NOFS,
>   2857                                   false);
>   2858                  if (!m)
>   2859                          goto out;
>   2860                  ceph_msg_put(req->r_reply);
>   2861                  req->r_reply = m;
>   2862          }
>   2863
>   2864          if (data_len > req->r_reply->data_length) {
>> 2865                  pr_warn("%s osd%d tid %llu data %d > preallocated %zu, skipping\n",
>   2866                          __func__, osd->o_osd, req->r_tid, data_len,
>   2867                          req->r_reply->data_length);
>   2868                  m = NULL;
>   2869                  *skip = 1;
>   2870                  goto out;
>   2871          }
>   2872
>   2873          m = ceph_msg_get(req->r_reply);

req->r_reply->data_length is size_t, formatted with %zu, as it should
be.  I think this is a problem with either mn10300 itself or the build
toolchain - compiling mn10300 defconfig throws a whole bunch of similar
errors all over the place.

arch/mn10300/include/uapi/asm/posix_types.h
 30 #if __GNUC__ == 4
 31 typedef unsigned int    __kernel_size_t;
 32 typedef signed int      __kernel_ssize_t;
 33 #else
 34 typedef unsigned long   __kernel_size_t;
 35 typedef signed long     __kernel_ssize_t;
 36 #endif

This came from commit 3ad001c04f1a ("MN10300: Fix size_t and ssize_t")
by David.  Now, if that's right, it should probably be >= 4.  But then

$ echo | /opt/gcc-4.9.0-nolibc/am33_2.0-linux/bin/am33_2.0-linux-gcc
-dM -E - | grep __SIZE_TYPE__
#define __SIZE_TYPE__ long unsigned int

and sure enough

gcc/config/mn10300/linux.h
 87 #undef SIZE_TYPE
 88 #undef PTRDIFF_TYPE
 89 #undef WCHAR_TYPE
 90 #undef WCHAR_TYPE_SIZE

gcc/config/mn10300/mn10300.h
125 #undef  SIZE_TYPE
126 #define SIZE_TYPE "unsigned int"

so it looks like "linux" variant uses gcc defaults, at least since
gcc.git commit 05381348ac78 (which is dated a few months after David's
commit made it into the kernel).  Can someone who cares about mn10300
or at least knows what it is look at this?

Thanks,

                Ilya
