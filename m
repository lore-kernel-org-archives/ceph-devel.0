From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Wed, 13 Oct 2010 07:55:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010130745080.7988@cobra.newdream.net>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
 <Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
 <AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
 <AANLkTimrKDCCDHqYEb9CBhUoYO+OpKJe2Ohdyt65MxU=@mail.gmail.com>
 <AANLkTinieBbzew5rkmu0640XZbJ+x-wFe-+2H8otnDT3@mail.gmail.com>
 <AANLkTi=h6pb_mwYWw1EcK=GJGS0DWd-pz2k0UeU-wFN7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1249139661-1286981700=:7988"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38986 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab0JMOwU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Oct 2010 10:52:20 -0400
In-Reply-To: <AANLkTi=h6pb_mwYWw1EcK=GJGS0DWd-pz2k0UeU-wFN7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1249139661-1286981700=:7988
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 12 Oct 2010, DongJin Lee wrote:
> Thanks a lot, the mount works smoothly without a problem.
> So I'm with ceph version 0.23~rc (a7ed2ee05dc7453942018d7876401c28d391821=
4)
> All testings are done in a single high-end machine.
>=20
> For btrfs method, I get a freeze/hang while reading/writing to it.
> It's the step that I've never gone passed :(
> A few read/write copies are okay, I can drag/drop from the ubuntu
> desktop, cp, and read files back. so far so good..
> However, whenever I tried to do anything large e.g., copying a
> directory (total 2.3GB consisting 52,000 files), running large dd
> (>1GB+), dbench or any heav IOs,, things just lock up, once at this
> point, I can't read the directory and I can't unmount, basically
> leading me to restart the system. It is reproducible and can provide
> some debugging info needed, just tell me which one :)

Can you cat the /sys/kernel/debug/ceph/*/mdsc and osdc files?  That will=20
show in flight MDS and OSD requests.  Also, the output from 'ceph -s' will=
=20
summarize cluster status/health.  If you see pending OSD requests, can you=
=20
also enable logging on the osds with

=09debug ms =3D 1
=09debug osd =3D 20

in the [osd] section, restart the osd daemons, and reproduce the hang?

> Some other issues.
>=20
> when I start the ceph, how can I really make sure every btrfs contents
> are removed?

The cosd --mkfs step will clear out old data.

>=20
> sudo mkcephfs -c /etc/ceph/ceph.conf --allhosts --clobber_old_data --mkbt=
rfs -v
>=20
> after this, when I look at data/osd0, 1, 2, etc. I see 'current'
> directory but filled with lots of x.x_head directory.
> I'd thought the freshly-started shouldn't have those head directories.
> I don't think it is normal?.

This is normal.  Those are the empty placement group directories.

> To get rid of these, I format the disk to ext3/4 and then use the
> above command too create btrfs.. and the heads are gone.

The --mkbtrfs option to mkcephfs won't do the mkfs.btrfs if there is no=20
btrfs devs defined.  But you should still see the current and placement=20
group dirs after running mkcephfs, regardless of whether you're using=20
btrfs or ext3/4.

>=20
> When I tried to mkcephfs without btrfs, (i.e., using ext3/4 fs), I get
> a superblock error.
> [osd]
> =09sudo =3D true
> =09osd journal =3D /data/osd$id/journal
> =09osd journal size =3D 1000
> =09osd data =3D /data/osd$id
> [osd0]
> =09host =3D ss1
> ; I've removed btrfs
>=20
> mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
>=20
> ...
> =3D=3D=3D osd.0 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd data" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd journal" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "keyring" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs path" "/data/os=
d0"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs devs" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs options" "noati=
me"
> --- ss1# test -d /data/osd0 || mkdir -p /data/osd0
> --- ss1# test -d /data/osd0/journal || mkdir -p /data/osd0
> --- ss1# /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
> /tmp/monmap.5472 -i 0 --mkfs --osd-data /data/osd0
>  ** WARNING: Ceph is still under heavy development, and is only suitable =
for **
>  **          testing and review.  Do not trust it with important data.   =
    **
>  ** ERROR: error creating empty object store in /data/osd0: Operation
> not supported
> failed: '/usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
> /tmp/monmap.5472 -i 0 --mkfs --osd-data /data/osd0
>=20
> I am unsure why it sets btrfs path to /data/osd0 when I clearly
> commented out ; and no btrfs was mentioned in mkcephfs and conf,

The 'btrfs path' is the mount point, which defaults to the same as 'osd=20
data'.  It doesn't affect anythign in your case, though.  The real=20
question is where the EOPNOTSUPP is coming from.  Is /data/osd0 a btrfs or=
=20
ext3/4 file system at this point?  Can you enable the osd debug options=20
mentioned above, and then attach the osd log fragment from=20
/var/log/ceph/osd.0.log generated by the mkcephfs attempt?

Thanks!
sage




> In the data/osd0 (Ext3/4), I see current directory, fsid, and the journal
>=20
> Thanks
>=20
> On Tue, Oct 12, 2010 at 5:40 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wr=
ote:
> > On Sun, Oct 10, 2010 at 4:49 PM, DongJin Lee <dongjin.lee@auckland.ac.n=
z> wrote:
> >> make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-ge=
neric'
> >> =A0INSTALL /home/aaa/ceph/ceph-client-standalone/ceph.ko
> >> =A0DEPMOD =A02.6.35-02063507-generic
> >> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-gen=
eric'
> >> aaa@ss1:~/ceph/ceph-client-standalone$ sudo depmod
> >> aaa@ss1:~/ceph/ceph-client-standalone$ sudo modprobe ceph
> >> aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
> >> ceph =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0228785 =A00
> >> libcrc32c =A0 =A0 =A0 =A0 =A0 =A0 =A0 1300 =A02 ceph,btrfs
> >> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
> >> 192.168.1.2:/ /media/ceph
> >> failed to parse ceph_options
> >>
> >> aaa@ss1:~/ceph/ceph-client-standalone$ sudo rmmod ceph
> >> aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
> >> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
> >> 192.168.1.2:/ /media/ceph
> >> failed to parse ceph_options
> >>
> >> Again, now nothing works :( everything I do I get 'failed to parse cep=
h_options'
> >>
> >
> > Hi Dongjin,
> >
> > There was a bug where not supplying any options to mount.ceph caused
> > this error message to be displayed. I can see here that you are not
> > supplying any optinos (using -o) so you are probably hitting this bug.
> >
> > This should be fixed by commit
> > 566292a5871686e612b30bee58481db489b27bfb. Try checking out the latest
> > in unstable and this will be resolved.
> >
> > regards,
> > Colin McCabe
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1249139661-1286981700=:7988--
