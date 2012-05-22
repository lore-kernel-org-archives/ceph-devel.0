From: Greg Farnum <greg@inktank.com>
Subject: Re: mkfs on osd - failed in 0.47
Date: Tue, 22 May 2012 10:47:26 -0700
Message-ID: <C77AE8F096664C4A80AF40DBC52DD6DD@inktank.com>
References: <CAMwB3TgPPbPWY5814_LVvD853fnbW1gH1mQGsaUSwJMyGR0ovQ@mail.gmail.com>
 <4FBAAA6E.4000506@profihost.ag>
 <CAPYLRzicrk97U5j_7_n=WM-PJ6u0TZbzbTzcvOZRr+dZ3YLVOA@mail.gmail.com>
 <CAMwB3Tg=wTMGZd_Og9A2-bMzfD4tSAPW4eOZWFo4_5DQ0RyR5w@mail.gmail.com>
 <4FBAACFA.3030909@profihost.ag>
 <Pine.LNX.4.64.1205211424070.5496@cobra.newdream.net>
 <CAMwB3TijgvDWjLzcqguDedE-V0EFHCF_5TQf0kgFcaFhfG=vsw@mail.gmail.com>
 <CAMwB3TiQ2pD0KwG5fwbfeSXOx5hz6Wb6gHen2CfoORfhpcue0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34888 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2EVRrc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 13:47:32 -0400
Received: by pbbrp8 with SMTP id rp8so8691474pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 10:47:32 -0700 (PDT)
In-Reply-To: <CAMwB3TiQ2pD0KwG5fwbfeSXOx5hz6Wb6gHen2CfoORfhpcue0Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sam Just <sam.just@inktank.com>

On Tuesday, May 22, 2012 at 1:21 AM, S=C5=82awomir Skowron wrote:
> One more thing:
> =20
> =3D=3D=3D osd.0 =3D=3D=3D
> 2012-05-22 10:14:09.801059 7ffc4414a780 -1 filestore(/vol0/data/osd.0=
)
> leveldb db created
> 2012-05-22 10:14:09.804227 7ffc4414a780 -1 filestore(/vol0/data/osd.0=
)
> limited size xattrs -- enable filestore_xattr_use_omap
> 2012-05-22 10:14:09.804250 7ffc4414a780 -1 OSD::mkfs: couldn't mount
> FileStore: error -95
> 2012-05-22 10:14:09.804364 7ffc4414a780 -1 ** ERROR: error creating
> empty object store in /vol0/data/osd.0: (95) Operation not supported
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.T8O2L4YPFH --init-daemon osd=
=2E0'

That's because you're using something that only does small xattrs (ext4=
, probably?) and the system wants you to turn on "filestore_xattr_use_o=
map" in the config file (for OSDs). :)
I'm not sure why it's off by default =E2=80=94 Sam?
-Greg
 =20
> =20
> /dev/sdb on /vol0/data/osd.0 type ext4
> (rw,noexec,nodev,noatime,nodiratime,user_xattr,data=3Dwriteback,barri=
er=3D0)
> =20
> ls -la osd.0
> total 524332
> drwxr-xr-x 4 root root 4096 May 22 10:16 .
> drwxr-xr-x 29 root root 4096 May 22 10:15 ..
> drwxr-xr-x 3 root root 4096 May 22 10:16 current
> -rw-r--r-- 1 root root 37 May 22 10:16 fsid
> -rw-r--r-- 1 root root 536870912 May 22 10:16 journal
> drwx------ 2 root root 16384 May 22 10:15 lost+found
> -rw-r--r-- 1 root root 4 May 22 10:16 store_version
> -rwx------ 1 root root 0 May 22 10:16 xattr_test
> =20
> =20
> On Mon, May 21, 2012 at 11:25 PM, S=C5=82awomir Skowron <szibis@gmail=
=2Ecom (mailto:szibis@gmail.com)> wrote:
> > Great Thanks.
> > =20
> > On Mon, May 21, 2012 at 11:24 PM, Sage Weil <sage@inktank.com (mail=
to:sage@inktank.com)> wrote:
> > > On Mon, 21 May 2012, Stefan Priebe wrote:
> > > > Am 21.05.2012 22:58, schrieb Sawomir Skowron:
> > > > > Yes on root. 30 minutes ago on 0.46 same operation works.
> > > > =20
> > > > =20
> > > > ...
> > > > > Repo:
> > > > > =20
> > > > > deb http://ceph.com/debian/ precise main
> > > > =20
> > > > Same to me except i'm using debian squeeze.
> > > =20
> > > I just pushed a fix for this to the stable branch. Will build a v=
0.47.1
> > > shortly.
> > > =20
> > > sage
> > =20
> > =20
> > =20
> > --
> > -----
> > Pozdrawiam
> > =20
> > S=C5=82awek "sZiBis" Skowron
> =20
> -- =20
> -----
> Pozdrawiam
> =20
> S=C5=82awek Skowron =20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
