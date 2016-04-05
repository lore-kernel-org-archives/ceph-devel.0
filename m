From: Loic Dachary <loic@dachary.org>
Subject: Re: arm64 qemu odd behavior
Date: Tue, 5 Apr 2016 12:16:37 +0200
Message-ID: <57039085.6070905@dachary.org>
References: <570188B5.3090102@dachary.org> <57018B78.10500@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:32872 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbcDEKQo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 06:16:44 -0400
In-Reply-To: <57018B78.10500@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

While installing packages on an arm64 virtual machine with 6 proc 24GB =
RAM today, it got stuck installing packages

root      9299  0.0  0.0   5996  3984 pts/1    Ss+  09:24   0:01  |    =
                   \_ /usr/bin/dpkg --status-fd 23 --configure libexpat=
1:arm64 libgcrypt11:arm64 libtasn1-6:arm64 libgnutls26:arm64 libgnutls-=
openssl27:arm64 libmagic1:arm64 file:arm64 libssl1.0.0:arm64 libpython3=
=2E4-minimal:arm64 python3.4-minimal:arm64 libpython3.4-stdlib:arm64 py=
thon3.4:arm64 libudev1:arm64 udev:arm64 bash-completion:all libasprintf=
0c2:arm64 libkrb5support0:arm64 libk5crypto3:arm64 libkrb5-3:arm64 libg=
ssapi-krb5-2:arm64 libldap-2.4-2:arm64 libcurl3-gnutls:arm64 libsystemd=
-daemon0:arm64 libapparmor1:arm64 libsystemd-login0:arm64 dbus:arm64 sy=
stemd-shim:arm64 systemd-services:arm64 libpam-systemd:arm64 libparted0=
debian1:arm64 libpipeline1:arm64 libpolkit-gobject-1-0:arm64 libusb-1.0=
-0:arm64 libxml2:arm64 bsdmainutils:arm64 man-db:arm64 ntfs-3g:arm64 li=
baio1:arm64 liblzo2-2:arm64 libnettle4:arm64 libarchive13:arm64 libasou=
nd2-data:all libasound2:arm64 libasyncns0:arm64 libatasmart4:arm64 liba=
tk1.0-
 d
ata:all libatk1.0-0:arm64 libatspi2.0-0:arm64 libatk-bridge2.0-0:arm64 =
libgtk2.0-common:all fonts-dejavu-core:all fontconfig-config:all libfre=
etype6:arm64 libfontconfig1:arm64 libpixman-1-0:arm64 libxcb-render0:ar=
m64 libxcb-shm0:arm64 libxrender1:arm64 libcairo2:arm64 libavahi-common=
-data:arm64 libavahi-common3:arm64 libavahi-client3:arm64 libcups2:arm6=
4 libjpeg-turbo8:arm64 libjpeg8:arm64 libjasper1:arm64 libjbig0:arm64 l=
ibtiff5:arm64 libgdk-pixbuf2.0-common:all libgdk-pixbuf2.0-0:arm64 libt=
hai-data:all libdatrie1:arm64 libthai0:arm64 fontconfig:arm64 libpango-=
1.0-0:arm64 libgraphite2-3:arm64 libharfbuzz0b:arm64 libpangoft2-1.0-0:=
arm64 libpangocairo-1.0-0:arm64 libxcomposite1:arm64 libxfixes3:arm64 l=
ibxcursor1:arm64 libxdamage1:arm64 libxi6:arm64 libxinerama1:arm64 libx=
randr2:arm64 libgtk2.0-0:arm64 libnspr4:arm64 libnss3-nssdb:all libnss3=
:arm64 tzdata-java:all java-common:all liblcms2-2:arm64 libpcsclite1:ar=
m64 libogg0:arm64 libflac8:arm64 libvorbis0a:arm64 libvorbisenc2:arm64 =
libs
 n
