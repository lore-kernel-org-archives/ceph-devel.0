From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW: Pools .rgw .rgw.control .users.uid .users.email .users
Date: Mon, 5 Nov 2012 18:04:20 -0800
Message-ID: <CAC-hyiFu+YUe7s6dtKrcb1xMa273fL-=0d=U+U0MZ92gvYxaPA@mail.gmail.com>
References: <CAF6-1L48MVb724sP6=msrd2ry2T38Psu+d+FnuqnTW0cFekSgA@mail.gmail.com>
	<CAC-hyiHke+pw17Xrf04nK95hQqUDRwDX_M2UzzxpbUfMsOSnTA@mail.gmail.com>
	<CAF6-1L4QWSYqXt7WMa2oNgp4WCB9zXN7VB8vumhd4TJ42N4uUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59317 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933421Ab2KFCEV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 21:04:21 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so6542009vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 18:04:20 -0800 (PST)
In-Reply-To: <CAF6-1L4QWSYqXt7WMa2oNgp4WCB9zXN7VB8vumhd4TJ42N4uUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Nov 5, 2012 at 4:11 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>>> Also, I assume those pools will actually be pretty small and so I can
>>> just leave them with PG_NUM=8 without much issue ?
>>>
>>
>> Data will not be distributed evenly across the cluster, and there may
>> be a high contention on these pgs so it'd affect performance.
>
> But what is stored in those exactly ?
> Is it documented somewhere ?
>
> I now recreated them with more pg_num, but why are they created with
> only 8 by default if that's not appropriate ?

Currently librados creates 8 pgs by default, and rgw just uses
librados for that matter. I do agree that it's a too low default, and
iirc there has been some recent discussion about fixing that.

> I just want to avoid having too many pools with too many PGs, I guess
> that's not good either ...
>
