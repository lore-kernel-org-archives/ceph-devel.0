From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS Space Accounting and Quotas
Date: Mon, 11 Mar 2013 08:48:31 -0700
Message-ID: <114836C3F596429AAB29E98225A25E1B@inktank.com>
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
 <391D23EA41AE4F05BCE2E6367BA0FC3C@inktank.com>
 <513DEE83.8030909@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:44384 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab3CKPsg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 11:48:36 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so3881917pbb.27
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 08:48:36 -0700 (PDT)
In-Reply-To: <513DEE83.8030909@sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On Monday, March 11, 2013 at 7:47 AM, Jim Schutt wrote:
> On 03/08/2013 07:05 PM, Greg Farnum wrote:
> > On Friday, March 8, 2013 at 2:45 PM, Jim Schutt wrote:
> > > On 03/07/2013 08:15 AM, Jim Schutt wrote:
> > > > On 03/06/2013 05:18 PM, Greg Farnum wrote:
> > > > > On Wednesday, March 6, 2013 at 3:14 PM, Jim Schutt wrote:
> > > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > [snip]
> > > =20
> > > > > > Do you want the MDS log at 10 or 20?
> > > > > =20
> > > > > More is better. ;)
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > OK, thanks.
> > > =20
> > > =20
> > > I've sent some mds logs via private email...
> > > =20
> > > -- Jim =20
> > =20
> > I'm going to need to probe into this a bit more, but on an initial
> > examination I see that most of your stats are actually happening ve=
ry
> > quickly =E2=80=94 it's just that occasionally they take quite a whi=
le.
> =20
> =20
> =20
> Interesting...
> =20
> > Going
> > through the MDS log for one of those, the inode in question is
> > flagged with "needsrecover" from its first appearance in the log =E2=
=80=94
> > that really shouldn't happen unless a client had write caps on it a=
nd
> > the client disappeared. Any ideas? The slowness is being caused by
> > the MDS going out and looking at every object which could be in the
> > file =E2=80=94 there are a lot since the file has a listed size of =
8GB.
> =20
> =20
> =20
> For this run, the MDS logging slowed it down enough to cause the
> client caps to occasionally go stale. I don't think it's the cause
> of the issue, because I was having it before I turned MDS debugging
> up. My client caps never go stale at, e.g., debug mds 5.

Oh, so this might be behaviorally different than you were seeing before=
? Drat.

You had said before that each newfstatat was taking tens of seconds, wh=
ereas in the strace log you sent along most of the individual calls wer=
e taking a bit less than 20 milliseconds. Do you have an strace of them=
 individually taking much more than that, or were you just noticing tha=
t they took a long time in aggregate?
I suppose if you were going to run it again then just the message loggi=
ng could also be helpful. That way we could at least check and see the =
message delays and if the MDS is doing other work in the course of answ=
ering a request.

> Otherwise, there were no signs of trouble while writing the files.
> =20
> Can you suggest which kernel client debugging I might enable that
> would help understand what is happening? Also, I have the full
> MDS log from writing the files, if that will help. It's big (~10 GiB)=
=2E
> =20
> > (There are several other mysteries here that can probably be traced
> > to different varieties of non-optimal and buggy code as well =E2=80=
=94 there
> > is a client which has write caps on the inode in question despite i=
t
> > needing recovery, but the recovery isn't triggered until the stat
> > event occurs, etc).
> =20
> =20
> =20
> OK, thanks for taking a look. Let me know if there is other
> logging I can enable that will be helpful.

I'm going to want to spend more time with the log I've got, but I'll th=
ink about if there's a different set of data we can gather less disrupt=
ively. =20
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
