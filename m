From: Loic Dachary <loic@dachary.org>
Subject: Re: arm64 qemu odd behavior
Date: Thu, 7 Apr 2016 10:30:08 +0200
Message-ID: <57061A90.7040102@dachary.org>
References: <570188B5.3090102@dachary.org> <57018B78.10500@dachary.org>
 <57039085.6070905@dachary.org> <5703BE1B.2040805@dachary.org>
 <57040AB6.8010404@dachary.org> <5705058A.1090502@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:38058 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbcDGIkG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 04:40:06 -0400
In-Reply-To: <5705058A.1090502@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I'm happy to report that the 4.2 kernel from runabove appears to fix th=
e problem. It did not hang once and I was able to complete a smoke test=
 (one job only but still ;-)

We will now have to figure out how to get that result without copying f=
iles from random places, not knowing what's different. A whole new adve=
nture !

On 06/04/2016 14:48, Loic Dachary wrote:
> Tried the following, it will take a few hours before it completes
>=20
> a) get the kernel/initrd from https://www.runabove.com/armcloud.xml=20
>=20
> openstack image save --file initrd.img-4.2.0-55598-g45f70e3 initrd.im=
g-4.2.0-55598-g45f70e3
> openstack image save --file vmlinuz-4.2.0-55598-g45f70e3 vmlinuz-4.2.=
0-55598-g45f70e3
>=20
> b) upload them to cloudlab
>=20
> (virtualenv)loic@fold:~/software/cloudlab/t$ openstack image create -=
-disk-format=3Dari --container-format=3Dari  --private --file initrd.im=
g-4.2.0-55598-g45f70e3 initrd.img-4.2.0-55598-g45f70e3=20
> +------------------+-------------------------------------------------=
-----+
> | Field            | Value                                           =
     |
> +------------------+-------------------------------------------------=
-----+
> | checksum         | b15a58d65a454f181ffc7dc186f89c37                =
     |
> | container_format | ari                                             =
     |
> | created_at       | 2016-04-06T12:27:26Z                            =
     |
> | disk_format      | ari                                             =
     |
> | file             | /v2/images/06a8f36e-1c66-4753-99af-4585443e8885/=
file |
> | id               | 06a8f36e-1c66-4753-99af-4585443e8885            =
     |
> | min_disk         | 0                                               =
     |
> | min_ram          | 0                                               =
     |
> | name             | initrd.img-4.2.0-55598-g45f70e3                 =
     |
> | owner            | a273f671b3524d09915a612482627d02                =
     |
> | protected        | False                                           =
     |
> | schema           | /v2/schemas/image                               =
     |
> | size             | 16693684                                        =
     |
> | status           | active                                          =
     |
> | tags             |                                                 =
     |
> | updated_at       | 2016-04-06T12:27:56Z                            =
     |
> | virtual_size     | None                                            =
     |
> | visibility       | private                                         =
     |
> +------------------+-------------------------------------------------=
-----+
> (virtualenv)loic@fold:~/software/cloudlab/t$ openstack image create -=
-disk-format=3Daki --container-format=3Daki  --private --file vmlinuz-4=
=2E2.0-55598-g45f70e3 vmlinuz-4.2.0-55598-g45f70e3=20
> +------------------+-------------------------------------------------=
-----+
> | Field            | Value                                           =
     |
> +------------------+-------------------------------------------------=
-----+
> | checksum         | 5df618babf79b611fcec7ed6842b0013                =
     |
> | container_format | aki                                             =
     |
> | created_at       | 2016-04-06T12:28:10Z                            =
     |
> | disk_format      | aki                                             =
     |
> | file             | /v2/images/26ec893a-8c30-49dd-a2fc-423c11270a2c/=
file |
> | id               | 26ec893a-8c30-49dd-a2fc-423c11270a2c            =
     |
> | min_disk         | 0                                               =
     |
> | min_ram          | 0                                               =
     |
> | name             | vmlinuz-4.2.0-55598-g45f70e3                    =
     |
> | owner            | a273f671b3524d09915a612482627d02                =
     |
> | protected        | False                                           =
     |
> | schema           | /v2/schemas/image                               =
     |
> | size             | 6354210                                         =
     |
> | status           | active                                          =
     |
> | tags             |                                                 =
     |
> | updated_at       | 2016-04-06T12:28:21Z                            =
     |
> | virtual_size     | None                                            =
     |
> | visibility       | private                                         =
     |
