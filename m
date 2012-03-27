From: David McBride <dwm@doc.ic.ac.uk>
Subject: Re: Increasing the number of PGs
Date: Tue, 27 Mar 2012 12:46:11 +0100
Message-ID: <1332848771.8411.68.camel@squire.doc.ic.ac.uk>
References: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
	 <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cardinal.doc.ic.ac.uk ([146.169.1.194]:42818 "EHLO
	cardinal.doc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2C0LqN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 07:46:13 -0400
In-Reply-To: <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: =?ISO-8859-1?Q?Cl=E1udio?= Martins <ctpm@ist.utl.pt>, ceph-devel@vger.kernel.org

On Mon, 2012-03-26 at 16:15 -0700, Tommi Virtanen wrote:

> >  Can anyone clarify if this is still the case as of v0.43 and/or v0.44,
> > or is it safe to increase pg_num on a pool with live data?
> 
> Sadly, that is still the current state of affairs.

Does the act of adding OSDs itself result in the PG count being
increased?  

This seems to be the behaviour I've just observed on my testing cluster
(running 0.44) using an incantation like:

> for i in `seq 14 27`; do
> ceph osd create $i
> ceph osd crush add $i osd.$i 1.0 host=$hostname rack=$rack pool=default
> ceph-osd -i $i --mkfs --mkkey
> ceph -i /etc/ceph/keyring.osd.$i auth add osd.$i osd "allow *" mon "allow rwx"
> done

The number of PGs seems to have roughly doubled, and half of my
OSDs now assert in OSD::get_or_create_pg() with "FAILED assert(role == 0)".

This seems to be a similar failure-mode for others who report issues after 
PG-splitting; as in those cases, `ceph -w` also reports errors of the form:

  [ERR] mkpg 1.1p23 up [5,12] != acting [12]

Have I done something wrong?  Is there some alternate sequence of steps
that avoids / suppresses PG splitting?

Cheers,
David
-- 
David McBride <dwm@doc.ic.ac.uk>
Department of Computing, Imperial College, London

