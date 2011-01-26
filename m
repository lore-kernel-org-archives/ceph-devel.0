From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: master branch in git
Date: Wed, 26 Jan 2011 14:05:11 -0800
Message-ID: <AANLkTimPabH3A6uHUhpas4JtcBq2Ycw_UoxzX+FL4Vp+@mail.gmail.com>
References: <1296076567.1802.16.camel@dogen>
	<AANLkTimjgPj2wQhtw1zg8NK-jsLPk1RUHiRcjA0XH8RV@mail.gmail.com>
	<1296078697.1802.37.camel@dogen>
	<Pine.LNX.4.64.1101261357390.27034@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63312 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab1AZWFM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 17:05:12 -0500
Received: by eye27 with SMTP id 27so813035eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jan 2011 14:05:11 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1101261357390.27034@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Leach <john@brightbox.co.uk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 26, 2011 at 2:01 PM, Sage Weil <sage@newdream.net> wrote:
> How about something like:
>
> =A0master - unstable (and get rid of 'unstable' branch)
> =A0testing or stable - bug fixes to last release.
> =A0rc or next - what will be the next major release

It seems a little weird/worrisome to me that the default branch would
be one that sees as much churn as unstable gets. Maybe that's not
actually an issue for people, but I'd naively rather see master be
what rc is right now than what unstable is right now.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
