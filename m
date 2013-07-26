From: Noah Watkins <noah.watkins@inktank.com>
Subject: blueprint: ceph platform portability
Date: Fri, 26 Jul 2013 16:07:01 -0700
Message-ID: <CA+Hcz5-WA8uKo9HjN48Z3tnT0RJBE2z8gKKtkEEFndKUb2iCTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:61722 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757607Ab3GZXHD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jul 2013 19:07:03 -0400
Received: by mail-vb0-f47.google.com with SMTP id h10so1581026vbh.34
        for <ceph-devel@vger.kernel.org>; Fri, 26 Jul 2013 16:07:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Increasing_Ceph_portability

Recently I've managed to get Ceph built and running on OSX. There was
a past effort to get Ceph working on non-Linux platforms, most notably
FreeBSD, but that approach introduced a lot of ad-hoc macros that has
made it difficult to manage changes needed to support additional
platforms.

This session would address the areas within Ceph that are currently
non-portable, discuss the state of OSX support, and touch on what is
needed to factor out platform specific functionality. Changes are
roughly grouped into (1) internal critical (e.g. locking) (2) internal
non-critical (some optimizations), and (2) exported headers. A
significant amount of the OSX changes have been introduced as feature
tests with generic alternatives, and as such the tree may already be
near building on additional platforms, so it would be great to find
people that would be willing to test on additional platforms.

If you are interested please add yourself as an interested party or
owner of this blueprint :)
