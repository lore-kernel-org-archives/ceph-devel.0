From: Dan Mick <dmick@redhat.com>
Subject: Change to teuthology-suite -k
Date: Tue, 16 Dec 2014 13:09:35 -0800
Message-ID: <54909F8F.70104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbaLPVJj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Dec 2014 16:09:39 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: storage-eng@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>, sepia@ceph.com, ceph-qa <ceph-qa@ceph.com>

tl;dr: after https://github.com/ceph/teuthology/pull/394 is merged, -k
testing is no longer the default for teuthology-suite; if you want it,
specify it on the CLI or in the yaml.

Further explanation:

teuthology-suite, by default, currently adds a 'kernel:' stanza to the
yaml file that requests the 'testing' kernel branch be installed on the
test machines.  Currently, the only way to not affect the installed
kernel is to specify "-k -" on the teuthology-suite commandline (to
override the default "-k testing".

Since there are some tests where the particular version of the kernel is
not important (say, Calamari tests), and since vps'es often have a
suitable kernel, and since installing a kernel and rebooting is pretty
expensive, I've changed teuthology-suite so it no longer installs a
kernel by default.  The previous behavior is available by specifying "-k
testing" explicitly (or adding a kernel stanza to the yaml for the suite
in question).

All cron jobs on teuthology and magna002 have already been changed to
explicitly specify a kernel branch.--
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs
-- 
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs
