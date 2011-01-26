From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: master branch in git
Date: Wed, 26 Jan 2011 15:21:42 -0800
Message-ID: <AANLkTikVYf3vH65Ru1+27USE9eRE7LHc8wDJd9d-N+2N@mail.gmail.com>
References: <1296076567.1802.16.camel@dogen>
	<AANLkTimjgPj2wQhtw1zg8NK-jsLPk1RUHiRcjA0XH8RV@mail.gmail.com>
	<1296078697.1802.37.camel@dogen>
	<Pine.LNX.4.64.1101261357390.27034@cobra.newdream.net>
	<AANLkTimPabH3A6uHUhpas4JtcBq2Ycw_UoxzX+FL4Vp+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37824 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab1AZXVo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 18:21:44 -0500
Received: by fxm20 with SMTP id 20so1527851fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jan 2011 15:21:43 -0800 (PST)
In-Reply-To: <AANLkTimPabH3A6uHUhpas4JtcBq2Ycw_UoxzX+FL4Vp+@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, John Leach <john@brightbox.co.uk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 26, 2011 at 2:05 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Wed, Jan 26, 2011 at 2:01 PM, Sage Weil <sage@newdream.net> wrote:
>> How about something like:
>>
>> =A0master - unstable (and get rid of 'unstable' branch)
>> =A0testing or stable - bug fixes to last release.
>> =A0rc or next - what will be the next major release
>
> It seems a little weird/worrisome to me that the default branch would
> be one that sees as much churn as unstable gets. Maybe that's not
> actually an issue for people, but I'd naively rather see master be
> what rc is right now than what unstable is right now.

The mindset users have is something like this:
Do I want something stable? If so, then download the source code
tarball for the previous release (or RPM, or DPKG, or whatever.) If
not, then get the code directly out of the source code repository.

Theoretically, you could get the stable version out of the source code
repository. But when was the last time you did that (for a project you
weren't developing)? That's why the tradition is for master / SVN HEAD
to be unstable.

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
