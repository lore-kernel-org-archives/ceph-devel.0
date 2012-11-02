From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW: Pools .rgw .rgw.control .users.uid .users.email .users
Date: Fri, 2 Nov 2012 12:20:18 -0700
Message-ID: <CAC-hyiHke+pw17Xrf04nK95hQqUDRwDX_M2UzzxpbUfMsOSnTA@mail.gmail.com>
References: <CAF6-1L48MVb724sP6=msrd2ry2T38Psu+d+FnuqnTW0cFekSgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38818 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab2KBTUT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 15:20:19 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1488749bkc.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 12:20:18 -0700 (PDT)
In-Reply-To: <CAF6-1L48MVb724sP6=msrd2ry2T38Psu+d+FnuqnTW0cFekSgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Nov 2, 2012 at 8:20 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
> I've just started RGW and it created some pools automatically :
> .rgw .rgw.control .users.uid .users.email .users
>
> But when looking at them, they used PG_NUM=8 which is a bit low.
> Now, I noticed it and created .rgw.buckets myself with an appropriate
> PG_NUM, I assume it will work or is there some special setup done by
> rgw beside just creating the pool ?

No. Just creating them.

>
> Also, I assume those pools will actually be pretty small and so I can
> just leave them with PG_NUM=8 without much issue ?
>

Data will not be distributed evenly across the cluster, and there may
be a high contention on these pgs so it'd affect performance.

Yehuda
