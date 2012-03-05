From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Dependencies
Date: Mon, 5 Mar 2012 09:01:38 -0800
Message-ID: <CAORUGqCqXy_cPb6Gn4vsacXb+x-zjDP69G==Jpiwp5E_ELmRrQ@mail.gmail.com>
References: <4F54DFD9.1010209@dreamhost.com> <CAORUGqDQLXLxjiqEtJx=Pa0UQ=dq_tyoQzVkEY2Z=QQJ7dOo3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:50786 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2CERB6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 12:01:58 -0500
Received: by dadp12 with SMTP id p12so5343289dad.11
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 09:01:58 -0800 (PST)
In-Reply-To: <CAORUGqDQLXLxjiqEtJx=Pa0UQ=dq_tyoQzVkEY2Z=QQJ7dOo3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

[Resending to ceph-devel without the HTML gmail put in.]

On Mon, Mar 5, 2012 at 07:46, Alex Elder <elder@dreamhost.com> wrote:
>
> Is there any way that we can do any or all of these?
> - we can identify when a new dependency like that has been added

The Build-Depends: line in debian/control changed. Or, the
BuildRequires: lines in ceph.spec.in changed, for RPM dstros.

(Or someone screwed up, and forgot to change them, but when that gets
fixed, go back to previous paragraph.)

> - we can do this automatically
> - we can mention something (like in a release announcement) when
> =C2=A0new dependencies have been added since last time

Automatically answering whether that content changed after last
release is easy. Release management is not (it's a repetitive,
relatively rare & high-importance task).

> - we can do a nicer job of telling the user that a particular
> =C2=A0package is missing--better than the "test for gtmm failed" kind
> =C2=A0of message that the configure script provides

That's autoconf, it's hard to improve on, and intentionally does not
assume the system is managed using debs or RPM etc.

As long as you're on Debian/Ubuntu, running dpkg-checkbuilddeps will
check your system against debian/control.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
