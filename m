From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS Space Accounting and Quotas
Date: Fri, 8 Mar 2013 18:05:31 -0800
Message-ID: <391D23EA41AE4F05BCE2E6367BA0FC3C@inktank.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
 <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
 <51379FCD.9000502@sandia.gov>
 <D19243567199482692F961618A335817@inktank.com>
 <5137B4E9.1030505@sandia.gov>
 <1856965A675D4D5D971D5DC9AB01C657@inktank.com>
 <5137CDE2.70105@sandia.gov>
 <8B6963669A2E49C286B9241DCD62F557@inktank.com>
 <5138AEFB.5070200@sandia.gov> <513A69F8.6050709@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:43356 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab3CICFg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Mar 2013 21:05:36 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so251336dan.37
        for <ceph-devel@vger.kernel.org>; Fri, 08 Mar 2013 18:05:36 -0800 (PST)
In-Reply-To: <513A69F8.6050709@sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On Friday, March 8, 2013 at 2:45 PM, Jim Schutt wrote:
> On 03/07/2013 08:15 AM, Jim Schutt wrote:
> > On 03/06/2013 05:18 PM, Greg Farnum wrote:
> > > On Wednesday, March 6, 2013 at 3:14 PM, Jim Schutt wrote:
> > =20
> =20
> =20
> =20
> [snip]
> =20
> > > > Do you want the MDS log at 10 or 20?
> > > More is better. ;)
> > =20
> > =20
> > =20
> > OK, thanks.
> =20
> I've sent some mds logs via private email...
> =20
> -- Jim =20
I'm going to need to probe into this a bit more, but on an initial exam=
ination I see that most of your stats are actually happening very quick=
ly =E2=80=94 it's just that occasionally they take quite a while. Going=
 through the MDS log for one of those, the inode in question is flagged=
 with "needsrecover" from its first appearance in the log =E2=80=94 tha=
t really shouldn't happen unless a client had write caps on it and the =
client disappeared. Any ideas? The slowness is being caused by the MDS =
going out and looking at every object which could be in the file =E2=80=
=94 there are a lot since the file has a listed size of 8GB.
(There are several other mysteries here that can probably be traced to =
different varieties of non-optimal and buggy code as well =E2=80=94 the=
re is a client which has write caps on the inode in question despite it=
 needing recovery, but the recovery isn't triggered until the stat even=
t occurs, etc).
-Greg

Software Engineer #42 @ http://inktank.com | http://ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
