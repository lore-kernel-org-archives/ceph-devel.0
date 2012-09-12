From: Jan Engelhardt <jengelh@inai.de>
Subject: ceph-level build system fixes & cleanup
Date: Wed, 12 Sep 2012 04:22:01 +0200
Message-ID: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ares07.inai.de ([5.9.24.206]:48869 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757178Ab2ILCWQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Sep 2012 22:22:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org


Hi,

per our short exchange in private, I am taking to spruce up the
ceph build system definitions. First comes leveldb, more shall
follow soonish.

Patches #1=E2=80=932 are mandatory for continued successful operation,
#3=E2=80=935 cosmetical, and #6 a proposal.
You are free to merge, pick or give blame :)

=3D=3D
The following changes since commit eee22bb3eca01404983f38109232034a3fcf=
f474:

  .gitignore: TAGS (2012-03-16 09:42:18 -0700)

are available in the git repository at:

  git://git.inai.de/ceph-leveldb master

for you to fetch changes up to d37b898848d28401dc50d4688ad82b162faa9ada=
:

  build: provide libleveldb as a shared library (2012-09-12 04:14:13 +0=
200)

----------------------------------------------------------------
Jan Engelhardt (6):
      build: do not modify user variables
      build: support for automake-1.12
      build: remove redundant leading ./ from file lists
      build: make use of aux dir to unclutter the root a bit
      build: consolidate LDADD
      build: provide libleveldb as a shared library

 .gitignore    |   10 +--
 Makefile.am   |  214 ++++++++++++++++++++++++++-----------------------=
--------
 configure.ac  |    6 +-
 m4/.gitignore |    2 +
 4 files changed, 112 insertions(+), 120 deletions(-)
 create mode 100644 m4/.gitignore
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
