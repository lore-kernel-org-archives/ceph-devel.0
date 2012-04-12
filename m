From: Damien Churchill <damoxc@gmail.com>
Subject: Re: wip-librbd-caching
Date: Thu, 12 Apr 2012 20:48:31 +0100
Message-ID: <CAFtEh-fXynavpDDYRtBx8GQLwz+Td9YcKwErqFtaM+qxx0aGYw@mail.gmail.com>
References: <4F872D48.6070801@tuxadero.com>
	<Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36221 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab2DLTsc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 15:48:32 -0400
Received: by yhmm54 with SMTP id m54so1316843yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 12:48:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Martin Mailand <martin@tuxadero.com>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On 12 April 2012 20:45, Sage Weil <sage@newdream.net> wrote:
> I'm not familiar with the performance implications of KSM, but the
> objectcacher doesn't modify existing buffers in place, so I suspect i=
t's a
> good candidate. =C2=A0And it looks like there's minimal effort in ena=
bling
> it...

It uses some CPU when calculating hashes, although I believe if it
gets to be too resource consuming it is possible to disable it and
continue to use the shared pages you have already calculated, just not
updating or checking for any others that could be shared.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
