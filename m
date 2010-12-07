From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Dependence on libcrypto++
Date: Tue, 7 Dec 2010 12:23:49 -0700
Message-ID: <1291749829.4879.371.camel@sale659.sandia.gov>
References: <1291739112.4879.366.camel@sale659.sandia.gov>
 <AANLkTikvXVh0i1aVE=0sJHzWRNmPeeuh8SpKTm=-skck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:37652 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0LGTYF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 14:24:05 -0500
In-Reply-To: <AANLkTikvXVh0i1aVE=0sJHzWRNmPeeuh8SpKTm=-skck@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Tue, 2010-12-07 at 10:54 -0700, Yehuda Sadeh Weinraub wrote:
> On Tue, Dec 7, 2010 at 8:25 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > Hi,
> >
> > Commit 15d8bdf3bf switched to libcrypto++ (AKA libcryptopp)
> > for aes, rather than openssl.
> >
> > It appears that RedHat does not package this
> > library for either Enterprise 5
> >  http://ftp.redhat.com/pub/redhat/linux/enterprise/5Client/en/os/SRPMS/
> > or Enterprise 6
> >  http://ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SRPMS/
> >
> > According to
> >  http://www.cryptopp.com/wiki/Linux#Distributions_Offering_Crypto.2B.2B
> > it's the only major distro that doesn't.
> >
> > So, what's the right thing to do?  Will it be feasible to
> > fall back to openssl if libcryto++ isn't available?
> 
> >From what I can tell you can get currently the required rpm from rpmforge:
> http://packages.sw.be/cryptopp/
> 
> This is not supported officially by RH.

Also, it's easy to build libcrytopp from source; that's
what I'll do for the time being.

> >
> > Are there any RedHat employees on the list who can learn
> > whether there is any chance that RedHat can package
> > libcrypto++/libcryptopp?
> >
> 
> If you (or anyone else that needs it for that matter) have a support
> contract with RH you can try open a bugzilla request asking them to
> pick it up. If we find it to be a real issue we might consider
> switching to gnutls instead of libcrypto++, however, the issue there
> is that we'd have to drop support to older distributions (as it didn't
> export the required lower-level crypto functions until more recent
> releases).

We will open such a request to see what they say.

I'm hopeful ceph will be included in a RedHat
distribution some day, so that this will be
sorted one way or another.

Thanks -- Jim

> 
> Thanks,
> Yehuda
> 


