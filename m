From: Mag Gam <magawake@gmail.com>
Subject: Re: roadmap
Date: Fri, 24 Sep 2010 23:52:43 -0400
Message-ID: <AANLkTi=K5PudSyrh=Pf5hpMw-xqV-WMrxCVr1WKvCPdz@mail.gmail.com>
References: <Pine.LNX.4.64.1009241526010.17668@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38252 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238Ab0IYDwn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Sep 2010 23:52:43 -0400
Received: by iwn5 with SMTP id 5so2909697iwn.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Sep 2010 20:52:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009241526010.17668@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks for the timeline.

We would like to see file striping. Instead of replicating the data it
would be even better if we are able to maintain parity amongst the
objects. No opensource project has this.
What do you think?

On Fri, Sep 24, 2010 at 6:48 PM, Sage Weil <sage@newdream.net> wrote:
> I've been working on keeping the roadmap in the project tracker up to=
 date
> with the current release schedule and the features targetting each
> version. =C2=A0That can be found at
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://tracker.newdream.net/projects/ceph/=
roadmap
>
> The main exception is that many bugs end up accumulating with the nex=
t
> stable release as a target (e.g., v0.21.4), and then (when they're no=
t
> resolved) get pushed off to the next release. =C2=A0And as releases g=
et further
> into the future the picture gets a bit for hazy.
>
> Those caveats aside, the basic schedule and goals are:
>
> v0.22 (1-2 weeks away)
> =C2=A0- Stable and usable clustered MDS in non-failure conditions. =C2=
=A0We will
> encourage anybody to test the clustered MDS for correctness, performa=
nce,
> and stability, and to report any and all issue.
> =C2=A0- Background OSD scrubbing. =C2=A0This will help us catch remai=
ning object
> replication/recovery problems sooner rather than later.
> =C2=A0- Stable RBD.
>
> v0.23 (6 weeks away)
> =C2=A0- Stable clustered MDS failure recovery.
> =C2=A0- Stable directory fragmentation and defragmetnation. =C2=A0(Fr=
agmentation is
> what faciliates very large directories and the distribution of large
> directories over multiple nodes in the MDS cluster.)
> =C2=A0- RBD image locking.
> =C2=A0- Stable radosgw (S3 compatible REST proxy)
>
> v1.0 (Christmas!)
> =C2=A0- Some basic fsck functionality
> =C2=A0- Cautious use in production setting.
>
> This is all, of course, subject to change depending on what issues co=
me up
> as we ramp up our testing and QA.
>
> I'm also interested in hearing from you what features or issues you a=
re
> most interested in seeing us focus on. =C2=A0What are your use cases?=
 =C2=A0If you
> have done any testing, what problems have you run into? =C2=A0If you =
haven't,
> what is preventing you from testing (besides some promise of stabilit=
y or
> production readiness)?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
