From: Sage Weil <sage@newdream.net>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Wed, 30 Jun 2010 11:06:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006301104320.29167@cobra.newdream.net>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
 <Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
 <AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-678454730-1277921217=:29167"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52338 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab0F3SFf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jun 2010 14:05:35 -0400
In-Reply-To: <AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-678454730-1277921217=:29167
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 30 Jun 2010, S=E9bastien Paolacci wrote:
> It actually works better when removing the old deb pacakge;)... thanks!

Good to hear!

> I however get the a bunch of metadata sync warnings on the cfuse side
> "10.06.30_13:16:20.556187 7f2bc5817720 client4100 fsync - not syncing
> metadata yet.. implement me"

Added this to the issue tracker.

> On a different topic (sorry for the mix-up), pushing the journal on a
> seperate partition give me the following crash:

Hmm.. is this reproducible?  I just pushed something to ceph.git unstable=
=20
that prints out useful debugging info when that happens, but the question=
=20
remains what is causing it to happen in the first place.  Do you mind=20
giving the latest a go and seeing what it tells us?

Thanks!
sage
--557981400-678454730-1277921217=:29167--
