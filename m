From: Sage Weil <sage@newdream.net>
Subject: Re: [Ceph-announce] Important security noticed regarding release
 signing key
Date: Wed, 23 Sep 2015 06:16:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509230615500.11876@cobra.newdream.net>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net> <87twqlb8gu.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41441 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbbIWNQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 09:16:52 -0400
In-Reply-To: <87twqlb8gu.fsf@meteor.durcheinandertal.bofh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaudenz Steinlin <gaudenz.steinlin@cirrax.com>
Cc: ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Wed, 23 Sep 2015, Gaudenz Steinlin wrote:
> Sage Weil <sage@newdream.net> writes:
> 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Last week, Red Hat investigated an intrusion on the sites of both the Ceph 
> > community project (ceph.com) and Inktank (download.inktank.com), which 
> > were hosted on a computer system outside of Red Hat infrastructure.
> >
> > Ceph.com provided Ceph community versions downloads signed with a Ceph 
> > signing key (id 7EBFDD5D17ED316D). Download.inktank.comprovided releases 
> > of the Red Hat Ceph product for Ubuntu and CentOS operating systems signed 
> > with an Inktank signing key (id 5438C7019DCEEEAD). While the investigation 
> > into the intrusion is ongoing, our initial focus was on the integrity of 
> > the software and distribution channel for both sites.
> >
> > To date, our investigation has not discovered any compromised code or 
> > binaries available for download on these sites. However, we cannot fully 
> > rule out the possibility that some compromised code or binaries were 
> > available for download at some point in the past. Further, we can no 
> > longer trust the integrity of the Ceph signing key, and therefore have 
> > created a new signing key (id E84AC2C0460F3994) for verifying downloads. 
> > This new key is committed to the ceph.git repository and is 
> > also available from
> >
> > 	https://git.ceph.com/release.asc
> >
> > The new key should look like:
> >
> > pub   4096R/460F3994 2015-09-15
> > uid                  Ceph.com (release key) <security@ceph.com>
> >
> > All future release git tags will be signed with this new key.
> >
> > This intrusion did not affect other Ceph sites such as download.ceph.com 
> > (which contained some older Ceph downloads) or git.ceph.com (which mirrors 
> > various source repositories), and is not known to have affected any other 
> > Ceph community infrastructure.  There is no evidence that build system or 
> > the Ceph github source repository were compromised.
> >
> > New hosts for ceph.com and download.ceph.com have been created and the 
> > sites have been rebuilt.  All content available on download.ceph.com as 
> > been verified, and all ceph.com URLs for package locations now redirect 
> > there.  There is still some content missing from download.ceph.com that 
> > will appear later today: source tarballs will be regenerated from git, and 
> > older release packages are being resigned with the new release key DNS 
> > changes are still propogating so you may not see the new versions of the 
> > ceph.com and download.ceph.com sites for another hour or so.
> 
> It would be nice to have a way to verify the integrity of tarballs
> downloaded from http://download.ceph.com/tarballs/. Could you please add
> individual signatures or an sha256sum file signed with your release key.
> This is important for people building from source tarballs and
> distribution packagers baseing their packages from tarballs. Debian and
> Ubuntu packages are currently built from them.

Future releases will have tarball signatures.  Alfredo and Andrew are 
working on the new build/release tooling now.

sage
