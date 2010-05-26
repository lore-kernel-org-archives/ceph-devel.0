From: "Jim Schutt" <jaschut@sandia.gov>
Subject: compile error on testing branch - missing
 anchor_create_prep_locks()
Date: Wed, 26 May 2010 10:17:37 -0600
Message-ID: <1274890657.4773.153.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:56798 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab0EZQRy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 May 2010 12:17:54 -0400
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1F3AC526395
	for <ceph-devel@vger.kernel.org>; Wed, 26 May 2010 10:17:47 -0600 (MDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

=46WIW, I'm getting this compile error on the testing branch:

if g++ -DHAVE_CONFIG_H -I. -I. -I.    -Wall -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT Server.o -MD -MP -MF ".d=
eps/Server.Tpo" -c -o Server.o `test -f 'mds/Server.cc' || echo './'`md=
s/Server.cc; \
        then mv -f ".deps/Server.Tpo" ".deps/Server.Po"; else rm -f ".d=
eps/Server.Tpo"; exit 1; fi
mds/Server.cc: In member function =E2=80=98void Server::handle_client_u=
nlink(MDRequest*)=E2=80=99:
mds/Server.cc:3705: error: =E2=80=98class MDCache=E2=80=99 has no membe=
r named =E2=80=98anchor_create_prep_locks=E2=80=99


The missing function seems to have been introduced in commit 4a449ec7.

It exists in the unstable branch, but I get conflicts if
I try to merge testing into unstable.

-- Jim



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
