From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [bug report] libceph: revamp subs code, switch to SUBSCRIBE2 protocol
Date: Wed, 26 Feb 2020 16:31:07 +0100
Message-ID: <CAOi1vP-gSGMQRPpPTJYAAYCLH2c=R0oGqmTrHeUjBt-oFL_c1g@mail.gmail.com>
References: <20200226145927.jtuc5bgiojhoefad@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:37487 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgBZPbQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Feb 2020 10:31:16 -0500
Received: by mail-io1-f66.google.com with SMTP id c17so3783526ioc.4
        for <ceph-devel@vger.kernel.org>; Wed, 26 Feb 2020 07:31:16 -0800 (PST)
In-Reply-To: <20200226145927.jtuc5bgiojhoefad@kili.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 26, 2020 at 3:59 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Ilya Dryomov,
>
> The patch 82dcabad750a: "libceph: revamp subs code, switch to
> SUBSCRIBE2 protocol" from Jan 19, 2016, leads to the following static
> checker warning:
>
>         net/ceph/mon_client.c:495 ceph_monc_handle_map()
>         error: dereferencing freed memory 'monc->monmap'
>
> net/ceph/mon_client.c
>    466  static void ceph_monc_handle_map(struct ceph_mon_client *monc,
>    467                                   struct ceph_msg *msg)
>    468  {
>    469          struct ceph_client *client = monc->client;
>    470          struct ceph_monmap *monmap = NULL, *old = monc->monmap;
>                                                     ^^^^^^^^^^^^^^^^^^
>
>    471          void *p, *end;
>    472
>    473          mutex_lock(&monc->mutex);
>    474
>    475          dout("handle_monmap\n");
>    476          p = msg->front.iov_base;
>    477          end = p + msg->front.iov_len;
>    478
>    479          monmap = ceph_monmap_decode(p, end);
>    480          if (IS_ERR(monmap)) {
>    481                  pr_err("problem decoding monmap, %d\n",
>    482                         (int)PTR_ERR(monmap));
>    483                  ceph_msg_dump(msg);
>    484                  goto out;
>    485          }
>    486
>    487          if (ceph_check_fsid(monc->client, &monmap->fsid) < 0) {
>    488                  kfree(monmap);
>    489                  goto out;
>    490          }
>    491
>    492          client->monc.monmap = monmap;
>    493          kfree(old);
>                       ^^^
> Frees monc->monmap.

Hi Dan,

There is no bug here, see https://lists.openwall.net/netdev/2018/11/27/81.

I'll simplify this code and CC you on a patch.

Thanks,

                Ilya
