From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] 66bda1: auth: change default: require
 'cephx' for daemons
Date: Mon, 22 Oct 2012 11:18:01 -0700
Message-ID: <CAPYLRziveMKeoGpD3TcyZqw8+Lt3WM033AdpHUK=jgE5VtK-8Q@mail.gmail.com>
References: <50841d54c416e_32141173ae4158726@sh2.rs.github.com.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:62454 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2JVSSE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 14:18:04 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1805450lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 11:18:02 -0700 (PDT)
In-Reply-To: <50841d54c416e_32141173ae4158726@sh2.rs.github.com.mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

On Sun, Oct 21, 2012 at 9:05 AM, GitHub <noreply@github.com> wrote:
>   Branch: refs/heads/master
>   Home:   https://github.com/ceph/ceph
>   Commit: 66bda162e1acad34d37fa97e3a91e277df174f42
>       https://github.com/ceph/ceph/commit/66bda162e1acad34d37fa97e3a91e277df174f42
>   Author: Sage Weil <sage@inktank.com>
>   Date:   2012-10-21 (Sun, 21 Oct 2012)
>
>   Changed paths:
>     M src/common/config_opts.h
>
>   Log Message:
>   -----------
>   auth: change default: require 'cephx' for daemons
>
> Daemons will require cephx.
>
> Clients will require nothing (i.e., will be able to connect to a cluster
> with auth disabled).
>
> See #3136
>
> Signed-off-by: Sage Weil <sage@inktank.com>

I know we've talked about doing this in the past, but delayed until
Cephx was better documented (and easier to work with?). Are we sure
that we've passed the point where this is going to work for users on
the first try?
