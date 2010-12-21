From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: packaging for ceph-gui
Date: Tue, 21 Dec 2010 22:59:42 +0100
Message-ID: <1292968782.25876.76.camel@julia.gcs.org.hu>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
	 <1292358476.25794.88.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
	 <1292359839.25794.99.camel@julia.gcs.org.hu>
	 <AANLkTikmi_Ke02Fd4BrRXGCiKHSuQhCwY6UME+QU04Uh@mail.gmail.com>
	 <1292942649.25876.36.camel@julia.gcs.org.hu>
	 <AANLkTi=svKVzDkiKCYj5LD-_Vc4ZR0VY+_u0R9ZhC-XY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:52311 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab0LUWAf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Dec 2010 17:00:35 -0500
In-Reply-To: <AANLkTi=svKVzDkiKCYj5LD-_Vc4ZR0VY+_u0R9ZhC-XY@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, 2010-12-21 at 16:32 -0500, Colin McCabe wrote:
> On Tue, Dec 21, 2010 at 9:44 AM, Laszlo Boszormenyi <gcs@debian.hu> wrote:
> >  I've a question. gceph needs everything noted in debian/ceph.install
> > (cephfs, cconf, ... the rados classes and manpages), right? The best
> > would be to make a ceph-common package, depending on ceph | gceph and
> > the latter packages would contain only the binaries ceph and gceph
> > respectively. Am I right?
> 
> Yeah. gceph should be a separate, optional package. If you install
> gceph, you definitely want the rest of the ceph system, but not vice
> versa.
 Do you mean that installing gceph, the CLI ceph is also needed?

> I'm not sure if it makes sense to split off the command-line ceph tool
> from the rest of the ceph binaries. It's not a lot of code, and it is
> a handy little binary. I guess potentially we could do it if it makes
> the packaging cleaner.
 OK, play with letters. 'A' will mean cephfs via rados classes to
manpages; with the package name ceph-common. 'B' will mean the ceph
binary and its manpage. 'C' is for gceph and its manpage (if any).
(A+B) <-> (A+C) definitely a no go, as they would need to conflict with
  each other.
A - B - C can be a choice, even if B and C will be small in size.
(A+B) - C is an other option, this time C will depend on (A+B).

Either of the two latter is fine with me. I'd go A-B-C if gceph is fine
without the ceph binary. Otherwise (A+B)-C is the only option as I see.
It's up to you, upstream which one would be the best. Reading your last
reply, you would like to have (A+B)-C as C depending on (A+B), right?

Laszlo/GCS

