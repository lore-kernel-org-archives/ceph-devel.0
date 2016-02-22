From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 22 Feb 2016 12:16:51 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602221215110.13918@cpach.fuggernut.com>
References: <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net> <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com> <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com> <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com> <20151208044640.GL1983@devil.localdomain> <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com> <20160216033538.GB2005@devil.localdomain> <CA+gn+z=dGTeLo71h=z=AvoLM-RRq_-RfbJwFamyfxK93bvk+Hw@mail.gmail.com>
 <CA+gn+zmCx_Pu6oEUT31SfKRF1A9Pzi1aWTPbXJY7dOgQqCqARQ@mail.gmail.com> <20160219052637.GF2005@devil.localdomain> <alpine.DEB.2.11.1602220656530.13988@cpach.fuggernut.com> <CA+gn+zkqOONNFf7cncMngHVz_-PqxWYf9x2-jK3AECNnQjPRxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33531 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbcBVRRT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Feb 2016 12:17:19 -0500
In-Reply-To: <CA+gn+zkqOONNFf7cncMngHVz_-PqxWYf9x2-jK3AECNnQjPRxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier <david.casier@aevoo.fr>
Cc: Dave Chinner <dchinner@redhat.com>, Ric Wheeler <rwheeler@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>, Eric Sandeen <esandeen@redhat.com>, =?ISO-8859-15?Q?Beno=EEt_LORIOT?= <benoit.loriot@aevoo.fr>

On Mon, 22 Feb 2016, David Casier wrote:
> Hi Sage,
> Are you optimistic about the release of Bluestore ?

Yes.  It'll be part of Jewel, although still not the default and still 
marked experimental (since it's a complete rewrite of the storage layer 
and obviously pretty critical).  The goal is to make it default by the 
next release (kraken, september-ish).

sage
