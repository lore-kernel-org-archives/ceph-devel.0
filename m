From: Sage Weil <sage@newdream.net>
Subject: Re: compile error on testing branch - missing anchor_create_prep_locks()
Date: Wed, 26 May 2010 09:45:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005260944410.24698@cobra.newdream.net>
References: <1274890657.4773.153.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1963923926-1274892315=:24698"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36712 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab0EZQlh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 May 2010 12:41:37 -0400
In-Reply-To: <1274890657.4773.153.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1963923926-1274892315=:24698
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 26 May 2010, Jim Schutt wrote:
> FWIW, I'm getting this compile error on the testing branch:
>=20
> if g++ -DHAVE_CONFIG_H -I. -I. -I.    -Wall -D_FILE_OFFSET_BITS=3D64 -D_R=
EENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT Server.o -MD -MP -MF ".deps/Se=
rver.Tpo" -c -o Server.o `test -f 'mds/Server.cc' || echo './'`mds/Server.c=
c; \
>         then mv -f ".deps/Server.Tpo" ".deps/Server.Po"; else rm -f ".dep=
s/Server.Tpo"; exit 1; fi
> mds/Server.cc: In member function =FF=FFvoid Server::handle_client_unlink=
(MDRequest*)=FF=FF:
> mds/Server.cc:3705: error: =FF=FFclass MDCache=FF=FF has no member named =
=FF=FFanchor_create_prep_locks=FF=FF
>=20
>=20
> The missing function seems to have been introduced in commit 4a449ec7.
>=20
> It exists in the unstable branch, but I get conflicts if
> I try to merge testing into unstable.

Fixed this.  The missing unstable commit was 14dd8a9a.

Thanks!
sage
--557981400-1963923926-1274892315=:24698--
