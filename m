From: Sage Weil <sage@newdream.net>
Subject: Re: master branch in git
Date: Wed, 26 Jan 2011 14:01:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101261357390.27034@cobra.newdream.net>
References: <1296076567.1802.16.camel@dogen>
 <AANLkTimjgPj2wQhtw1zg8NK-jsLPk1RUHiRcjA0XH8RV@mail.gmail.com>
 <1296078697.1802.37.camel@dogen>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43827 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab1AZWBS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 17:01:18 -0500
In-Reply-To: <1296078697.1802.37.camel@dogen>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Leach <john@brightbox.co.uk>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah.  Currently:

 master - last release (but I forgot to update it)
 unstable - unstable
 testing - bug fixes to last release, will become next stable release
 rc - will become next major release

I agree that's not optimal.  I think moving unstable to work to master 
makes sense.

How about something like:

 master - unstable (and get rid of 'unstable' branch)
 testing or stable - bug fixes to last release.
 rc or next - what will be the next major release

Does anyone see value in having a branch that has the last release?  They 
can see that with the git tags.

sage

