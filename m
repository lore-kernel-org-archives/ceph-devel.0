From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: bug report: libceph: follow redirect replies from osds
Date: Fri, 30 Aug 2019 16:26:33 +0200
Message-ID: <CAOi1vP9x1SS9YGFgHuZcpga5fTYac-y3vazsAKr9N8WJB7-hpA@mail.gmail.com>
References: <3a4ff829-7302-7201-81c2-a557fe35afc8@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a4ff829-7302-7201-81c2-a557fe35afc8@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, Ceph Development <ceph-devel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Aug 30, 2019 at 4:05 PM Colin Ian King <colin.king@canonical.com> wrote:
>
> Hi,
>
> Static analysis with Coverity has picked up an issue with commit:
>
> commit 205ee1187a671c3b067d7f1e974903b44036f270
> Author: Ilya Dryomov <ilya.dryomov@inktank.com>
> Date:   Mon Jan 27 17:40:20 2014 +0200
>
>     libceph: follow redirect replies from osds
>
> Specifically in function ceph_redirect_decode in net/ceph/osd_client.c:
>
> 3485
> 3486        len = ceph_decode_32(p);
>
> CID 17904: Unused value (UNUSED_VALUE)
>
> 3487        *p += len; /* skip osd_instructions */
> 3488
> 3489        /* skip the rest */
> 3490        *p = struct_end;
>
> The double write to *p looks wrong, I suspect the *p += len; should be
> just incrementing pointer p as in: p += len.  Am I correct to assume
> this is the correct fix?

Hi Colin,

No, the double write to *p is correct.  It skips over len bytes and
then skips to the end of the redirect reply.  There is no bug here but
we could drop

  len = ceph_decode_32(p);
  *p += len; /* skip osd_instructions */

and skip to the end directly to make Coverity happier.

Thanks,

                Ilya
