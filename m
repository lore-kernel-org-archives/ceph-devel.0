From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Slow requests
Date: Mon, 17 Dec 2012 01:05:12 +0300
Message-ID: <CABYiri_f4Xa4aKoKG9=3L9W-cj9+25TZerTg622AOkMPaQfymQ@mail.gmail.com>
References: <50CDD3DB.7000501@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44783 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2LPWFd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Dec 2012 17:05:33 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5300923oag.19
        for <ceph-devel@vger.kernel.org>; Sun, 16 Dec 2012 14:05:32 -0800 (PST)
In-Reply-To: <50CDD3DB.7000501@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Kristian_S=C3=B8gaard?= <jens@mermaidconsulting.dk>
Cc: ceph-devel@vger.kernel.org

On Sun, Dec 16, 2012 at 5:59 PM, Jens Kristian S=C3=B8gaard
<jens@mermaidconsulting.dk> wrote:
> Hi,
>
> My log is filling up with warnings about a single slow request that h=
as been
> around for a very long time:
>
> osd.1 10.0.0.2:6800/900 162926 : [WRN] 1 slow requests, 1 included be=
low;
> oldest blocked for > 84446.312051 secs
>
> osd.1 10.0.0.2:6800/900 162927 : [WRN] slow request 84446.312051 seco=
nds
> old, received at 2012-12-15 15:27:56.891437:
> osd_sub_op(client.4528.0:19602219 0.fe
> 3807b5fe/rb.0.11b7.4a933baa.00000008629e/head//0 [] v 53'185888
> snapset=3D0=3D[]:[] snapc=3D0=3D[]) v7 currently started
>
>
> How can I identify the cause of this and how can I cancel this reques=
t?
>
> I'm running Ceph on Fedora 17 using the latest RPMs available from ce=
ph.com
> (0.52-6).
>
>
> Thanks in advance,

Hi Jens,

Please take a look to this thread:
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/10843

Seems that you`ll need newer rpms to get rid of this.

> --
> Jens Kristian S=C3=B8gaard, Mermaid Consulting ApS,
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
