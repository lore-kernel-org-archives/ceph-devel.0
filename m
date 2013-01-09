From: Sage Weil <sage@inktank.com>
Subject: Re: Windows port
Date: Wed, 9 Jan 2013 09:04:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301090859230.6155@cobra.newdream.net>
References: <CAJVE5RWjv9ZVpTX5rxB1dL7bDSCtqkfr-Ac5m0hEnprANpwu0Q@mail.gmail.com> <CAJVE5RV-JZzK7Ofe9q2whcxp1eHquE_A2YELof8TAzBVjcsfgQ@mail.gmail.com> <CA+GnOzR29oKSXWpuS8dffsXJWChzMvTCFQ+dutmAm+zsuVkBgQ@mail.gmail.com>
 <CAPUexz_5CMm6sMXcMYCXJXgcBxemLOKaymtF0EgpoGvdg72PmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38605 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220Ab3AIRED (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 12:04:03 -0500
In-Reply-To: <CAPUexz_5CMm6sMXcMYCXJXgcBxemLOKaymtF0EgpoGvdg72PmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Dino Yancey <dino2gnt@gmail.com>, Cesar Mello <cmello@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 9 Jan 2013, Florian Haas wrote:
> On Tue, Jan 8, 2013 at 3:00 PM, Dino Yancey <dino2gnt@gmail.com> wrote:
> > Hi,
> >
> > I am also curious if a Windows port, specifically the client-side, is
> > on the roadmap.
> 
> This is somewhat OT from the original post, but if all you're
> interested is using RBD block storage from Windows, you can already do
> that by going through an iSCSI or FC head node. Proof-of-concept
> configuration outlined here:
> 
> http://www.hastexo.com/resources/hints-and-kinks/turning-ceph-rbd-images-san-storage-devices
> 
> Not sure if this helps, but just thought I'd mention it.

There is also a patch for Samba that glues libcephfs into Samba's VFS 
layer.  This will let you reexport CephFS via CIFS.  These patches are 
currently living at

	https://github.com/ceph/samba/commits/ceph-v3-6-test

If anybody is interested in playing with these, have at it!  Inktank 
doesn't have resources to focus on it right now.

sage
