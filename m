From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 06/33] libceph: fixup error handling in osdmap_decode()
Date: Fri, 28 Mar 2014 16:56:16 +0200
Message-ID: <CALFYKtC67d5Qj7nQJQ200SV0qZVwP5kdOa2wAA6z1hjGtZiBXg@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-7-git-send-email-ilya.dryomov@inktank.com>
	<53347B28.7060607@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:59160 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaC1O4R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 10:56:17 -0400
Received: by mail-qg0-f51.google.com with SMTP id q108so997416qgd.10
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 07:56:17 -0700 (PDT)
In-Reply-To: <53347B28.7060607@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 9:25 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
>> The existing error handling scheme requires resetting err to -EINVAL
>> prior to calling any ceph_decode_* macro.  This is ugly and fragile,
>> and there already are a few places where we would return 0 on error,
>> due to a missing reset.  Fix this by adding a special e_inval label to
>> be used by all ceph_decode_* macros.
>
> I don't see where it's returning 0 on error, but I think this
> is a good change anyway.

Here:

        err = __decode_pool_names(p, end, map); <--
        if (err < 0) {
                dout("fail to decode pool names");
                goto bad;
        }

        ceph_decode_32_safe(p, end, map->pool_max, bad); <--

        ceph_decode_32_safe(p, end, map->flags, bad); <--

Or here (if at least one pg_temp mapping is present):

                err = __insert_pg_mapping(pg, &map->pg_temp); <--
                if (err)
                        goto bad;
                dout(" added pg_temp %lld.%x len %d\n", pgid.pool, pgid.seed,
                     len);
        }

        /* crush */
        ceph_decode_32_safe(p, end, len, bad); <--
        dout("osdmap_decode crush len %d from off 0x%x\n", len,
             (int)(*p - start));
        ceph_decode_need(p, end, len, bad); <--

And a lot more in osdmap_apply_incremental().  There are three ways out:

(1) a separate variable for helper retvals;
(2) resetting err to -EINVAL prior to each ceph_decode_* (if it's
    not already -EINVAL, of course);
(3) a separate e_inval label.

(3) is the only reasonable way to do this.  (1) leads to things like

    ret = foo_helper();
    if (ret) {
            err = ret;
            ...
    }

and (2) is error-prone and hardly maintainable.

>
> I'd use "einval" or "err_inval" instead of "e_inval".  But
> no matter.

We already use "e_inval" in osd_client.c (OK, that was me), so I'll
keep it for consistency.  I could rename them all to "Einval" to make
them stand out though (I see some "Efoo" labels in fs/).

Thanks,

                Ilya
