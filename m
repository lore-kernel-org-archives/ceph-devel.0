From: Sage Weil <sage@newdream.net>
Subject: Re: g_conf.id, g_conf.name, g_conf.type and friends
Date: Wed, 23 Feb 2011 14:42:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102231438190.5412@cobra.newdream.net>
References: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
 <20110223221353.GA30697@dreamer> <AANLkTinGw2Mf611-O72RSw-fk7JPTuahvP83BECKkX=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42254 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab1BWWkb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 17:40:31 -0500
In-Reply-To: <AANLkTinGw2Mf611-O72RSw-fk7JPTuahvP83BECKkX=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

On Wed, 23 Feb 2011, Colin Patrick McCabe wrote:
> On Wed, Feb 23, 2011 at 2:13 PM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
> > On Wed, Feb 23, 2011 at 01:58:19PM -0800, Colin Patrick McCabe wrote:
> >> *** g_conf.id: this is a username or a daemon name, depending on the program.
> >> It defaults to "admin" for our various command-line tools, but can be
> >> changed by the -i command-line argument.
> >> For an MDS, this would be "a" or "b", or similar.
> >
> > Noob question: why not 0, 1, ..?
> 
> You're not the only one to ask why OSDs are osd.0, osd.1, etc.,
> whereas MDSes are mds.a, mds.b, etc. I think the reasons are
> historical.

The MDS ranks are internally numbered and tracked that way, so that a 
simple int represents who owns what.  However, which rank/role and MDS 
fills is different than the MDS identify (which host/instance of the 
daemon), as any daemon can fill any role.  Hence the alphanumerical names.

Same goes for monitors.

For OSDs, things are a bit different, since a cosd daemon can only fill 
the role for which it actually has the data.  Alphanumeric names might be 
nice for an admin, but that's all they'd accomplish.

> This is kind of an obscure configuration quirk, though. My point was
> that g_conf.type is redundant since we have the same info in a nicely
> parsed form in g_conf.entity_name. (There's no reason we can't
> continue to support the quirky no-period syntax either.)

Yeah, I think can you safely clean that up.  Unless it's needed right now, 
though, let's push it off for the 0.26 branch so that we have plenty of 
time to catch any weird fallout.  (Same goes for anything else that isn't 
needed to get the librados API changes in place and functional.)

sage
