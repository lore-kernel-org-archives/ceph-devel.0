From: Travis Rhoden <trhoden@gmail.com>
Subject: changing default installed packages by ceph-deploy
Date: Wed, 29 Jul 2015 15:41:29 -0700
Message-ID: <CACkq2mpmFLotjC9u45YHK=fGyUT8kzgvmkX0voxXoasfrLX1ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34111 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbG2Wlt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 18:41:49 -0400
Received: by oigi136 with SMTP id i136so13101449oig.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 15:41:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Right now when a cluster is installed by ceph-deploy, ceph-deploy
installs *everything*.  By this I mean all packages need to run
ceph-mon, ceph-osd, ceph-mds, and radosgw.

The way this is actually split out into packages depends on the
distro.  For RPM-distros, the 'ceph' package includes ceph-mon,
ceph-osd, and ceph-mds. On DEB-distroes, the MDS piece is broken out
into a separate 'ceph-mds' package.

We've been working on splitting MON and OSD into separate packages
(not sure if this will land in Infernalis or not?), and ceph-deploy
has some work in place to install only the needed packages depending
on what daemon you are running on a node.

I'd like to propose a change to the default behavior of ceph-deploy,
such that the default is that it will install OSD and MON only.  For
both RPM and DEB distros this would mean the default is to install the
"ceph" package and it's dependencies.  We would then *not* install
radosgw, and on DEB systems we would not install ceph-mds by default.

There are the following flags in ceph-deploy today that can control
what daemons get installed:

 ceph-deploy install --help
...
  --mon                 install the mon component only
  --mds                 install the mds component only
  --rgw                 install the rgw component only
  --osd                 install the osd component only
  --cli, --common       install the common component only
  --all                 install all ceph components (e.g. mon,osd,mds,rgw).
                        This is the default

So, my proposal is to change the default behavior from "ceph-deploy
install --all ..." to "ceph-deploy install --mon --osd ...".

Any objections?

Keep in mind that ceph-deploy can only limit the daemons on the nodes
based on the current state of the packages.  Meaning there is no way
to not install ceph-mds on RPM systems right now, for example.

Cheers,

 - Travis
