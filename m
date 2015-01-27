From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: mon: forwarding user commands
Date: Tue, 27 Jan 2015 10:31:16 +0200
Message-ID: <20150127083115.GB12175@gmail.com>
References: <20150118092815.GA2488@gmail.com>
 <alpine.DEB.2.00.1501181030070.8527@cobra.newdream.net>
 <20150119070248.GA14221@gmail.com>
 <CAC6JEv_fnZhVymT0d7dO2iJxeZNp7mmy9WxDQEeYj1qQg-fppg@mail.gmail.com>
 <alpine.DEB.2.00.1501190716540.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:63554 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbbA0Ibp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jan 2015 03:31:45 -0500
Received: by mail-la0-f42.google.com with SMTP id ms9so11993360lab.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jan 2015 00:31:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1501190716540.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 19, 2015 at 07:17:58AM -0800, Sage Weil wrote:
> On Mon, 19 Jan 2015, Gregory Farnum wrote:
> > On Sun, Jan 18, 2015 at 11:02 PM, Mykola Golub <mgolub@mirantis.com> wrote:
> > > On Sun, Jan 18, 2015 at 10:33:05AM -0800, Sage Weil wrote:
> > >> On Sun, 18 Jan 2015, Mykola Golub wrote:
> > >> > Hi Ceph,
> > >> >
> > >> > Right now, for not a monitor leader, if a received command is not
> > >> > supported locally, but is supported by the leader, it is forwarded to
> > >> > the leader.
> > >> >
> > >> > For the recently added "ceph tell mon.x version" it gives a confusing
> > >> > behavior: if the mon.x is not a leader and does not support "version"
> > >> > command yet, but the leader does, the user will receive the version of
> > >> > the leader, and can't be actually sure about a non leader version.
> > >> >
> > >> > I have a patch that fixes this by checking if the received "version"
> > >> > command is forwarded and returning the error in this case:
> > >> >
> > >> > https://github.com/trociny/ceph/commit/98f835357e378b1c5f05b32ba90a8b8537ba1ad8
> > >> >
> > >> > But may be we need a more general solution? We might face a similar
> > >> > issue in future, when adding a new command, which is not expected to
> > >> > be forwarded to the leader (like injectargs).
> > >>
> > >> Yeah.. that works for 'version' but not any other 'tell mon ...' command.
> > >>
> > >> I think the way to do it properly going forward is to add a flags field to
> > >> MMonCommand, with a flag NOFORWARD.
> > >>
> > >> That won't help in the version case, so we can combine it with your
> > >> patch...
> > >
> > > Do you mean
> > >
> > > 1) statically adding the NOFORWARD flag to commands definitions in
> > > MonCommands.h (and to the struct MonCommand in Monitor.h), and then
> > > checking for the flag in Monitor::handle_command(), before forwarding
> > > to the leader, or
> 
> Hmm, this is a cleaner way to approach your change that specifically 
> applies to the new 'version' command.
> 
> > > 2) extending librados API, RadosClient::mon_command(), so a user could
> > > set the flag for any sent command she don't want to be forwarded, and
> > > using this flag for 'ceph tell mon.x ...' commands?
> 
> ..but I think we also want this, so that *any* 'ceph tell mon.whatever 
> ...' command can be flagged to not get forwarded.

I have created a pull request that implements both:

https://github.com/ceph/ceph/pull/3496

The (2) looks not very useful for now -- I suppose currently the only
command that suffers from the describe problem is "version" and it has
"noforward" hard coded. This might change in future though.

-- 
Mykola Golub
