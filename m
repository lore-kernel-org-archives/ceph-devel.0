From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: wip-makefile
Date: Thu, 12 Jan 2012 09:58:17 -0800
Message-ID: <CAORUGqBmgc3NXnyTWRa3202gr4b86t09hf_bAGG8Ng8ZW+iwGg@mail.gmail.com>
References: <Pine.LNX.4.64.1201120922340.18796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45492 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2ALR6j convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 12:58:39 -0500
Received: by wibhm14 with SMTP id hm14so1409007wib.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 09:58:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201120922340.18796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Jan 12, 2012 at 09:27, Sage Weil <sage@newdream.net> wrote:
> Kacper (from gentoo) sent us some Makefile cleanups to do pthread
> detection properly. =C2=A0Anybody with stronger autotool-fu wanna tak=
e a quick
> look before it hits master?
>
> https://github.com/NewDreamNetwork/ceph/commits/wip-makefile

We talked about it, replying on the list because I hate it when other
people's conversations seem to fade away without resolution.

I dislike the copy-paste code, but that's how you have to roll with aut=
oconf.

The code is actually GPL+exception for use with autoconf, Sage is
aware and will include a mention in the COPYING file.

+1 with the copyright fix
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
