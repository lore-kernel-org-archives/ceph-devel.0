From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: __bitwise__ annotation in inttypes
Date: Fri, 12 Jul 2013 19:34:37 -0700
Message-ID: <CA+Hcz58VNyTnGg0eUaGoTbE_Y6YtV=tu3OS9k1LuOMKV5EScqA@mail.gmail.com>
References: <CA+Hcz5_iZhcC35Jda-Vc7HyQEN-QH76bpXdvU0eqEGVWYi+OdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:52051 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053Ab3GMCeh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 22:34:37 -0400
Received: by mail-ve0-f179.google.com with SMTP id d10so8761781vea.38
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jul 2013 19:34:37 -0700 (PDT)
In-Reply-To: <CA+Hcz5_iZhcC35Jda-Vc7HyQEN-QH76bpXdvU0eqEGVWYi+OdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Nevermind :) I see that is for freebsd..

On Fri, Jul 12, 2013 at 7:32 PM, Noah Watkins <noah.watkins@inktank.com> wrote:
> The following is in include/inttypes.h
>
>   #define __bitwise__
>
>   typedef __u16 __bitwise__ __le16;
>   typedef __u16 __bitwise__ __be16;
>   ...
>
> In linux, the same definition of __bitwise__ is used when not being
> run through Sparse.
>
> Is there any purpose in Ceph for _always_ removing those annotations,
> as is done here?
