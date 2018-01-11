From: Sage Weil <sage@newdream.net>
Subject: Re: mon config storage (config-key vs config)
Date: Thu, 11 Jan 2018 13:26:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801111319200.20251@piezo.novalocal>
References: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal> <3f6e4a31-a0e5-d0c6-7b28-ee501081139c@corp.ovh.com> <alpine.LSU.2.21.1801101615130.27069@smaug>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1977735717-1515677185=:20251"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:43939 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbeAKN00 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jan 2018 08:26:26 -0500
In-Reply-To: <alpine.LSU.2.21.1801101615130.27069@smaug>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1977735717-1515677185=:20251
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 Jan 2018, Jesse Williamson wrote:
> On Mon, 8 Jan 2018, Piotr Dałek wrote:
> 
> > * WARNING: "osd objectstore" is deprecated, you should change your config to
> > use "osd/objectstore" instead.
> 
> If there is a 1:1 correspondence between names, I like this idea.

I think it comes down to this.  We have these two options (at least):

1. Current branch

mgr/$module/$option = $value        # mgr module settings, pretty freeform
dm-crypt/osd/$uuid/... = ...        # dm-crypt secrets
config/$option = $value             # global
config/$type/$option = $value       # by type
config/$type.$id/$option = $value   # by daemon
config/.../$type:$val/$option = ..  # filtered by crush, osd class

- config stuff is very clearly separate
- everything not under mgr/ dm-crypt/ config/ above is available for other 
uses


2. Combined schema

mgr/$module/$option = $value        # mgr module settings, pretty freeform
dm-crypt/osd/$uuid/... = ...        # dm-crypt secrets
global/$option = $value             # global
$type/$option = $value              # by type
$type.$id/$option = $value          # by daemon
$type[.$id]/$ctype:$val/$option =   # filtered by crush, osd class

This would result in keys like

mgr/dashboard/...
mgr/debug_mgr
mgr.x/debug_mgr
global/*
osd/*
mds/*
osd.123/

and so on.

- everything exists closer to the same level, looks more unified
- config stuff *still* has distinct prefixes, so we can tell what is a 
traditional config option and what is not
- everything outside of $daemontype and 'global' prefixes (and dm-crypt) 
is still available for other uses.


I'm ignoring the part where we start renaming options (osd_data -> 
osd[.123]/data) -- that is an independent problem to solve IMO.

The only real technical downside I see to #2 above is that the 
laod_config() method in ConfigMonitor has to scan more config-key keys 
than it did before, and be smart enough to ignore mgr/$string/$option keys 
where $string doesn't have a '$this:$that' mask format (should be okay 
since mgr modules can't contain : in the name).

What does everyone think?

sage


--8323329-1977735717-1515677185=:20251--
