From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: mon: forwarding user commands
Date: Mon, 19 Jan 2015 09:02:51 +0200
Message-ID: <20150119070248.GA14221@gmail.com>
References: <20150118092815.GA2488@gmail.com>
 <alpine.DEB.2.00.1501181030070.8527@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:51868 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbASHCm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 02:02:42 -0500
Received: by mail-wi0-f171.google.com with SMTP id l15so4880394wiw.4
        for <ceph-devel@vger.kernel.org>; Sun, 18 Jan 2015 23:02:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1501181030070.8527@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Jan 18, 2015 at 10:33:05AM -0800, Sage Weil wrote:
> On Sun, 18 Jan 2015, Mykola Golub wrote:
> > Hi Ceph,
> > 
> > Right now, for not a monitor leader, if a received command is not
> > supported locally, but is supported by the leader, it is forwarded to
> > the leader.
> > 
> > For the recently added "ceph tell mon.x version" it gives a confusing
> > behavior: if the mon.x is not a leader and does not support "version"
> > command yet, but the leader does, the user will receive the version of
> > the leader, and can't be actually sure about a non leader version.
> > 
> > I have a patch that fixes this by checking if the received "version"
> > command is forwarded and returning the error in this case:
> > 
> > https://github.com/trociny/ceph/commit/98f835357e378b1c5f05b32ba90a8b8537ba1ad8
> > 
> > But may be we need a more general solution? We might face a similar
> > issue in future, when adding a new command, which is not expected to
> > be forwarded to the leader (like injectargs).
> 
> Yeah.. that works for 'version' but not any other 'tell mon ...' command.
> 
> I think the way to do it properly going forward is to add a flags field to 
> MMonCommand, with a flag NOFORWARD.
> 
> That won't help in the version case, so we can combine it with your 
> patch...

Do you mean

1) statically adding the NOFORWARD flag to commands definitions in
MonCommands.h (and to the struct MonCommand in Monitor.h), and then
checking for the flag in Monitor::handle_command(), before forwarding
to the leader, or

2) extending librados API, RadosClient::mon_command(), so a user could
set the flag for any sent command she don't want to be forwarded, and
using this flag for 'ceph tell mon.x ...' commands?

I think you mean (2), but just to be sure, before coding this...

-- 
Mykola Golub