dfile1:arm64 libpulse0:arm64 libsctp1:arm64 ca-certificates-java:all op=
enjdk-7-jre-headless:arm64 default-jre-headless:arm64 libgif4:arm64 x11=
-common:all libxtst6:arm64 libglapi-mesa:arm64 libx11-xcb1:arm64 libxcb=
-dri2-0:arm64 libxcb-dri3-0:arm64 libxcb-glx0:arm64 libxcb-present0:arm=
64 libxcb-sync1:arm64 libxshmfence1:arm64 libxxf86vm1:arm64 libgl1-mesa=
-glx:arm64 libatk-wrapper-java:all libatk-wrapper-java-jni:arm64 openjd=
k-7-jre:arm64 default-jre:arm64 libavahi-glib1:arm64 libbonobo2-common:=
all libidl-common:all libidl0:arm64 liborbit-2-0:arm64 liborbit2:arm64 =
libbonobo2-0:arm64 libboost-atomic1.54.0:arm64 libboost-system1.54.0:ar=
m64 libboost-chrono1.54.0:arm64 libboost-date-time1.54.0:arm64 libboost=
-iostreams1.54.0:arm64 libboost-program-options1.54.0:arm64 libboost-ra=
ndom1.54.0:arm64 libicu52:arm64 libboost-regex1.54.0:arm64 libboost-ser=
ialization1.54.0:arm64 libboost-thread1.54.0:arm64 libcairo-gobject2:ar=
m64 libltdl7:arm64 libtdb1:arm64 libvorbisfile3:arm64
sound-theme-freedesktop:all libcanberra0:arm64 libcolord1:arm64 libcroc=
o3:arm64 libcurl3:arm64 libdconf1:arm64 libdrm-nouveau2:arm64 libdrm-ra=
deon1:arm64 libexif12:arm64 libfontenc1:arm64 gconf2-common:all libgcon=
f-2-4:arm64 libvpx1:arm64 libxpm4:arm64 libgd3:arm64 libunistring0:arm6=
4 libgettextpo0:arm64 libgl1-mesa-dri:arm64 gconf-service-backend:arm64=
 gconf-service:arm64 psmisc:arm64 dbus-x11:arm64 gconf2:arm64 libgnomev=
fs2-common:arm64 libgnomevfs2-0:arm64 libgnome2-common:all libgnome2-bi=
n:arm64 libgnome2-0:arm64 libgphoto2-port10:arm64 libgphoto2-6:arm64 li=
bgssrpc4:arm64 dconf-service:arm64 dconf-gsettings-backend:arm64 libgtk=
-3-common:all libwayland-client0:arm64 libwayland-cursor0:arm64 libxkbc=
ommon0:arm64 libgtk-3-0:arm64 libgudev-1.0-0:arm64 libice6:arm64 libiee=
e1284-3:arm64 libkadm5clnt-mit9:arm64 libkdb5-7:arm64 libkadm5srv-mit9:=
arm64 libsnappy1:arm64 libleveldb1:arm64 libpaper1:arm64 libpcrecpp0:ar=
m64 libpolkit-agent-1-0:arm64 libpolkit-backend-1-0:arm64 libpython2.7-=
mini
 m
al:arm64 python2.7-minimal:arm64 libpython2.7-stdlib:arm64 python2.7:ar=
m64 libpython2.7:arm64 libexpat1-dev:arm64 libpython2.7-dev:arm64 libpy=
thon3.4:arm64 libreadline5:arm64 acl:arm64 libsane-common:arm64 libv4lc=
on
root       659  0.0  0.0   4680  1548 pts/1    S+   09:27   0:00  |    =
                       \_ /bin/bash /var/lib/dpkg/info/ca-certificates-=
java.postinst configure
root       692  0.0  0.1 7712980 40988 pts/1   Sl+  09:27   0:01  |    =
                           \_ java -jar /usr/share/ca-certificates-java=
/ca-certificates-java.jar -storepass changeit

