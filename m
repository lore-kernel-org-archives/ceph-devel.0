From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: ceph -w output
Date: Tue, 13 Dec 2011 09:57:51 -0800
Message-ID: <CACLRD_3n6rCJNFVgmWesDjP3P7DY0bfZr_XGTtx9MC=r29uYRg@mail.gmail.com>
References: <4EE654A3.1040309@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53860 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab1LMR5x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 12:57:53 -0500
Received: by wgbdr13 with SMTP id dr13so14189140wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2011 09:57:52 -0800 (PST)
In-Reply-To: <4EE654A3.1040309@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A pg is in the "creating" stage between when its pool is created and
when the OSD responsible for it first creates it.  Did this happen
after creating a pool?  Could you send the output of 'ceph pg dump'
and 'ceph osd dump'?

Thanks,
-Sam

On Mon, Dec 12, 2011 at 11:23 AM, Jens Rehpoehler
<jens.rehpoehler@filoo.de> wrote:
> Hi,
>
> could someone please explain to following to me:
>
> 2011-12-12 20:16:16.899140 =C2=A0 =C2=A0pg v182377: 1190 pgs: 18 crea=
ting, 1172
> active+clean; 332 GB data, 652 GB used, 13270 GB / 14667 GB avail
> 2011-12-12 20:16:20.769268 =C2=A0 =C2=A0pg v182378: 1190 pgs: 18 crea=
ting, 1172
> active+clean; 332 GB data, 652 GB used, 13270 GB / 14667 GB avail
>
> I've created the filesystem a week ago. The Status "18 creating" rema=
ins
> since then. I've another Cluster where "creating" never shows up.
>
> Anything to worry about ? Any chance to debug this ?
>
> Thanks a lot !!
>
> Jens
>
> PS: it's the first time i write to a list. please be patient with me =
if i
> break any rules :)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
