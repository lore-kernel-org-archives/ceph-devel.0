From: Gregory Farnum <greg@inktank.com>
Subject: Re: Debian/Ubuntu packages for ceph-deploy
Date: Tue, 4 Dec 2012 14:04:03 -0800
Message-ID: <CAPYLRzjSsc+Yhfr7KVxDgH9SitXior86FyV-FQYfLjV2nQJQiA@mail.gmail.com>
References: <50AEC36F.9050807@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41300 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2LDWEE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 17:04:04 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3465749iay.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 14:04:03 -0800 (PST)
In-Reply-To: <50AEC36F.9050807@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Gerhard Loschwitz <martin.loschwitz@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gary Lowell <gary.lowell@inktank.com>, Sage Weil <sage@inktank.com>

On Thu, Nov 22, 2012 at 4:29 PM, Martin Gerhard Loschwitz
<martin.loschwitz@hastexo.com> wrote:
> Hi folks,
>
> I figured it might be a cool thing to have packages of ceph-deploy fo=
r
> Debian and Ubuntu 12.04; I took the time and created them (along with
> packages of python-pushy, which ceph-deploy needs but which was not
> present in the Debian archive and thus in the Ubuntu archive either).
>
> They are available from http://people.debian.org/~madkiss/ceph-deploy=
/
>
> I did upload python-pushy to the official Debian unstable repository
> already, but I didn't do so just yet with ceph-deploy. Also, I don't
> want to step on somebody's toes - if there were secret plans to start
> ceph-deploy packaging anyway, I'm more than happy to hand over what
> I have got to the responsible person.
>
> Any feedback is highly appreciated (esp. with regards to the question
> if it's already okay to upload ceph-deploy).

We're certainly planning to have ceph-deploy packages once we're
prepared to support them =97 but if a community member wants to do it
for us now...well, we like having less to do. ;) You're not going to
step on anybody's toes, and if we need to arrange a transfer of
stewardship I imagine that can be arranged?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
