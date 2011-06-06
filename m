From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: ceph rados.py packaging help
Date: Mon, 6 Jun 2011 10:50:55 -0700
Message-ID: <20110606175055.GA2569@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39819 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab1FFRuz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2011 13:50:55 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

Hi Laszlo! (And hi Cc'ed ceph-dev.)

As you probably know, the Ceph project tries to provide debs for
Debian lenny, squeeze and sid, and Ubuntu lucid, maverick and natty.

We're starting to add Python bindings to libceph, librados etc,
and ran into a case where not 100% sure how to handle. That is,
how should we package e.g. rados.py so that the packaging works
across as many releases as we can?

There is the Debian Python Policy, but that usually only documents the
current best behavior; how do we target more than squeeze/sid?
http://www.debian.org/doc/packaging-manuals/python-policy/ e.g. should
we use python-central, python-support, put the files ourselves into
/usr/lib/pythonX.Y/dist-packages (or site-packages, for <2.6), or
what?

(I heard Sage was perhaps willing to drop some of the oldest releases,
if this proves insurmountable to do with just one style of packaging.
Our internal needs may dictate that we must support some older
versions, but I think those setups are going to need a virtualenv
anyway, soon..)

Any guidance you can provide would be very welcome. Thanks!

-- 
:(){ :|:&};:
