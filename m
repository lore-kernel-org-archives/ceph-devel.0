From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 16 Feb 2011 14:51:09 -0700
Message-ID: <1297893069.25491.125.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <1297892243.4361.2.camel@Nokia-N900-02-8>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:44856 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab1BPVv3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 16:51:29 -0500
In-Reply-To: <1297892243.4361.2.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-02-16 at 14:37 -0700, Wido den Hollander wrote:
> Hi,
> ----- Original message -----
> > Hi,
> >
> > I've been testing v0.24.3 w/ 64 clients against
> > 1 mon, 1 mds, 96 osds.   Under heavy write load I
> > see:
> >     [WRN] map e7 wrongly marked me down or wrong addr
> 
> I'm seeing the same, for example when the cluster is recovering.
> 
> My thougths is that it is something btrfs related where the OSD is
> hanging on, do you see the same? (Check the stack of the process
> in /proc). (Thnx colin!)
> 
> It showed me that it was stalling on btrfs ioctls.

Thanks, I'll try to see if I can catch this.

-- Jim

> 
> Wido


