From: Sage Weil <sage@newdream.net>
Subject: Re: PG state issue
Date: Mon, 5 Mar 2012 07:28:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203050727530.11992@cobra.newdream.net>
References: <CANExM-MJ6eSifymHe-aSwwyPkBaTSbLUVZGHVwvrcUFGpNopoA@mail.gmail.com>
 <Pine.LNX.4.64.1203010810330.30824@cobra.newdream.net>
 <CANExM-Nb48s1ASTRuV1daSe3X1PhLfxza6+zUJNGShGL+tSLiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-42010196-1330961291=:11992"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38214 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964837Ab2CEP2M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 10:28:12 -0500
In-Reply-To: <CANExM-Nb48s1ASTRuV1daSe3X1PhLfxza6+zUJNGShGL+tSLiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-42010196-1330961291=:11992
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 Mar 2012, Henry C Chang wrote:
> Hi Sage,
>=20
> I just tested v0.43. All pgs are shown active+degraded now. However,
> is it possible to show the number (or percentage) of degraded objects
> as in the earlier version?

Yeah.  Just opened http://tracker.newdream.net/issues/2137, will look at=20
it this week.

Thanks!
sage


>=20
> Henry
>=20
> =FF=FF 2012=FF=FF3=FF=FF2=FF=FF=FF=FF=FF=FF12:14=FF=FFSage Weil <sage@new=
dream.net> =FF=FF=FF=FF=FF=FF
> > Hi Henry, Wido,
> >
> > On Thu, 1 Mar 2012, Henry C Chang wrote:
> >> With version 0.42, I found that the pg's state is not in "degrade" any
> >> more if the number of osds is smaller than that of the replication.
> >> For example, if I create a cluster of one osd with replication 2, all
> >> pgs are in active+clean state. (The pgs were in active+clean+degrade
> >> state in the earlier versions.)
> >
> > The PG states were tweaked a fair bit for v0.43:
> >
> > - new 'recovering' state means we are actively recovering the PG (no
> > =A0longer implied by lack of 'clean')
> > - 'remapped' means we have temporarily remapped a pg to a specific set =
of
> > =A0OSDs (other than what CRUSH gives us)
> > - 'clean' specifically means we have the right number of replicas and
> > =A0aren't remapped.
> >
> > ...and the 'degraded' thing you are seeing is fixed. =A0This is all in =
place
> > in the 'next' or 'master' branches.
> >
> >> I think it should be a bug in terms of cluster status although it does
> >> not cause any other problems to me so far.
> >
> > Yeah, it's simply a matter of how the internal state is displayed/repor=
ted
> > to the moitor.
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-42010196-1330961291=:11992--
