From: Sage Weil <sage@newdream.net>
Subject: Re: Failed on starting osd-daemon after upgrade giant-0.87.1
 tohammer-0.94.3
Date: Fri, 11 Sep 2015 07:09:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509110700200.7527@cobra.newdream.net>
References: <tencent_42C775740D2FE9D03D12EA84@qq.com> <alpine.DEB.2.00.1509090954410.12362@cobra.newdream.net> <tencent_7EDD2DF72EF83A9470528405@qq.com> <alpine.DEB.2.00.1509110554520.7527@cobra.newdream.net>
 <CACJqLyYMw60oWcX-GQKTQ6d4Rz8f5gNsXeANOrHCcsWJnzEpkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1386784176-1441980577=:7527"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59173 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbIKOJi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 10:09:38 -0400
In-Reply-To: <CACJqLyYMw60oWcX-GQKTQ6d4Rz8f5gNsXeANOrHCcsWJnzEpkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: =?GB2312?B?zfXI8Q==?= <wangrui@tvmining.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1386784176-1441980577=:7527
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2015, Haomai Wang wrote:
> On Fri, Sep 11, 2015 at 8:56 PM, Sage Weil <sage@newdream.net> wrote:
>       On Fri, 11 Sep 2015, ?? wrote:
>       > Thank Sage Weil:
>       >
>       > 1. I delete some testing pools in the past, but is was a long
>       time ago (may be 2 months ago), in recently upgrade, do not
>       delete pools.
>       > 2.=C2=A0 ceph osd dump please see the (attachment file
>       ceph.osd.dump.log)
>       > 3. debug osd =3D 20' and 'debug filestore =3D 20=C2=A0 (attachm=
ent file
>       ceph.osd.5.log.tar.gz)
>=20
>       This one is failing on pool 54, which has been deleted.=C2=A0 In =
this
>       case you
>       can work around it by renaming current/54.* out of the way.
>=20
>       > 4. i install the ceph-test, but output error
>       > ceph-kvstore-tool /ceph/data5/current/db list
>       > Invalid argument: /ceph/data5/current/db: does not exist
>       (create_if_missing is false)
>=20
>       Sorry, I should have said current/omap, not current/db.=C2=A0 I'm
>       still curious
>       to see the key dump.=C2=A0 I'm not sure why the leveldb key for t=
hese
>       pgs is
>       missing...
>=20
>=20
> Yesterday I have a chat with wangrui and the reason is "infos"(legacy o=
id)
> is missing. I'm not sure why it's missing.

Probably

https://github.com/ceph/ceph/blob/hammer/src/osd/OSD.cc#L2908

Oh, I think I see what happened:

 - the pg removal was aborted pre-hammer.  On pre-hammer, thsi means that=
=20
load_pgs skips it here:

 https://github.com/ceph/ceph/blob/firefly/src/osd/OSD.cc#L2121

 - we upgrade to hammer.  we skip this pg (same reason), don't upgrade it=
,=20
but delete teh legacy infos object

 https://github.com/ceph/ceph/blob/hammer/src/osd/OSD.cc#L2908

 - now we see this crash...

I think the fix is, in hammer, to bail out of peek_map_epoch if the infos=
=20
object isn't present, here

 https://github.com/ceph/ceph/blob/hammer/src/osd/PG.cc#L2867

Probably we should restructure so we can return a 'fail' value=20
instead of a magic epoch_t meaning the same...

This is similar to the bug I'm fixing on master (and I think I just=20
realized what I was doing wrong there).

Thanks!
sage



> =C2=A0
>=20
>       Thanks!
>       sage
>=20
>=20
>       >
>       > ls -l /ceph/data5/current/db
>       > total 0
>       > -rw-r--r-- 1 root root 0 Sep 11 09:41 LOCK
>       > -rw-r--r-- 1 root root 0 Sep 11 09:54 LOG
>       > -rw-r--r-- 1 root root 0 Sep 11 09:54 LOG.old
>       >
>       > Thanks very much!
>       > Wang Rui
>       >
>       > ------------------ Original ------------------
>       > From:=C2=A0 "Sage Weil"<sage@newdream.net>;
>       > Date:=C2=A0 Fri, Sep 11, 2015 06:23 AM
>       > To:=C2=A0 "??"<wangrui@tvmining.com>;
>       > Cc:=C2=A0 "ceph-devel"<ceph-devel@vger.kernel.org>;
>       > Subject:=C2=A0 Re: Failed on starting osd-daemon after upgrade
>       giant-0.87.1 tohammer-0.94.3
>       >
>       > Hi!
>       >
>       > On Wed, 9 Sep 2015, ?? wrote:
>       > > Hi all:
>       > >
>       > > I got on error after upgrade my ceph cluster from
>       giant-0.87.2 to hammer-0.94.3, my local environment is:
>       > > CentOS 6.7 x86_64
>       > > Kernel 3.10.86-1.el6.elrepo.x86_64
>       > > HDD: XFS, 2TB
>       > > Install Package: ceph.com official RPMs x86_64
>       > >
>       > > step 1:
>       > > Upgrade MON server from 0.87.1 to 0.94.3, all is fine!
>       > >
>       > > step 2:
>       > > Upgrade OSD server from 0.87.1 to 0.94.3. i just upgrade two
>       servers and noticed that some osds can not started!
>       > > server-1 have 4 osds, all of them can not started;
>       > > server-2 have 3 osds, 2 of them can not started, but 1 of
>       them successfully started and work in good.
>       > >
>       > > Error log 1:
>       > > service ceph start osd.4
>       > > /var/log/ceph/ceph-osd.24.log
>       > > (attachment file: ceph.24.log)
>       > >
>       > > Error log 2:
>       > > /usr/bin/ceph-osd -c /etc/ceph/ceph.conf -i 4 -f
>       > >=C2=A0 (attachment file: cli.24.log)
>       >
>       > This looks a lot like a problem with a stray directory that
>       older versions
>       > did not clean up (#11429)... but not quite.=C2=A0 Have you dele=
ted
>       pools in the
>       > past? (Can you attach a 'ceph osd dump'?)?=C2=A0 Also, i fyou s=
tart
>       the osd
>       > with 'debug osd =3D 20' and 'debug filestore =3D 20' we can see
>       which PG is
>       > problematic.=C2=A0 If you install the 'ceph-test' package which
>       contains
>       > ceph-kvstore-tool, the output of
>       >
>       >=C2=A0 ceph-kvstore-tool /var/lib/ceph/osd/ceph-$id/current/db l=
ist
>       >
>       > would also be helpful.
>       >
>       > Thanks!
>       > sage
>       --
>       To unsubscribe from this list: send the line "unsubscribe
>       ceph-devel" in
>       the body of a message to majordomo@vger.kernel.org
>       More majordomo info at=C2=A0
>       http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
> --
>=20
> Best Regards,
>=20
> Wheat
>=20
>=20
>=20
--557981400-1386784176-1441980577=:7527--
