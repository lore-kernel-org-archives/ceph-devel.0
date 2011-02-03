From: Sage Weil <sage@newdream.net>
Subject: Re: block level diffs in rbd/librados snapshots?
Date: Thu, 3 Feb 2011 09:17:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102030915210.19855@cobra.newdream.net>
References: <AANLkTikYU1uy+W9JGwLYwHzYo22s8CEfpFbhubJc0osi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52429 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170Ab1BCRQ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 12:16:29 -0500
In-Reply-To: <AANLkTikYU1uy+W9JGwLYwHzYo22s8CEfpFbhubJc0osi@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 3 Feb 2011, Brian Chrisman wrote:
> I'm wondering whether I can get block level diff data from the
> underlying rados storage to allow me to perform a kind of 'block level
> incremental backup' facility.
> I can't quite tell from the documentation whether this would be
> supported via snapshotting (ie, can I get a map/list of blocks which
> have been changed since I created a snapshot on Monday?)

The OSD has this information internally.  It keeps track of the unchanged 
overlap between each consecutive snap/version of each object 
(SnapSet::clone_overlap in osd/osd_types.h).  I think this would just be a 
matter of adding an OSD operation to expose that information.  See the 
CEPH_OSD_OP_* defines in include/rados.h, and the ceph_osd_op 
struct/union.

sage
