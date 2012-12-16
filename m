From: =?UTF-8?B?SmVucyBLcmlzdGlhbiBTw7hnYWFyZA==?=
	<jens@mermaidconsulting.dk>
Subject: Re: Slow requests
Date: Mon, 17 Dec 2012 00:12:11 +0100
Message-ID: <50CE554B.7060301@mermaidconsulting.dk>
References: <50CDD3DB.7000501@mermaidconsulting.dk> <CABYiri_f4Xa4aKoKG9=3L9W-cj9+25TZerTg622AOkMPaQfymQ@mail.gmail.com> <50CE4E70.50608@mermaidconsulting.dk> <CABYiri-tDJXhCVGRLj+s1LCmStWRTqLwYDm8s3q9idjHjYA4vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.stofanet.dk ([212.10.10.14]:51987 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab2LPXMN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 16 Dec 2012 18:12:13 -0500
In-Reply-To: <CABYiri-tDJXhCVGRLj+s1LCmStWRTqLwYDm8s3q9idjHjYA4vg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

Hi Andrey,

> Oh, sorry, I maybe misguided you - solution is the patch from Sam,
> restarts may help only on the short distance and you`re not able to
> check some pgs for consistency until patch have been applied - they`l=
l
> hang on scrub every time.

I'll need to update, yes!

I don't have any pgs in scrubbing though.

--=20
Jens Kristian S=C3=B8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
