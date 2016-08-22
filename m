From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Mon, 22 Aug 2016 09:00:46 +0000
Message-ID: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0073.outbound.protection.outlook.com ([104.47.2.73]:13397
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751774AbcHVNdd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 09:33:33 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

HI All,

The following lines from make-debs.sh:

	vers=3D$(git describe --match "v*" | sed s/^v//)
	./autogen.sh
	./configure --with-rocksdb --with-ocf \
	    --with-nss --with-debug --enable-cephfs-java \
	    --with-lttng --with-babeltrace
	make distdir=3Dceph-$vers dist

produces the following error:

	make  dist-gzip am__post_remove_distdir=3D'@:'
	make[1]: Entering directory '/mnt/sdh/avnerb/ceph-github'
	if test -d "ceph-11.0.0-1689-g23eeb74"; then find "ceph-11.0.0-1689-g23eeb=
74" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "ceph-11.0.0-1689=
-g23eeb74" || { sleep 5 && rm -rf "ceph-11.0.0-1689-g23eeb74"; }; else :; f=
i
	test -d "ceph-11.0.0-1689-g23eeb74" || mkdir "ceph-11.0.0-1689-g23eeb74"
	 (cd src && make  top_distdir=3D../ceph-11.0.0-1689-g23eeb74 distdir=3D../=
ceph-11.0.0-1689-g23eeb74/src \
	     am__remove_distdir=3D: am__skip_length_check=3D: am__skip_mode_fix=3D=
: distdir)
	make[2]: Entering directory '/mnt/sdh/avnerb/ceph-github/src'
	./make_version -g ./.git_version
	if [ -n "$NO_VERSION" ] ; then \
		./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
	else \
		./make_version -g ./.git_version -c ./ceph_ver.h ; \
	fi
	make[2]: *** No rule to make target 'rocksdb/db/slice.cc', needed by 'dist=
dir'.  Stop.
	make[2]: Leaving directory '/mnt/sdh/avnerb/ceph-github/src'
	Makefile:976: recipe for target 'distdir' failed
	make[1]: *** [distdir] Error 1
	make[1]: Leaving directory '/mnt/sdh/avnerb/ceph-github'
	Makefile:1078: recipe for target 'dist' failed
	make: *** [dist] Error 2

any idea?

TIA,
  Avner
