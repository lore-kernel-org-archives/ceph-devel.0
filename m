From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Fri, 29 Jun 2012 14:11:22 -0700
Message-ID: <CAPYLRzjiD+2dQ=C=VRbVa=3T4=05LD_WRvj0tJygfpqdZoYJ-g@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag>
	<4FABC15C.3030500@profihost.ag>
	<CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
	<CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
	<CAMsVa3vyJo05M4KkXmYwmRnoPi2V-sjM7SVHrM0ZJJ6JEZdCzA@mail.gmail.com>
	<CAPYLRzguXka1S_CyQ5q-f9VmhACpkHRZer1_9kuk3LPpfXOMcw@mail.gmail.com>
	<CAMsVa3vMBh6MoMS1pHc6HzNgJUhLp8Dyr5GzVYE9BKGFye2pBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52271 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab2F2VLY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 17:11:24 -0400
Received: by lbbgm6 with SMTP id gm6so5172114lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 14:11:23 -0700 (PDT)
In-Reply-To: <CAMsVa3vMBh6MoMS1pHc6HzNgJUhLp8Dyr5GzVYE9BKGFye2pBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Edmonds <mornir@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 1:59 PM, Brian Edmonds <mornir@gmail.com> wrote=
:
> On Fri, Jun 29, 2012 at 11:50 AM, Gregory Farnum <greg@inktank.com> w=
rote:
>> If you lose a journal, you lose the OSD.
>
> Really? =A0Everything? =A0Not just recent commits? =A0I would have ho=
ped it
> would just come back up in an old state. =A0Replication should have
> already been taking care of regaining redundancy for the stuff that
> was on it, particularly the newest stuff that wouldn't return with it
> and say "Hi, I'm back."
>
> I suppose it makes the design easier though. =3D)

Well, actually this depends on the filesystem you're using. With
btrfs, the OSD will roll back to a consistent state, but you don't
know how out-of-date that state is. (Practically speaking, it's pretty
new, but if you were doing any writes it is going to be data loss.)
With xfs/ext4/other, the OSD can't create consistency points the same
way it can with btrfs, and so the loss of a journal means that it
can't repair itself.

Sorry for not mentioning the distinction earlier; I didn't think we'd
implemented the rollback on btrfs. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
