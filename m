From: Gregory Farnum <greg@gregs42.com>
Subject: Re: init script bug with multiple clusters
Date: Thu, 16 Apr 2015 18:01:26 -0700
Message-ID: <CAC6JEv9gHVrTmuo_Nc1vSxCDmh9WckYwrBN34nPrt7gwptGmYA@mail.gmail.com>
References: <5524FBB9.9070300@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36300 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbDQBB1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 21:01:27 -0400
Received: by igblo3 with SMTP id lo3so3047596igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 18:01:27 -0700 (PDT)
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com. [209.85.213.169])
        by mx.google.com with ESMTPSA id i20sm284171igh.16.2015.04.16.18.01.26
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 18:01:26 -0700 (PDT)
Received: by igblo3 with SMTP id lo3so3289884igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 18:01:26 -0700 (PDT)
In-Reply-To: <5524FBB9.9070300@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This looks good to me, but we need an explicit sign-off from you for
it. If you can submit it as a PR on Github that's easiest for us, but
if not can you send it in git email patch form? :)
-Greg

On Wed, Apr 8, 2015 at 2:58 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> Hello Ceph!
>
> The Ceph init script (src/init-ceph.in) creates pid files without
> cluster names. This means that only one cluster can run at a time. Th=
e
> solution is simple and works fine here, patch against 0.94 is attache=
d.
>
> Amon Ott
> --
> Dr. Amon Ott
> m-privacy GmbH           Tel: +49 30 24342334
> Werner-Vo=C3=9F-Damm 62       Fax: +49 30 99296856
> 12101 Berlin             http://www.m-privacy.de
>
> Amtsgericht Charlottenburg, HRB 84946
>
> Gesch=C3=A4ftsf=C3=BChrer:
>  Dipl.-Kfm. Holger Maczkowsky,
>  Roman Maczkowsky
>
> GnuPG-Key-ID: 0x2DD3A649
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
