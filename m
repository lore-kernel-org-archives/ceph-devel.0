From: Sage Weil <sage@newdream.net>
Subject: Re: Package requirements for upcoming Infernalis Repository
Date: Tue, 20 Oct 2015 06:23:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510200622130.16833@cobra.newdream.net>
References: <CAC-Np1yPTLJTRfX1N0hF=QxAw=N+aoGZ0FPgyAB5-UivfCooDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54215 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbbJTNXF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 09:23:05 -0400
In-Reply-To: <CAC-Np1yPTLJTRfX1N0hF=QxAw=N+aoGZ0FPgyAB5-UivfCooDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 20 Oct 2015, Alfredo Deza wrote:
> Hi all,
> 
> I am in the process of getting the new Infernalis repository and going
> over the notes I had when
> the Hammer repository was created includes a few packages that didn't
> come from a Ceph build and had to be added manually.
> 
> I don't know which of these packages are still needed for Infernalis,
> so hopefully someone on this list can help rule out the ones that are
> no longer needed:
> 
> * xfsprogs
> * snappy
> * snappy-devel
> * leveldb
> * leveldb-dev
> * gperftools
> * gdisk
> * fcgi
> * curl
> * libcurl
> * libleveldb
> * snappy
> * python-requests
> * urllib3
> 
> *Hopefully* we don't need any of these anymore. Any help would be great.

Yeah, I don't think any of these are needed (on trusty or el7 or 
jessie).  Is that all of them?  Hopefully we don't need to include 
*anything* now other than ceph...

sage
