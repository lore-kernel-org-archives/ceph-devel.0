From: Sage Weil <sage@newdream.net>
Subject: Re: Two questions
Date: Wed, 27 Jul 2011 08:56:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107270854580.23984@cobra.newdream.net>
References: <8685614628192678277@unknownmsgid>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50068 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1G0Pwe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 11:52:34 -0400
In-Reply-To: <8685614628192678277@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 27 Jul 2011, S?awomir Skowron wrote:
> Hello. I have some questions.
> 
> 1. Is there any chance to change default 4MB object size to for
> example 1MB or less ??

Yeah.  You can use the cephfs to set the default layout on the root 
directory, which will apply to any new files.  See 'man cephfs'.

> 2. I have create cluster of two mons, and 32 osd (1TB each) on two
> machines. At this radosgw with apache2 for test. When i putting data
> from s3 client to rados, everything is ok, but when one of osd is
> going down all s3 clients going to be freeze for some seconds, before
> ceph sign this osd as down, and then everything is starting working
> again wit degraded osd. How can i tune this marking as a down for ms
> or 0 :) and not for seconds freeze ??

The 'osd heartbeat grace' defualt is 20.  Stick something like

	osd heartbeat grace = 5

in the [osd] section of your ceph.conf.

sage

