From: Asias He <asias.hejun@gmail.com>
Subject: Re: [wiki] debian package setup error
Date: Wed, 26 May 2010 12:39:18 +0800
Message-ID: <AANLkTim0dSVe-sQMz_NSTYdQyhVWydyGIoydPk49EY2n@mail.gmail.com>
References: <1274841548.11302.7.camel@localhost>
	 <Pine.LNX.4.64.1005251946160.24496@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40673 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0EZEjT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 May 2010 00:39:19 -0400
Received: by vws9 with SMTP id 9so4004057vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 May 2010 21:39:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1005251946160.24496@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wed, May 26, 2010 at 10:48 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 26 May 2010, Asias He wrote:
>> Can anybody update the wiki page[1] for debian package setup.
>>
>> From:
>> deb http://ceph.newdream.net/debian/ lenny ceph-testing
>> deb-src http://ceph.newdream.net/debian/ lenny ceph-testing
>> To:
>> deb http://ceph.newdream.net/debian/ testing ceph-testing
>> deb-src http://ceph.newdream.net/debian/ testing ceph-testing
>
> Keep in mind that the first 'lenny' portion refers to the distributio=
n the
> packages are built for (lenny, squeeze, sid or stable, testing, unsta=
ble)
> and the second bit refers to which ceph source branch is built. =C2=A0=
Each
> branch is built for each distribution. =C2=A0ceph-stable is the last =
release,
> ceph-testing is the release+fixes, and ceph-unstable is the bleeding =
edge.
> Mix and match!

The stable,testing,unstable term used for ceph confused me. :(
I missed the words "Note that 'lenny' can be replaced with any debian
dist: lenny, squeeze, sid, or an alias (stable, unstable, testing). "
below the repo setup example.

Mind to add a repo setup example  from the debian user's perspective?
e.g.
=46or lenny(stable) user:
=2E..
=46or squeeze(testing) user:
=2E..
=46or sid(unstable)  user:
=2E...

--=20
Best Regards
Asias He
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
