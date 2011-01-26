From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: master branch in git
Date: Wed, 26 Jan 2011 13:22:44 -0800
Message-ID: <AANLkTimjgPj2wQhtw1zg8NK-jsLPk1RUHiRcjA0XH8RV@mail.gmail.com>
References: <1296076567.1802.16.camel@dogen>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56467 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab1AZVWp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 16:22:45 -0500
Received: by eye27 with SMTP id 27so780378eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jan 2011 13:22:44 -0800 (PST)
In-Reply-To: <1296076567.1802.16.camel@dogen>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Leach <john@brightbox.co.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You're talking about the userspace Ceph repository?
I wasn't aware there was a master or stable branch (heh). I thought
Sage had just recently cleaned up the old branches, but we may still
have a bit of a mess as we adjusted to a larger team size and more
formal releases. You're generally going to want one of testing,
unstable, rc.

Unstable is the branch we do dev work on. It has the newest shiny
stuff and is far more likely to be broken than the other branches, to
get commits erased, etc.
Testing is the previous release plus bugfixes, and will eventually
become the next point release (eg, v.24.3).
rc is maintained when we're approaching a major release (eg, v.25) and
contains the features we expect to go into that branch. This branch
comes off of unstable but once it branches it's a fairly stable
branch.

On Wed, Jan 26, 2011 at 1:16 PM, John Leach <john@brightbox.co.uk> wrot=
e:
> Hi,
>
> what's the master branch used for in the git repository? It's current=
ly
> at "v0.24". It's not had 0.24.1 or 0.24.2 merged into it so it doesn'=
t
> seem to be stable.
>
> There is a stable branch but it's not been updated since September.
>
> John.
>
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
