From: Nathan Cutler <ncutler@suse.cz>
Subject: Isn't --allhosts dangerous?
Date: Sun, 27 Sep 2015 23:51:47 +0200
Message-ID: <560864F3.4000900@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53644 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbbI0Vvt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Sep 2015 17:51:49 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C4E3BAB9D
	for <ceph-devel@vger.kernel.org>; Sun, 27 Sep 2015 21:51:46 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Taking actions cluster-wide via a shell script seems like it could have
dangerous unexpected side effects, and indeed while looking through old
tickets, I ran across http://tracker.ceph.com/issues/9407 . . .

This is "fixed" (by getting rid of the --allhosts option to init-ceph)
in https://github.com/ceph/ceph/pull/6089

The same PR also adds getopt to make processing of command-line options
more flexible.

Opinions? Reviews?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
