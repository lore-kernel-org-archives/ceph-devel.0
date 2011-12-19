From: Sage Weil <sage@newdream.net>
Subject: Re: Code Documentation Conventions
Date: Mon, 19 Dec 2011 15:26:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112191518120.27282@cobra.newdream.net>
References: <4EEBAF78.8010605@dreamhost.com>
 <CAORUGqCmaOk8_XsDvRzGZrZ_EZ97J3=uBEM38aKOys3ggSn2GA@mail.gmail.com>
 <CAF3hT9DOwHdPAgEzMu-mkrbrWiMQagPHcQ_gUcuP7ETwAMVDWA@mail.gmail.com>
 <CAORUGqAVHUwr7Neqt6cRWYUqEAmUy_=OybHJJkE+fcqfV0cusw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48668 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab1LSX0I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 18:26:08 -0500
In-Reply-To: <CAORUGqAVHUwr7Neqt6cRWYUqEAmUy_=OybHJJkE+fcqfV0cusw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Josh Durgin <josh.durgin@dreamhost.com>, ceph-devel@vger.kernel.org

On Mon, 19 Dec 2011, Tommi Virtanen wrote:
> On Mon, Dec 19, 2011 at 10:13, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
> >> Personally I've never been crazy about the "*" prefix on every line,
> > I like it as a visibility and "comment type" thing. Plus any good
> > editor will auto-type those for you... ;)
> 
> And on the flip side, any good editor will auto-highlight the /** ...
> */ for you.. ;)

All things being equal, I'd go for * just because that's what everybody 
else does.

Josh, this looks good to me!

sage

