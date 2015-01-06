From: Ken Dreyer <kdreyer@redhat.com>
Subject: RGW's apache and mod_fastcgi
Date: Tue, 06 Jan 2015 12:14:49 -0700
Message-ID: <54AC3429.2030104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60973 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbbAFTOv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Jan 2015 14:14:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t06JEo75029148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 6 Jan 2015 14:14:51 -0500
Received: from mbp.ktdreyer.com (vpn-50-188.rdu2.redhat.com [10.10.50.188])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t06JEntY031328
	for <ceph-devel@vger.kernel.org>; Tue, 6 Jan 2015 14:14:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

As background for people who are not familiar with this situation: for a
long time Ceph has used some forked copies of Apache and mod_fastcgi to
power the RADOS Gateway.

From discussions with Dan Mick and Yehuda, Ceph's changes to Apache were
mainly cosmetic, and it's ok to use the distro-supplied packages for
Apache going forward. (There's more details regarding this in the
ceph-devel thread, "Ceph's custom apache: ok to drop?"
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/22368)

Regarding mod_fastcgi, this software's license is technically non-free,
and as a result we're going to deprecate mod_fastcgi for the RADOS
Gateway going forward. We are going to advise RGW users to use
mod_proxy_fcgi instead.

Our Ceph docs still advise users to rely on mod_fastcgi and our forked
Apache. Also, this is the stack that our test framework Teuthology uses.
In other words, there is going to be a lot of pieces to change in order
to make this transition.

The plan is to align Teuthology, and our upstream docs, and what we tell
users so that they all match. In practical terms this means:

1) Publicly deprecating our mod_fastcgi and Apache forks,

2) Updating our upstream Ceph documentation to say "use mod_proxy_fcgi"
instead, and give instructions for that,

3) Updating Teuthology to run tests using mod_proxy_fcgi instead of
mod_fastcgi,

4) Packaging our mod_proxy_fcgi fork
(https://github.com/yehudasa/mod-proxy-fcgi) for distros that are still
on Apache 2.2. The relevant distros that ship Apache 2.2 are RHEL 6,
Ubuntu 12.04 ("Precise"), SLES11, and Debian stable ("Wheezy", 7.7).

I've started working on item #3
(https://github.com/ceph/ceph-qa-chef/pull/4), and John Wilkins is
working on updating our documentation (item #2).

There's the question of Unix Domain Sockets support. In Yehuda's testing
with mod_proxy_fcgi, Unix Domain Sockets (UDS) provide a lot better
performance in comparison to TCP sockets. Apache's UDS support shipped
in Apache upstream version 2.4.9, but both RHEL and Ubuntu have versions
older than this. RHEL 7 has httpd 2.4.6, and Trusty has 2.4.7. My
intention is to request that the Ubuntu apache2 maintainers to backport
UDS to their Trusty package, similarly to what Red Hat intends to ship
in RHEL 7.1.

I want to be sure that we're engaging the broader community with the
changes we're intending, so please let me know your feedback.

- Ken
