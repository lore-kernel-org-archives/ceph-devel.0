From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: question about logger.cc
Date: Wed, 26 Jan 2011 09:09:51 -0800
Message-ID: <AANLkTimHxjuKQVGkC=XGVh7bQgqDTyEKbuH98CNZkFrX@mail.gmail.com>
References: <Pine.LNX.4.64.1101250808480.3488@cobra.newdream.net>
	<D0C67741759ABD4BBD8D3A5CB815606E07E64C@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49074 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab1AZRJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 12:09:58 -0500
Received: by ewy5 with SMTP id 5so302118ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jan 2011 09:09:56 -0800 (PST)
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E64C@mail.cloud-valley.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

What version are you using? We fixed a bug with this at the end of
November; if you're still on v.23.1 then upgrading to v.24.x will fix
this. :)
(Alternatively, you can cherry-pick
fb60e11472456b5e428b9957b7bce33b85eb5ab3 out of our tree and rebuild.)

The FlusherStopper is used to clean up a left over thread in common/Log=
ger.cc.
-Greg

On Wed, Jan 26, 2011 at 6:54 AM, Longguang Yue
<longguang_yue@tcloudcomputing.com> wrote:
> I do not find =A0where stopper is used!!!
>
>
> common/Mutex.h: In function 'void Mutex::Lock(bool)':
> common/Mutex.h:118: FAILED assert(r =3D=3D 0)
> =A0ceph version 0.24.2 (commit:f7572de5cb87eb7157217be4975ae66d90831b=
b7)
> =A01: (SafeTimer::shutdown()+0x6b1) [0x44a101]
> =A02: (FlusherStopper::~FlusherStopper()+0x58) [0x444788]
> =A03: (exit()+0xe1) [0x3716a379c1]
> =A04: (__libc_start_main()+0x104) [0x3716a1ee84]
> =A05: /usr/bin/cconf() [0x416769]
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
