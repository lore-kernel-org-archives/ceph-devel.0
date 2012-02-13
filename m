From: Sage Weil <sage@newdream.net>
Subject: Re: Stale NFS file handle
Date: Mon, 13 Feb 2012 15:34:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202131533540.29455@cobra.newdream.net>
References: <7386587.xNpCPNsyj0@mranderson>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-407422661-1329176053=:29455"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57212 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100Ab2BMXeQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 18:34:16 -0500
In-Reply-To: <7386587.xNpCPNsyj0@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-407422661-1329176053=:29455
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Feb 2012, Sz=E9kelyi Szabolcs wrote:
> I'm using Ceph 0.41 with the FUSE client. After a while I get stale NFS f=
ile=20
> errors when trying to read a file or list a directory. Logs and scrubbing=
=20
> doesn't show any errors or suspicious entries. After remounting the files=
ystem=20
> either by restarting the cluster thus forcing the clients to reconnect or=
=20
> umount+mount, files and directories either show up again or seem lost for=
ever.
>=20
> Can you give me any hint on what to check?

Are you reexporting NFS, or are you getting ESTALE from the fuse mount=20
itself?

sage
--557981400-407422661-1329176053=:29455--
