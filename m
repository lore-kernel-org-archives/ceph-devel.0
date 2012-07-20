From: Gregory Farnum <greg@inktank.com>
Subject: Re: Running into an error with mkcephfs
Date: Fri, 20 Jul 2012 15:04:18 -0700
Message-ID: <CAPYLRzh2S3xDK9Rh_kpuLCcMPpSrgC7T99UAtAJrCsh3Unjgmw@mail.gmail.com>
References: <5009D18D.6050506@scalableinformatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53399 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2GTWET convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 18:04:19 -0400
Received: by lbbgm6 with SMTP id gm6so5625134lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 15:04:18 -0700 (PDT)
In-Reply-To: <5009D18D.6050506@scalableinformatics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: landman@scalableinformatics.com
Cc: ceph-devel@vger.kernel.org

If I remember mkcephfs correctly, it deliberately does not create the
directories for each store (you'll notice that
http://ceph.com/docs/master/start/quick-start/#deploy-the-configuration
includes creating the directory for each daemon) =97 does /data/1/osd0
exist yet?

On Fri, Jul 20, 2012 at 2:45 PM, Joe Landman
<landman@scalableinformatics.com> wrote:
> Hi folks:
>
>   Setting up a test cluster.  Simple ceph.conf
>
> [global]
>         auth supported =3D cephx
>
> [mon]
>         mon data =3D /data/mon$id
>         debug ms =3D 1
>
> [mon.0]
>         host =3D n01
>         mon addr =3D 10.202.1.142:6789
>
> [mon.1]
>         host =3D n02
>         mon addr =3D 10.202.1.141:6789
>
> [mon.2]
>         host =3D siflash-ssd
>         mon addr =3D 10.202.1.128:6789
>
> [mds]
>         keyring =3D /data/keyring.$name
>
> [mds.a]
>         host =3D siflash-ssd-1
>
> [osd]
>         osd data =3D /data/1/osd$id
>         osd journal =3D /data/2/osd$id/journal
>         osd journal size =3D 512
>
> [osd.0]
>         host =3D dv4-1
>
>
> [osd.1]
>         host =3D dv4-2
>
>
> Following along on the directions:
> http://ceph.com/docs/master/start/quick-start/
>
> mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring
>
> [root@n01 ceph]# mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyringte=
mp dir
> is /tmp/mkcephfs.W73fq9MYo0
> preparing monmap in /tmp/mkcephfs.W73fq9MYo0/monmap
> /usr/bin/monmaptool --create --clobber --add 0 10.202.1.142:6789 --ad=
d 1
> 10.202.1.141:6789 --add 2 10.202.1.128:6789 --print
> /tmp/mkcephfs.W73fq9MYo0/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.W73fq9MYo0/monmap
> /usr/bin/monmaptool: generated fsid 3ffcf9f3-f589-4dae-a534-f53daa3bc=
12c
> epoch 0
> fsid 3ffcf9f3-f589-4dae-a534-f53daa3bc12c
> last_changed 2012-07-19 17:35:14.024091
> created 2012-07-19 17:35:14.024091
> 0: 10.202.1.128:6789/0 mon.2
> 1: 10.202.1.141:6789/0 mon.1
> 2: 10.202.1.142:6789/0 mon.0
> /usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.W73fq9MYo0/monm=
ap (3
> monitors)
> =3D=3D=3D osd.0 =3D=3D=3D
> pushing conf and monmap to dv4-1:/tmp/mkfs.ceph.26215
> 2012-07-20 17:38:12.605503 7f30d6d41760 -1  ** ERROR: error creating =
empty
> object store in /data/1/osd0: (2) No such file or directory
> failed: 'ssh root@dv4-1 /sbin/mkcephfs -d /tmp/mkfs.ceph.26215 --init=
-daemon
> osd.0'
>
> Not sure what its having trouble with doing, the code path suggests t=
hat an
> mkfs failed (we are using an xfs backing store already built and moun=
ted).
>
> OS is Centos 6.3 with a 3.2.[12]3 kernel.  Any clues on what I should=
 look
> for, or try by hand?
>
> Thanks!
>
>
> --
> Joseph Landman, Ph.D
> Founder and CEO
> Scalable Informatics Inc.
> email: landman@scalableinformatics.com
> web  : http://scalableinformatics.com
>        http://scalableinformatics.com/sicluster
> phone: +1 734 786 8423 x121
> fax  : +1 866 888 3112
> cell : +1 734 612 4615
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