> +------------------+-------------------------------------------------=
-----+
>=20
> Replace the 3.13 kernel/initrd of the default image with the new 4.2 =
kernel/initrd
>=20
> openstack image set --property kernel_id=3D26ec893a-8c30-49dd-a2fc-42=
3c11270a2c --property ramdisk_id=3D06a8f36e-1c66-4753-99af-4585443e8885=
 teuthology-ubuntu-14.04-aarch64
>=20
> Tried it with
>=20
> openstack server create  --image 'teuthology-ubuntu-14.04-aarch64'  -=
-flavor 'm1.small'  --nic net-id=3Dflat-lan-1-net --key-name teuthology=
-myself --wait try
>=20
> and it seems to work
>=20
> $ ssh -i /home/loic/.ceph-workbench/teuthology-myself.pem ubuntu@128.=
110.155.162=20
> Warning: Permanently added '128.110.155.162' (ECDSA) to the list of k=
nown hosts.
> Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 4.2.0-55598-g45f70e3 aarch64=
)
>=20
>  * Documentation:  https://help.ubuntu.com/
>=20
> The programs included with the Ubuntu system are free software;
> the exact distribution terms for each program are described in the
> individual files in /usr/share/doc/*/copyright.
>=20
> Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
> applicable law.
>=20
> ubuntu@try:~$ uname -a
> Linux try 4.2.0-55598-g45f70e3 #5 SMP Tue Feb 2 10:14:08 CET 2016 aar=
ch64 aarch64 aarch64 GNU/Linux
>=20
> Then started a suite with
>=20
> teuthology-openstack --verbose --teuthology-git-url http://github.com=
/dachary/teuthology --teuthology-branch openstack --ceph-qa-suite-git-u=
rl http://github.com/dachary/ceph-qa-suite --suite-branch wip-archs --k=
ey-filename ~/.ceph-workbench/teuthology-myself.pem --key-name teutholo=
gy-myself --ceph-git-url http://github.com/dachary/ceph --ceph wip-arm6=
4-jewel  --suite buildpackages/any --filter ubuntu_14.04_aarch64
>=20
> and waiting for results. I also noted that setup-basic-aarch64.sh fro=
m the profile extensively tweaks the root file system. It does not seem=
 to do so in ways that could explain the hang observed though, so ignor=
e that for now.
>=20
> Cheers
>=20
>=20
> On 05/04/2016 20:57, Loic Dachary wrote:
>> This is by far the best one :-)
>>
>> ubuntu   21929  0.0  0.0   2080   768 pts/0    S+   12:24   0:00  | =
              \_ /usr/bin/make -f debian/rules build
>> ubuntu   24005  0.0  0.0   4456  3028 pts/0    S+   12:25   0:01  | =
                  \_ /bin/bash ./configure --prefix=3D/usr --localstate=
dir=3D/var --sysconfdir=3D/etc --libexecdir=3D/usr/lib --with-ocf --wit=
h-nss --with-debug --enable-cephfs-java --with-librocksdb-static=3Dchec=
k --build aarch64-linux-gnu --without-tcmalloc --without-cryptopp
>> ubuntu   25004  0.0  0.0   1760   312 pts/0    S+   12:25   0:00  | =
                      \_ sleep 1
>> root     28211  0.0  0.0  12844  3920 ?        Ss   18:54   0:00  \_=
 sshd: ubuntu [priv]
>>
>> ubuntu@localhost:~$ date
>> Tue Apr  5 18:56:41 UTC 2016
>>
>> sleep 1 second is stuck for ... over 6 hours :-)
>>
>> ubuntu@localhost:~$ sudo strace -p 25004
>> Process 25004 attached
>> restart_syscall(<... resuming interrupted call ...>
>>
>> Definitely going to try another kernel.
>>
>> On 05/04/2016 15:31, Loic Dachary wrote:
>>> Caught the same problem again, strace shows futex also. I tried to =
gdb the process but ... that unblocked the situation.
>>>
>>> 2016-04-05 12:25:36,304.304 DEBUG:teuthology.misc:find: `/usr/lib/j=
vm/java/': No such file or directory
>>> 2016-04-05 12:25:36,307.307 DEBUG:teuthology.misc:find: `/usr/lib/j=
vm/java-gcj/': No such file or directory
>>> 2016-04-05 12:25:36,313.313 DEBUG:teuthology.misc:You have no CLASS=
PATH, I hope it is good
>>> 2016-04-05 12:25:36,314.314 DEBUG:teuthology.misc:checking for java=
c... javac
>>> 2016-04-05 13:25:56,431.431 DEBUG:teuthology.misc:checking if javac=
 works... yes
>>> 2016-04-05 13:25:56,432.432 DEBUG:teuthology.misc:checking for java=
h... /usr/bin/javah
>>> 2016-04-05 13:25:56,484.484 DEBUG:teuthology.misc:configure: WARNIN=
G: unable to include <jni.h>
>>>
>>> see the one hour gap after "checking for javac". It's running a=20
>>>
>>> Linux teuthology 3.13.0-40-generic #69-Ubuntu SMP Thu Nov 13 19:05:=
44 UTC 2014 aarch64 aarch64 aarch64 GNU/Linux
>>>
>>> and since we've been told runabove had trouble with 3.13 and needed=
 at least 3.19 for things to work, I wonder if we're not experiencing t=
he same kind of issues. I'm tempted to try and use runabove kernel (4.2=
 recompiled by cavium) on cloudlab and see if that improves things.=20
>>>
>>> What do you think ?
>>>
>>> On 05/04/2016 12:16, Loic Dachary wrote:
>>>> While installing packages on an arm64 virtual machine with 6 proc =
24GB RAM today, it got stuck installing packages
>>>>
>>>> root      9299  0.0  0.0   5996  3984 pts/1    Ss+  09:24   0:01  =
|                       \_ /usr/bin/dpkg --status-fd 23 --configure lib=
expat1:arm64 libgcrypt11:arm64 libtasn1-6:arm64 libgnutls26:arm64 libgn=
utls-openssl27:arm64 libmagic1:arm64 file:arm64 libssl1.0.0:arm64 libpy=
thon3.4-minimal:arm64 python3.4-minimal:arm64 libpython3.4-stdlib:arm64=
 python3.4:arm64 libudev1:arm64 udev:arm64 bash-completion:all libaspri=
ntf0c2:arm64 libkrb5support0:arm64 libk5crypto3:arm64 libkrb5-3:arm64 l=
ibgssapi-krb5-2:arm64 libldap-2.4-2:arm64 libcurl3-gnutls:arm64 libsyst=
emd-daemon0:arm64 libapparmor1:arm64 libsystemd-login0:arm64 dbus:arm64=
 systemd-shim:arm64 systemd-services:arm64 libpam-systemd:arm64 libpart=
ed0debian1:arm64 libpipeline1:arm64 libpolkit-gobject-1-0:arm64 libusb-=
1.0-0:arm64 libxml2:arm64 bsdmainutils:arm64 man-db:arm64 ntfs-3g:arm64=
 libaio1:arm64 liblzo2-2:arm64 libnettle4:arm64 libarchive13:arm64 liba=
sound2-data:all libasound2:arm64 libasyncns0:arm64 libatasmart4:arm
 64 libat
 k

>  1
>=20
>>  .
>> 0
>>> -
>>>>  d
>>>> ata:all libatk1.0-0:arm64 libatspi2.0-0:arm64 libatk-bridge2.0-0:a=
rm64 libgtk2.0-common:all fonts-dejavu-core:all fontconfig-config:all l=
ibfreetype6:arm64 libfontconfig1:arm64 libpixman-1-0:arm64 libxcb-rende=
r0:arm64 libxcb-shm0:arm64 libxrender1:arm64 libcairo2:arm64 libavahi-c=
ommon-data:arm64 libavahi-common3:arm64 libavahi-client3:arm64 libcups2=
:arm64 libjpeg-turbo8:arm64 libjpeg8:arm64 libjasper1:arm64 libjbig0:ar=
m64 libtiff5:arm64 libgdk-pixbuf2.0-common:all libgdk-pixbuf2.0-0:arm64=
 libthai-data:all libdatrie1:arm64 libthai0:arm64 fontconfig:arm64 libp=
ango-1.0-0:arm64 libgraphite2-3:arm64 libharfbuzz0b:arm64 libpangoft2-1=
=2E0-0:arm64 libpangocairo-1.0-0:arm64 libxcomposite1:arm64 libxfixes3:=
arm64 libxcursor1:arm64 libxdamage1:arm64 libxi6:arm64 libxinerama1:arm=
64 libxrandr2:arm64 libgtk2.0-0:arm64 libnspr4:arm64 libnss3-nssdb:all =
libnss3:arm64 tzdata-java:all java-common:all liblcms2-2:arm64 libpcscl=
ite1:arm64 libogg0:arm64 libflac8:arm64 libvorbis0a:arm64 libvorbisen
 c2:arm64
 =20

>  l
>=20
>>  i
>> b
>>> s
>>>>  n
>>>> dfile1:arm64 libpulse0:arm64 libsctp1:arm64 ca-certificates-java:a=
ll openjdk-7-jre-headless:arm64 default-jre-headless:arm64 libgif4:arm6=
4 x11-common:all libxtst6:arm64 libglapi-mesa:arm64 libx11-xcb1:arm64 l=
ibxcb-dri2-0:arm64 libxcb-dri3-0:arm64 libxcb-glx0:arm64 libxcb-present=
0:arm64 libxcb-sync1:arm64 libxshmfence1:arm64 libxxf86vm1:arm64 libgl1=
-mesa-glx:arm64 libatk-wrapper-java:all libatk-wrapper-java-jni:arm64 o=
penjdk-7-jre:arm64 default-jre:arm64 libavahi-glib1:arm64 libbonobo2-co=
mmon:all libidl-common:all libidl0:arm64 liborbit-2-0:arm64 liborbit2:a=
rm64 libbonobo2-0:arm64 libboost-atomic1.54.0:arm64 libboost-system1.54=
=2E0:arm64 libboost-chrono1.54.0:arm64 libboost-date-time1.54.0:arm64 l=
ibboost-iostreams1.54.0:arm64 libboost-program-options1.54.0:arm64 libb=
oost-random1.54.0:arm64 libicu52:arm64 libboost-regex1.54.0:arm64 libbo=
ost-serialization1.54.0:arm64 libboost-thread1.54.0:arm64 libcairo-gobj=
ect2:arm64 libltdl7:arm64 libtdb1:arm64 libvorbisfile3:arm64
>>>> sound-theme-freedesktop:all libcanberra0:arm64 libcolord1:arm64 li=
bcroco3:arm64 libcurl3:arm64 libdconf1:arm64 libdrm-nouveau2:arm64 libd=
rm-radeon1:arm64 libexif12:arm64 libfontenc1:arm64 gconf2-common:all li=
bgconf-2-4:arm64 libvpx1:arm64 libxpm4:arm64 libgd3:arm64 libunistring0=
:arm64 libgettextpo0:arm64 libgl1-mesa-dri:arm64 gconf-service-backend:=
arm64 gconf-service:arm64 psmisc:arm64 dbus-x11:arm64 gconf2:arm64 libg=
nomevfs2-common:arm64 libgnomevfs2-0:arm64 libgnome2-common:all libgnom=
e2-bin:arm64 libgnome2-0:arm64 libgphoto2-port10:arm64 libgphoto2-6:arm=
64 libgssrpc4:arm64 dconf-service:arm64 dconf-gsettings-backend:arm64 l=
ibgtk-3-common:all libwayland-client0:arm64 libwayland-cursor0:arm64 li=
bxkbcommon0:arm64 libgtk-3-0:arm64 libgudev-1.0-0:arm64 libice6:arm64 l=
ibieee1284-3:arm64 libkadm5clnt-mit9:arm64 libkdb5-7:arm64 libkadm5srv-=
mit9:arm64 libsnappy1:arm64 libleveldb1:arm64 libpaper1:arm64 libpcrecp=
p0:arm64 libpolkit-agent-1-0:arm64 libpolkit-backend-1-0:arm64 libp
 ython2.7
 -

>  m
>=20
>>  i
>> n
>>> i
>>>>  m
>>>> al:arm64 python2.7-minimal:arm64 libpython2.7-stdlib:arm64 python2=
=2E7:arm64 libpython2.7:arm64 libexpat1-dev:arm64 libpython2.7-dev:arm6=
4 libpython3.4:arm64 libreadline5:arm64 acl:arm64 libsane-common:arm64 =
libv4lcon
>>>> root       659  0.0  0.0   4680  1548 pts/1    S+   09:27   0:00  =
|                           \_ /bin/bash /var/lib/dpkg/info/ca-certific=
ates-java.postinst configure
>>>> root       692  0.0  0.1 7712980 40988 pts/1   Sl+  09:27   0:01  =
|                               \_ java -jar /usr/share/ca-certificates=
-java/ca-certificates-java.jar -storepass changeit
>>>>
>>>> waited 45 minutes, no progress.
>>>>
>>>> $ sudo strace -p 692
>>>> Process 692 attached
>>>> futex(0x7f849f12c0, FUTEX_WAIT, 705, NULL^CProcess 692 detached
>>>>  <detached ...>
>>>>
>>>> CPU / disk / network otherwise idle.
>>>>
>>>> Another clue :-)
>>>>
>>>> On 03/04/2016 23:30, Loic Dachary wrote:
>>>>> While compiling with 6 proc
>>>>>
>>>>> $ cat /proc/cpuinfo
>>>>> Processor	: AArch64 Processor rev 1 (aarch64)
>>>>> processor	: 0
>>>>> processor	: 1
>>>>> processor	: 2
>>>>> processor	: 3
>>>>> processor	: 4
>>>>> processor	: 5
>>>>> Features	: fp asimd evtstrm
>>>>> CPU implementer	: 0x50
>>>>> CPU architecture: AArch64
>>>>> CPU variant	: 0x0
>>>>> CPU part	: 0x000
>>>>> CPU revision	: 1
>>>>>
>>>>> Hardware	: linux,dummy-virt
>>>>>
>>>>> I noticed via htop that only 5 of them are in use during make -j6=
=2E Processor 4 is not used. I'm not sure how / if that can be repeated=
=2E
>>>>>
>>>>> On 03/04/2016 23:18, Loic Dachary wrote:
>>>>>> Hi Martin,
>>>>>>
>>>>>> In your quest to understand why the arm64 qemu sometimes hangs w=
hen using as many processors as the host, maybe this will help.=20
>>>>>>
>>>>>> Today while watching an installation on an arm64 qemu machine, I=
 noticed it was stuck in setting up fontconfig. So I logged in the mach=
ine, CPU was not busy, no IOwait either, a lot of free RAM. The host wa=
s also mostly idle. I straced the process and saw it moving. Unfortunat=
ely ( or maybe I was the cause of things starting to move on again ?) t=
he font regeneration finished while I was observing and things seem to =
be going at a normal speed now.=20
>>>>>>
>>>>>> Note that there is almost a 2 hours gap between Setting up fontc=
onfig and Regenerating fonts cache.
>>>>>>
>>>>>> Maybe the pattern we're sometime seeing (i.e. all blocked, not e=
ven possible to ssh) is another case of the same issue ?
>>>>>>
>>>>>> I'm starting to think we should bring this discussion to some ar=
m64 mailing list or IRC channel but I don't know any.
>>>>>>
>>>>>> 2016-04-03 19:17:34,858.858 DEBUG:teuthology.misc:Setting up lib=
gdk-pixbuf2.0-0:arm64 (2.30.7-0ubuntu1.2) ...
>>>>>> 2016-04-03 19:17:35,057.057 DEBUG:teuthology.misc:Setting up lib=
thai-data (0.1.20-3) ...
>>>>>> 2016-04-03 19:17:35,183.183 DEBUG:teuthology.misc:Setting up lib=
datrie1:arm64 (0.2.8-1) ...
>>>>>> 2016-04-03 19:17:35,350.350 DEBUG:teuthology.misc:Setting up lib=
thai0:arm64 (0.1.20-3) ...
>>>>>> 2016-04-03 19:17:35,546.546 DEBUG:teuthology.misc:Setting up fon=
tconfig (2.11.0-0ubuntu4.1) ...
>>>>>> 2016-04-03 21:09:52,094.094 DEBUG:teuthology.misc:Regenerating f=
onts cache... done.
>>>>>> 2016-04-03 21:09:52,136.136 DEBUG:teuthology.misc:Setting up lib=
pango-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>>>>>> 2016-04-03 21:09:52,303.303 DEBUG:teuthology.misc:Setting up lib=
graphite2-3:arm64 (1.3.6-1ubuntu0.14.04.1) ...
>>>>>> 2016-04-03 21:09:52,465.465 DEBUG:teuthology.misc:Setting up lib=
harfbuzz0b:arm64 (0.9.27-1ubuntu1) ...
>>>>>> 2016-04-03 21:09:52,641.641 DEBUG:teuthology.misc:Setting up lib=
pangoft2-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>>>>>> 2016-04-03 21:09:52,806.806 DEBUG:teuthology.misc:Setting up lib=
pangocairo-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>>>>>> 2016-04-03 21:09:52,971.971 DEBUG:teuthology.misc:Setting up lib=
xcomposite1:arm64 (1:0.4.4-1) ...
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>
>>>>
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
