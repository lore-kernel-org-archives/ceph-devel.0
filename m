From: Sage Weil <sage@newdream.net>
Subject: Re: Where I can find the definition/meanings of options parameter
 in /src/common/config.cc
Date: Thu, 7 Apr 2011 14:45:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104071444540.18507@cobra.newdream.net>
References: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
 <BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
 <BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50580 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab1DGVmi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 17:42:38 -0400
In-Reply-To: <BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, AnnyRen <annyren6@gmail.com>, ceph-devel@vger.kernel.org

On Thu, 7 Apr 2011, Yehuda Sadeh Weinraub wrote:
> On Thu, Apr 7, 2011 at 9:33 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> > Hi AnnyRen,
> ...
> > Also, after using injectargs to change a setting related to logging,
> > you must send the process a SIGHUP to get it to re-read its logging
> > settings.
> 
> I assume this is a relatively new requirement? Usually you'd send HUP
> signal to re-read the conf file. When using injectargs, one would
> assume that the new configuration was already updated. Moreover,
> sending HUP signal to all your osds/mds/mons is awfully inconvenient.
> Maybe we can just send the HUP signal in the appropriate handlers?

It's just for logging parameters.  If you change log_file, for example, it 
won't take effect until you SIGHUP and reopen the log.

sage
