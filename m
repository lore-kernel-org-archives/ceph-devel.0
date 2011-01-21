From: Matthias Urlichs <matthias@urlichs.de>
Subject: Ceph distributed over slow link: possible?
Date: Fri, 21 Jan 2011 19:55:33 +0000 (UTC)
Message-ID: <ihcobl$bal$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43558 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724Ab1AVHpG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 22 Jan 2011 02:45:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PgY9g-0007KE-IR
	for ceph-devel@vger.kernel.org; Sat, 22 Jan 2011 08:45:04 +0100
Received: from netz.smurf.noris.de ([213.95.21.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 22 Jan 2011 08:45:04 +0100
Received: from matthias by netz.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 22 Jan 2011 08:45:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello ceph people,

My situation is this: my Ceph cluster is distributed over multiple
sites. The links between sites are rather slow. :-/

Storing one copy of a file at each site should not be a problem with
a reasonable crushmap, but ..:

* how can I verify on which devices a file is stored?

* is it possible to teach clients to read/write from "their", i.e.
  the local site's, copy of a file, instead of pulling stuff from
  a remote site? Or does ceph notice the speed difference by itself?

* My crushmap looks like this:
type 0  device
type 1  host
type 2  site
type 3  root
... (root => 2 sites => 2 hosts each => 3 devices each)
rule  data {
        ruleset 0
        type replicated
        min_size 2
        max_size 2
        step take  root
        step chooseleaf firstn 2 type site
        step emit
}

but when only one site is reachable, will there be one or two
copies of a file? If the former, how do I fix that? If the latter,
will the copy be redistributed when (the link to) the second site
comes back?

-- 

