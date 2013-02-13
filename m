From: Sam Lang <sam.lang@inktank.com>
Subject: Re: optimizing ceph-fuse performance
Date: Wed, 13 Feb 2013 10:07:40 -0600
Message-ID: <CAKMAVE9bv9k=KZL+3O7_PTm9aPCvERce1q75L2hdUZNADHnVJg@mail.gmail.com>
References: <CAPhYxPzLpw5H9W4LxCaWWeOPRYwVsSJb7h1OgQzswbCMT9S_xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:55795 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759820Ab3BMQHk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 11:07:40 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so1420500oag.23
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 08:07:40 -0800 (PST)
In-Reply-To: <CAPhYxPzLpw5H9W4LxCaWWeOPRYwVsSJb7h1OgQzswbCMT9S_xA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 13, 2013 at 6:31 AM, femi anjorin <femi.anjorin@gmail.com> wrote:
> Hi,
>
> Pls can somebody help interprete what this configuration signify.
>
> [global]
>         debug ms = 0
>
> [mon]
>         debug mon = 20
>         debug paxos = 20
>         debug auth = 20
>
> [osd]
>         debug osd = 20
>         debug filestore = 20
>         debug journal = 20
>         debug monc = 20
>
> [mds]
>         debug mds = 20
>         debug mds balancer = 20
>         debug mds log = 20
>         debug mds migrator = 20

femi,

If you're not debugging a specific problem that you've run into, you
should remove all those debug lines from your config and restart the
servers.

>
>
>  I used the same configuration and my boot disk got full
>
> ceph-mds.a.log =  50299281408
> ceph-mon.a.log = 173858816
>
> Moreover the results of my test using ceph-fuse to mount a share and
> exportiing the share with samba isn't so good... How can i turn off
> some of the logs to optimize ceph performance in a write,read and
> delete operations. I will publish the result as soon as i can get the
> cluster more optimized.

I'm curious, how are you re-exporting over samba?
-sam

>
>
> regards.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
