From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] e330b7: mon: create fail_mds_gid()
 helper; make 'ceph mds ...
Date: Thu, 14 Feb 2013 12:33:10 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302141232180.22023@cobra.newdream.net>
References: <511d3d8377c3d_44de16cbaf025029@sh4.rs.github.com.mail> <CAPYLRzhd9GRrHAQuZZfzvc=RhNX2YM9SrpgvSxdgXtqaDM6_+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [66.33.216.30] ([66.33.216.30]:42762 "EHLO cobra.newdream.net"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758834Ab3BNUdv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Feb 2013 15:33:51 -0500
In-Reply-To: <CAPYLRzhd9GRrHAQuZZfzvc=RhNX2YM9SrpgvSxdgXtqaDM6_+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 14 Feb 2013, Gregory Farnum wrote:
> In the tests I ran last night on this branch I saw some Valgrind
> warnings in the OSDs and Monitors, but I couldn't figure out any way
> for this series to have caused them so I assume they're latent and pop
> up occasionally in master? In any case, please keep an eye out in case
> I was wrong. :)

That is probably a sneaky MMonPaxos leak in the mon.  And the OSD isn't 
yet valgrind leak check clean.

sage
