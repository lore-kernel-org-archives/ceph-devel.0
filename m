From: Brian Chrisman <brchrisman@gmail.com>
Subject: packaging for RHEL6beta
Date: Tue, 7 Dec 2010 14:43:54 -0800
Message-ID: <AANLkTingoDPDi5xZtywVy5js687+4jmwnz4t+Mt1B0WP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55323 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab0LGWnz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 17:43:55 -0500
Received: by qyk11 with SMTP id 11so5563539qyk.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Dec 2010 14:43:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've built RPMs for RHEL6beta from the spec file in the rc (checked
out as of Monday) using the provided ceph.spec.
Thus far I've run into a few issues:
1) Version:       0.24~rc ... converted to 0.24.rc (doesn't like the ~ symbol)
2)  'gui_resources' not getting into BUILDROOT correctly.. I'm
commenting it out in my spec file for now figuring it's probably
non-essential?
3) /usr/lib/debug/usr/lib64/rados-classes/libcls_rbd.so.1.0.0.debug is
installed but unpackaged (In spec file I see this is being touched for
a purpose that's not clearly apparent to me.. the path is mucked up
with the usr/lib/debug prepended to usr/lib64.. etc.. so I'm
commenting that section out too as it builds a separate directory
structure in what looks like the wrong place.)
4) turned off RPATH checking (I'm not an rpm superhero...)

With these caveats, the packages build and install on RHEL6beta.
Will test a cluster with these packages next.

-Brian