waited 45 minutes, no progress.

$ sudo strace -p 692
Process 692 attached
futex(0x7f849f12c0, FUTEX_WAIT, 705, NULL^CProcess 692 detached
 <detached ...>

CPU / disk / network otherwise idle.

Another clue :-)

On 03/04/2016 23:30, Loic Dachary wrote:
> While compiling with 6 proc
>=20
> $ cat /proc/cpuinfo
> Processor	: AArch64 Processor rev 1 (aarch64)
> processor	: 0
> processor	: 1
> processor	: 2
> processor	: 3
> processor	: 4
> processor	: 5
> Features	: fp asimd evtstrm
> CPU implementer	: 0x50
> CPU architecture: AArch64
> CPU variant	: 0x0
> CPU part	: 0x000
> CPU revision	: 1
>=20
> Hardware	: linux,dummy-virt
>=20
> I noticed via htop that only 5 of them are in use during make -j6. Pr=
ocessor 4 is not used. I'm not sure how / if that can be repeated.
>=20
> On 03/04/2016 23:18, Loic Dachary wrote:
>> Hi Martin,
>>
>> In your quest to understand why the arm64 qemu sometimes hangs when =
using as many processors as the host, maybe this will help.=20
>>
>> Today while watching an installation on an arm64 qemu machine, I not=
iced it was stuck in setting up fontconfig. So I logged in the machine,=
 CPU was not busy, no IOwait either, a lot of free RAM. The host was al=
so mostly idle. I straced the process and saw it moving. Unfortunately =
( or maybe I was the cause of things starting to move on again ?) the f=
ont regeneration finished while I was observing and things seem to be g=
oing at a normal speed now.=20
>>
>> Note that there is almost a 2 hours gap between Setting up fontconfi=
g and Regenerating fonts cache.
>>
>> Maybe the pattern we're sometime seeing (i.e. all blocked, not even =
possible to ssh) is another case of the same issue ?
>>
>> I'm starting to think we should bring this discussion to some arm64 =
mailing list or IRC channel but I don't know any.
>>
>> 2016-04-03 19:17:34,858.858 DEBUG:teuthology.misc:Setting up libgdk-=
pixbuf2.0-0:arm64 (2.30.7-0ubuntu1.2) ...
>> 2016-04-03 19:17:35,057.057 DEBUG:teuthology.misc:Setting up libthai=
-data (0.1.20-3) ...
>> 2016-04-03 19:17:35,183.183 DEBUG:teuthology.misc:Setting up libdatr=
ie1:arm64 (0.2.8-1) ...
>> 2016-04-03 19:17:35,350.350 DEBUG:teuthology.misc:Setting up libthai=
0:arm64 (0.1.20-3) ...
>> 2016-04-03 19:17:35,546.546 DEBUG:teuthology.misc:Setting up fontcon=
fig (2.11.0-0ubuntu4.1) ...
>> 2016-04-03 21:09:52,094.094 DEBUG:teuthology.misc:Regenerating fonts=
 cache... done.
>> 2016-04-03 21:09:52,136.136 DEBUG:teuthology.misc:Setting up libpang=
o-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>> 2016-04-03 21:09:52,303.303 DEBUG:teuthology.misc:Setting up libgrap=
hite2-3:arm64 (1.3.6-1ubuntu0.14.04.1) ...
>> 2016-04-03 21:09:52,465.465 DEBUG:teuthology.misc:Setting up libharf=
buzz0b:arm64 (0.9.27-1ubuntu1) ...
>> 2016-04-03 21:09:52,641.641 DEBUG:teuthology.misc:Setting up libpang=
oft2-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>> 2016-04-03 21:09:52,806.806 DEBUG:teuthology.misc:Setting up libpang=
ocairo-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>> 2016-04-03 21:09:52,971.971 DEBUG:teuthology.misc:Setting up libxcom=
posite1:arm64 (1:0.4.4-1) ...
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
