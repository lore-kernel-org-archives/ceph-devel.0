From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Hang at 'rbd info <image>'
Date: Mon, 19 Dec 2011 11:01:46 -0800
Message-ID: <CAORUGqADEE=kGB2jbMs_M__jnLjHU39ONg6eAOro+H40YGYECw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49DA2EE99@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50861 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1LSTCI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 14:02:08 -0500
Received: by wibhm6 with SMTP id hm6so1069026wib.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 11:02:07 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49DA2EE99@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com, Alex_Lee@wistron.com

On Sun, Dec 18, 2011 at 19:32,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, all:
>
> =C2=A0=C2=A0=C2=A0 I met a situation that ceph system would hang at =E2=
=80=98rbd info <image>.
> =E3=80=80=E3=80=80Only can reproduced on one image.
> =E3=80=80=E3=80=80How can I know what happened? Is there any log that=
 I can provide to you for analysis? Thanks!

That would happen if the object that stores the rbd image header would
be unreachable. Is your cluster healthy ("ceph health", "ceph -s")?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
