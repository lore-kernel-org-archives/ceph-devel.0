From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Slow requests
Date: Mon, 17 Dec 2012 01:50:35 +0300
Message-ID: <CABYiri-tDJXhCVGRLj+s1LCmStWRTqLwYDm8s3q9idjHjYA4vg@mail.gmail.com>
References: <50CDD3DB.7000501@mermaidconsulting.dk> <CABYiri_f4Xa4aKoKG9=3L9W-cj9+25TZerTg622AOkMPaQfymQ@mail.gmail.com>
 <50CE4E70.50608@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40698 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab2LPWu6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Dec 2012 17:50:58 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so5107890obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 16 Dec 2012 14:50:57 -0800 (PST)
In-Reply-To: <50CE4E70.50608@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Kristian_S=C3=B8gaard?= <jens@mermaidconsulting.dk>
Cc: ceph-devel@vger.kernel.org

On Mon, Dec 17, 2012 at 2:42 AM, Jens Kristian S=C3=B8gaard
<jens@mermaidconsulting.dk> wrote:
> Hi Andrey,
>
> Thanks for your reply!
>
>
>> Please take a look to this thread:
>> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/10843
>
>
> I took your advice and restarted each of my three osd's individually.=
 The
> first two restarted within a minute or two. The last one took 20 minu=
tes to
> restart (?)
>
> Afterwards the slow request had disappeared, so it did seem to work!
>
>
>> Seems that you`ll need newer rpms to get rid of this.
>
>
> Are newer RPMs available for download somewhere, or do I need to comp=
ile my
> own?
>
> I have searched the ceph.com site several times in the past, but I on=
ly find
> older versions.
>
>

Oh, sorry, I maybe misguided you - solution is the patch from Sam,
restarts may help only on the short distance and you`re not able to
check some pgs for consistency until patch have been applied - they`ll
hang on scrub every time.

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
