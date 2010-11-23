From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: patch for ceph linux kernel client bug #552 "Samba with kernel
 oplocks=on produces lots of corrupt mds entries in dmesg" (fwd)
Date: Tue, 23 Nov 2010 14:03:50 -0800
Message-ID: <AANLkTinmq9WF61QUna1gdPCY8ZRZQ3_LjPEjHTpxftMg@mail.gmail.com>
References: <Pine.LNX.4.64.1011230918060.26130@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35104 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0KWWDw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 17:03:52 -0500
Received: by pxi15 with SMTP id 15so2213167pxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Nov 2010 14:03:52 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1011230918060.26130@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Herb Shiu <herb_shiu@tcloudcomputing.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Henry C Chang <henry_c_chang@tcloudcomputing.com>

Herb:
Pulled these into our trees, although I broke up the client changes
into a few commits.
Hope it's okay that I added your signed-off-by. :)
-Greg

On Tue, Nov 23, 2010 at 9:18 AM, Sage Weil <sage@newdream.net> wrote:
>
>
> ---------- Forwarded message ----------
> Date: Tue, 23 Nov 2010 17:54:25 +0800
> From: Herb Shiu <herb_shiu@tcloudcomputing.com>
> To: sage@newdream.net
> Cc: henry_c_chang@tcloudcomputing.com
> Subject: patch for ceph linux kernel client bug #552
> =A0 =A0"Samba with kernel oplocks=3Don produces lots of corrupt mds e=
ntries in dmesg"
>
> Hi Sage,
> The root cause is that we don't handle the fcntl F_GETLK request well=
=2E
> To correct it, we need to update MDS & ceph kclient.
> Here are the two updates,
>
> MDS:
> https://github.com/tcloud/ceph/commit/9e66d2ccb3af0800472404ce64abeb6=
0aba0920f
>
> Ceph kclient:
> https://github.com/tcloud/ceph-client-standalone/commit/f70702af442d6=
1b356eab3e1572e115254e73a3a
>
> Sincerely,
> - Herb
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
