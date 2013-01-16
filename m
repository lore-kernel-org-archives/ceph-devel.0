From: Sage Weil <sage@inktank.com>
Subject: Re: REMINDER: all argonaut users should upgrade to v0.48.3argonaut
Date: Wed, 16 Jan 2013 08:39:57 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301160838470.14733@cobra.newdream.net>
References: <alpine.DEB.2.00.1301151348330.24455@cobra.newdream.net> <CAOLwVU=0N2rrKFWoXoLm9ZmjgchVDcTCx7LHXTctvp9WVORRJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45105 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3APQj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 11:39:58 -0500
In-Reply-To: <CAOLwVU=0N2rrKFWoXoLm9ZmjgchVDcTCx7LHXTctvp9WVORRJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 16 Jan 2013, S?bastien Han wrote:
> Can we use this doc as a reference for the upgrade?
> 
> https://github.com/ceph/ceph/blob/eb02eaede53c03579d015ca00a888a48dbab739a/doc/install/upgrading-ceph.rst

Yeah.  It's pretty simple in this case (since it's a point release 
upgrade):

 - install new package everywhere
 - restart daemons

(at any rate, in any order)

The most important ones to upgrade in this case are the ceph-osd's.

sage
