From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph config without ctrfs
Date: Mon, 27 Feb 2012 16:44:43 -0800
Message-ID: <CAORUGqD7ufy=NyS39JGFOAX4ikZf+q6JL=CEK18a7cmRWsoSEA@mail.gmail.com>
References: <4F4C0F60.1070100@genome.wustl.edu> <CAF3hT9Ap-rqB+3B0WqUzFGhMFDTrN00HiYHAhaW0gSF_60HNnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42546 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab2B1ApF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 19:45:05 -0500
Received: by wejx9 with SMTP id x9so649839wej.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2012 16:45:03 -0800 (PST)
In-Reply-To: <CAF3hT9Ap-rqB+3B0WqUzFGhMFDTrN00HiYHAhaW0gSF_60HNnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org

On Mon, Feb 27, 2012 at 15:29, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Mon, Feb 27, 2012 at 3:18 PM, Matt Weil <mweil@genome.wustl.edu> w=
rote:
>> How do you do this type of config (specifying multiple devices per s=
erver)
>> on xfs not btrfs?
>>
>>> [osd.1]
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D linuscs92
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs devs =3D /dev/cciss/c1d2

My inclination at this point is to deprecate & remove the "btrfs devs"
feature as soon as possible. It's a half-feature that keeps tripping
people up.

=46ormat your filesystems as you wish, mount them, and point "osd data"
at one. "btrfs devs" was meant for quickly creating throwaway test
setups.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
