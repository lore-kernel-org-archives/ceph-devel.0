From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: v0.27 released
Date: Sun, 24 Apr 2011 23:55:33 +1200
Message-ID: <BANLkTikwGrOX1SHLgcC4RPJ=n7OFQfajCg@mail.gmail.com>
References: <Pine.LNX.4.64.1104232136330.9549@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:20980 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab1DXMFm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Apr 2011 08:05:42 -0400
Received: by vxi39 with SMTP id 39so1270212vxi.19
        for <ceph-devel@vger.kernel.org>; Sun, 24 Apr 2011 04:55:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104232136330.9549@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

In v0.27
When I run mkcephfs -c -a, I get

temp dir is /tmp/mkcephfs.Mts3TZhEwG
preparing monmap in /tmp/mkcephfs.Mts3TZhEwG/monmap
/usr/local/bin/monmaptool --create --clobber --add 0 --print
/tmp/mkcephfs.Mts3TZhEwG/monmap
/usr/local/bin/monmaptool: invalid ip:port '--print'
rm: cannot remove `/tmp/mkcephfs.Mts3TZhEwG/*': No such file or directo=
ry

and so I cannot start ceph up. But It was working till v0.26. Thanks

On Sun, Apr 24, 2011 at 4:51 PM, Sage Weil <sage@newdream.net> wrote:
> v0.27 is done! =A0This mostly bugfixes, cleanups, and incremental
> improvements. =A0Notably:
>
> =A0* lots of cleanups in config file loading, handling, to make libra=
ry
> behavior sane, warn on config file errors, etc.
> =A0* osd: fix out of order ack bug
> =A0* mount.ceph: uses kernel keys interface (when available) to pass =
secrets
> =A0* osd, mon: use new syncfs() syscall where available
> =A0* librados: compound object operation support
> =A0* librbd: snapshot images no longer writeable
> =A0* librbd: rollback to snapshot and other misc fixes
> =A0* mds: journal replay cleanups, performance, bug fixes
> =A0* mds: many clustered mds fixes (mostly with rename and recovery)
> =A0* mds: standby-replay mode fixes
> =A0* mds: robust lookuphash for better nfs reexport support
> =A0* mon: bugfixes with mds takeover
> =A0* obsync: synchronize object buckets between s3, directory, swift,=
 rados
> =A0* osd: misc recovery fixes
> =A0* radosgw: dup bucket creation fixes
> =A0* radosgw: many small protocol fixes
>
> As part of the radosgw work we've created s3-tests.git, which include=
s a
> bunch of simple tests to verify implementations of the s3 protocol. =A0=
See
>
> =A0* git://ceph.newdream.net/git/s3-tests.git
> =A0* http://ceph.newdream.net/git/?p=3Ds3-tests.git;a=3Dsummary
>
> For v0.28 we're focusing on the OSD cluster, radosgw, and continuing =
with
> the MDS clustering fixes. =A0Sam and Josh are working on a refactor i=
n the
> OSD peering code that will make peering more understandable, verifiab=
le,
> and (we hope) less buggy.
>
> Relevant URLs:
> =A0* Direct download at: http://ceph.newdream.net/download/ceph-0.27.=
tar.gz
> =A0* For Debian and Ubuntu packages, see http://ceph.newdream.net/wik=
i/Debian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
