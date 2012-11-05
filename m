From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RGW: Pools .rgw .rgw.control .users.uid .users.email .users
Date: Mon, 5 Nov 2012 13:11:24 +0100
Message-ID: <CAF6-1L4QWSYqXt7WMa2oNgp4WCB9zXN7VB8vumhd4TJ42N4uUQ@mail.gmail.com>
References: <CAF6-1L48MVb724sP6=msrd2ry2T38Psu+d+FnuqnTW0cFekSgA@mail.gmail.com>
	<CAC-hyiHke+pw17Xrf04nK95hQqUDRwDX_M2UzzxpbUfMsOSnTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56992 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab2KEMLZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 07:11:25 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5768966vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 04:11:24 -0800 (PST)
In-Reply-To: <CAC-hyiHke+pw17Xrf04nK95hQqUDRwDX_M2UzzxpbUfMsOSnTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

Hi,

>> Also, I assume those pools will actually be pretty small and so I can
>> just leave them with PG_NUM=8 without much issue ?
>>
>
> Data will not be distributed evenly across the cluster, and there may
> be a high contention on these pgs so it'd affect performance.

But what is stored in those exactly ?
Is it documented somewhere ?

I now recreated them with more pg_num, but why are they created with
only 8 by default if that's not appropriate ?
I just want to avoid having too many pools with too many PGs, I guess
that's not good either ...


Cheers,

     Sylvan
