From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: commit ad12d5d5be41ce introduces a mkcephfs regression?
Date: Wed, 20 Oct 2010 12:28:03 -0700
Message-ID: <AANLkTi=GukFwnuYg0VcprwXi7fkPKU-o4aO1Z6ZtQw_V@mail.gmail.com>
References: <1287587307.6806.15.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48476 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab0JTT2G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 15:28:06 -0400
Received: by ywi6 with SMTP id 6so2238903ywi.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Oct 2010 12:28:05 -0700 (PDT)
In-Reply-To: <1287587307.6806.15.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

I think you're right. Commit ad12d5d5be41ce fixed a bug for users
creating a journal that resided in a regular file, but introduced an
inconvenience for users who put the journal on a raw block device. If
no size is specified, but a raw block device is given as an argument,
we should discover the size of the raw block device and set the
journal size appropriately.

cheers,
Colin


On Wed, Oct 20, 2010 at 8:08 AM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> Hi,
>
> Current testing head mkcephfs fails when trying to create
> a file system with an osd journal on a partition, rather than
> a file, when the journal size is not specified. =A0It fails like
> this:
>
> =3D=3D=3D osd.0 =3D=3D=3D
> scp: /etc/ceph/ceph.conf: Read-only file system
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"osd data" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"osd journal" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"keyring" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"btrfs path" "/r=
am/mnt/ceph/disk.00p2"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"btrfs devs" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"btrfs options" =
"noatime"
> --- ssh an1 =A0"cd /root ; ulimit -c unlimited ; test -d /ram/mnt/cep=
h/disk.00p2 || mkdir -p /ram/mnt/ceph/disk.00p2"
> Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of kno=
wn hosts.
> --- ssh an1 =A0"cd /root ; ulimit -c unlimited ; test -d /dev/disk/by=
-path/fc-0:0:00:00p1 || mkdir -p /dev/disk/by-path"
> Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of kno=
wn hosts.
> Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of kno=
wn hosts.
> monmap.17120 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 100% =A0183 =A0 =A0 0.2KB/s =A0 00:00
> --- ssh an1 =A0"cd /root ; ulimit -c unlimited ; /usr/bin/cosd -c /et=
c/ceph/ceph.conf --monmap /tmp/monmap.17120 -i 0 --mkfs --osd-data /ram=
/mnt/ceph/disk.00p2"
> Warning: Permanently added 'an1,172.17.0.21' (RSA) to the list of kno=
wn hosts.
> =A0** WARNING: Ceph is still under heavy development, and is only sui=
table for **
> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with =
important data. =A0 =A0 =A0 **
> =A0** ERROR: error creating empty object store in /ram/mnt/ceph/disk.=
00p2: Invalid argument
> failed: 'ssh an1 /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/m=
onmap.17120 -i 0 --mkfs --osd-data /ram/mnt/ceph/disk.00p2'
>
>
> The osd.0 part of my ceph.conf looks like this:
>
> ; osd daemon common options:
> [osd]
> =A0 =A0 =A0 =A0keyring =3D /ceph/osd/keyring.$name
> =A0 =A0 =A0 =A0osd client message size cap =3D 67108864
> =A0 =A0 =A0 =A0debug osd =3D 5
>
> ; osd daemon options per instance:
> [osd0]
> =A0 =A0 =A0 =A0host =3D an1
> =A0 =A0 =A0 =A0osd addr =3D 172.17.40.21
> =A0 =A0 =A0 =A0osd journal =3D /dev/disk/by-path/fc-0:0:00:00p1
> =A0 =A0 =A0 =A0btrfs devs =A0=3D /dev/disk/by-path/fc-0:0:00:00p2
> =A0 =A0 =A0 =A0osd data =3D /ram/mnt/ceph/disk.00p2
> =A0 =A0 =A0 =A0# Do not attempt btrfs mount until udev link shows up,
> =A0 =A0 =A0 =A0# and make sure mount point exists.
> =A0 =A0 =A0 =A0pre mount command =3D "until [ -L /dev/disk/by-path/fc=
-0:0:00:00p2 ]; do sleep 1; done && { [ -d /mnt/ceph/disk.00p2 ] || mkd=
ir /mnt/ceph/disk.00p2; }"
>
>
> Adding "osd journal size =3D 104857600" to my ceph.conf
> allows mkcephfs to succeed.
>
> Alternatively, reverting commit ad12d5d5be41ce allows mkcephfs to
> succeed without specifying the journal size.
>
> Was this change of behavior an intentional part of the
> bugfix, or am I doing something wrong?
>
> Would it be possible to discover when the journal is a
> partition, and if so query its size?
>
> Thanks -- Jim
>
>
>
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
