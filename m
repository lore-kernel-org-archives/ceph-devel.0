From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: packaging for ceph-gui
Date: Tue, 14 Dec 2010 21:50:39 +0100
Message-ID: <1292359839.25794.99.camel@julia.gcs.org.hu>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
	 <1292358476.25794.88.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:40176 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759759Ab0LNUwJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Dec 2010 15:52:09 -0500
In-Reply-To: <Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Tue, 2010-12-14 at 12:37 -0800, Sage Weil wrote:
> On Tue, 14 Dec 2010, Laszlo Boszormenyi wrote:
> >  It's up to you how to name it. As for the rule of thumb, packages named
> > after the binary they contain. So it should be gceph, but can be
> > ceph-gui if you want.
> 
> I'm inclined to rename gceph to ceph-gui, actually, unless anyone has any 
> strong opinions about it...
 Either is fine for me, should be gceph after the binary but I admit
that ceph-gui is more suitable for its name. Still if I've a voting
right, I'd say ceph-gui suggests it's only a GUI for the CLI binary
(needs ceph, just calls ceph with it's switches in the background). It's
not the case, it's a standalone binary, a graphical ceph -> gceph. Of
course the choice is yours.

> > The question is, when do you want to merge these changes to rc? There
> > are unstable and gceph trees available, but are they for v0.24 or not?
> 
> The binary is standalone.  They should just recommend each other, I think. 
> And this is all in the unstable branch (for v0.25), so we can just change 
> it there.
 OK, will do tomorrow if you decide on how to name its package.

Offtopic: What's your timezone? I'm UTC/GMT +1.

Laszlo/GCS

