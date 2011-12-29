From: Florian Haas <florian@hastexo.com>
Subject: [PATCH 0/2] Add Ceph integration with OCF-compliant HA resource managers
Date: Thu, 29 Dec 2011 20:58:00 +0100
Message-ID: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52789 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1L2T7T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 14:59:19 -0500
Received: by eekc4 with SMTP id c4so13165980eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Dec 2011 11:59:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

please consider reviewing the following patches. These add
OCF-compliant cluster resource agent functionality to Ceph, allowing
MDS, OSD and MON to run as cluster resources under compliant managers
(such as Pacemaker, http://www.clusterlabs.org).

This new stuff does not build nor install by default; you must enable
with the "--with-ocf" flag. That same flag maps to a new RPM build
conditional ("--with ocf") which rolls the resource agents into a
separate subpackage, "ceph-resource-agents".

These patches require the tiny patch to the init script that I posted
here a few days ago.

Just in case you're interested, all the above changes (including the
init script patch) since commit e18b1c9734e88e3b779ba2d70cdd54f8fb94743d:

  rgw: removing swift user index when removing user (2011-12-28 17:00:19 -0800)

are also available in my GitHub repo at:
  git://github.com/fghaas/ceph ocf-ra

Florian Haas (3):
      init script: be LSB compliant for exit code on status
      Add OCF-compliant resource agent for Ceph daemons
      Spec: conditionally build ceph-resource-agents package

 ceph.spec.in        |   22 ++++++
 configure.ac        |    8 ++
 src/Makefile.am     |    4 +-
 src/init-ceph.in    |    7 ++-
 src/ocf/Makefile.am |   23 +++++++
 src/ocf/ceph.in     |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 238 insertions(+), 3 deletions(-)
 create mode 100644 src/ocf/Makefile.am
 create mode 100644 src/ocf/ceph.in

Hope this is useful. All feedback is much appreciated. Thanks!

Cheers,
Florian
