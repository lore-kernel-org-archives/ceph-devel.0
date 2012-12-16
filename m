From: =?UTF-8?B?SmVucyBLcmlzdGlhbiBTw7hnYWFyZA==?=
	<jens@mermaidconsulting.dk>
Subject: Re: Slow requests
Date: Sun, 16 Dec 2012 23:42:56 +0100
Message-ID: <50CE4E70.50608@mermaidconsulting.dk>
References: <50CDD3DB.7000501@mermaidconsulting.dk> <CABYiri_f4Xa4aKoKG9=3L9W-cj9+25TZerTg622AOkMPaQfymQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.stofanet.dk ([212.10.10.14]:45049 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2LPWm6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 16 Dec 2012 17:42:58 -0500
In-Reply-To: <CABYiri_f4Xa4aKoKG9=3L9W-cj9+25TZerTg622AOkMPaQfymQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Andrey,

Thanks for your reply!

> Please take a look to this thread:
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/10843

I took your advice and restarted each of my three osd's individually.=20
The first two restarted within a minute or two. The last one took 20=20
minutes to restart (?)

Afterwards the slow request had disappeared, so it did seem to work!

> Seems that you`ll need newer rpms to get rid of this.

Are newer RPMs available for download somewhere, or do I need to compil=
e=20
my own?

I have searched the ceph.com site several times in the past, but I only=
=20
find older versions.

--=20
Jens Kristian S=C3=B8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
