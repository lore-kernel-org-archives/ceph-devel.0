From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Tue, 12 Oct 2010 16:17:09 +1300
Message-ID: <AANLkTi=h6pb_mwYWw1EcK=GJGS0DWd-pz2k0UeU-wFN7@mail.gmail.com>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	<Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	<AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
	<AANLkTimrKDCCDHqYEb9CBhUoYO+OpKJe2Ohdyt65MxU=@mail.gmail.com>
	<AANLkTinieBbzew5rkmu0640XZbJ+x-wFe-+2H8otnDT3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:40553 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0JLDRR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Oct 2010 23:17:17 -0400
Received: by qwa26 with SMTP id 26so168684qwa.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Oct 2010 20:17:09 -0700 (PDT)
In-Reply-To: <AANLkTinieBbzew5rkmu0640XZbJ+x-wFe-+2H8otnDT3@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

Thanks a lot, the mount works smoothly without a problem.
So I'm with ceph version 0.23~rc (a7ed2ee05dc7453942018d7876401c28d3918=
214)
All testings are done in a single high-end machine.

=46or btrfs method, I get a freeze/hang while reading/writing to it.
It's the step that I've never gone passed :(
A few read/write copies are okay, I can drag/drop from the ubuntu
desktop, cp, and read files back. so far so good..
However, whenever I tried to do anything large e.g., copying a
directory (total 2.3GB consisting 52,000 files), running large dd
(>1GB+), dbench or any heav IOs,, things just lock up, once at this
point, I can't read the directory and I can't unmount, basically
leading me to restart the system. It is reproducible and can provide
some debugging info needed, just tell me which one :)

Some other issues.

when I start the ceph, how can I really make sure every btrfs contents
are removed?

sudo mkcephfs -c /etc/ceph/ceph.conf --allhosts --clobber_old_data --mk=
btrfs -v

after this, when I look at data/osd0, 1, 2, etc. I see 'current'
directory but filled with lots of x.x_head directory.
I'd thought the freshly-started shouldn't have those head directories.
I don't think it is normal?.
To get rid of these, I format the disk to ext3/4 and then use the
above command too create btrfs.. and the heads are gone.

When I tried to mkcephfs without btrfs, (i.e., using ext3/4 fs), I get
a superblock error.
[osd]
	sudo =3D true
	osd journal =3D /data/osd$id/journal
	osd journal size =3D 1000
	osd data =3D /data/osd$id
[osd0]
	host =3D ss1
; I've removed btrfs

mkcephfs -c /etc/ceph/ceph.conf --allhosts -v

=2E..
=3D=3D=3D osd.0 =3D=3D=3D
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd data" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd journal" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "keyring" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs path" "/data/=
osd0"
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs devs" ""
/usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs options" "noa=
time"
--- ss1# test -d /data/osd0 || mkdir -p /data/osd0
--- ss1# test -d /data/osd0/journal || mkdir -p /data/osd0
--- ss1# /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
/tmp/monmap.5472 -i 0 --mkfs --osd-data /data/osd0
 ** WARNING: Ceph is still under heavy development, and is only suitabl=
e for **
 **          testing and review.  Do not trust it with important data. =
      **
 ** ERROR: error creating empty object store in /data/osd0: Operation
not supported
failed: '/usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
/tmp/monmap.5472 -i 0 --mkfs --osd-data /data/osd0

I am unsure why it sets btrfs path to /data/osd0 when I clearly
commented out ; and no btrfs was mentioned in mkcephfs and conf,
In the data/osd0 (Ext3/4), I see current directory, fsid, and the journ=
al

Thanks

On Tue, Oct 12, 2010 at 5:40 AM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> On Sun, Oct 10, 2010 at 4:49 PM, DongJin Lee <dongjin.lee@auckland.ac=
=2Enz> wrote:
>> make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-=
generic'
>> =A0INSTALL /home/aaa/ceph/ceph-client-standalone/ceph.ko
>> =A0DEPMOD =A02.6.35-02063507-generic
>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-g=
eneric'
>> aaa@ss1:~/ceph/ceph-client-standalone$ sudo depmod
>> aaa@ss1:~/ceph/ceph-client-standalone$ sudo modprobe ceph
>> aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
>> ceph =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0228785 =A00
>> libcrc32c =A0 =A0 =A0 =A0 =A0 =A0 =A0 1300 =A02 ceph,btrfs
>> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
>> 192.168.1.2:/ /media/ceph
>> failed to parse ceph_options
>>
>> aaa@ss1:~/ceph/ceph-client-standalone$ sudo rmmod ceph
>> aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
>> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
>> 192.168.1.2:/ /media/ceph
>> failed to parse ceph_options
>>
>> Again, now nothing works :( everything I do I get 'failed to parse c=
eph_options'
>>
>
> Hi Dongjin,
>
> There was a bug where not supplying any options to mount.ceph caused
> this error message to be displayed. I can see here that you are not
> supplying any optinos (using -o) so you are probably hitting this bug=
=2E
>
> This should be fixed by commit
> 566292a5871686e612b30bee58481db489b27bfb. Try checking out the latest
> in unstable and this will be resolved.
>
> regards,
> Colin McCabe
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
