From: Loic Dachary <loic@dachary.org>
Subject: Re: arm64 qemu odd behavior
Date: Tue, 5 Apr 2016 20:57:58 +0200
Message-ID: <57040AB6.8010404@dachary.org>
References: <570188B5.3090102@dachary.org> <57018B78.10500@dachary.org>
 <57039085.6070905@dachary.org> <5703BE1B.2040805@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49132 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcDES6E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 14:58:04 -0400
In-Reply-To: <5703BE1B.2040805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is by far the best one :-)

ubuntu   21929  0.0  0.0   2080   768 pts/0    S+   12:24   0:00  |    =
           \_ /usr/bin/make -f debian/rules build
ubuntu   24005  0.0  0.0   4456  3028 pts/0    S+   12:25   0:01  |    =
               \_ /bin/bash ./configure --prefix=3D/usr --localstatedir=
=3D/var --sysconfdir=3D/etc --libexecdir=3D/usr/lib --with-ocf --with-n=
ss --with-debug --enable-cephfs-java --with-librocksdb-static=3Dcheck -=
-build aarch64-linux-gnu --without-tcmalloc --without-cryptopp
ubuntu   25004  0.0  0.0   1760   312 pts/0    S+   12:25   0:00  |    =
                   \_ sleep 1
root     28211  0.0  0.0  12844  3920 ?        Ss   18:54   0:00  \_ ss=
hd: ubuntu [priv]

ubuntu@localhost:~$ date
Tue Apr  5 18:56:41 UTC 2016

sleep 1 second is stuck for ... over 6 hours :-)

ubuntu@localhost:~$ sudo strace -p 25004
Process 25004 attached
restart_syscall(<... resuming interrupted call ...>

Definitely going to try another kernel.

On 05/04/2016 15:31, Loic Dachary wrote:
> Caught the same problem again, strace shows futex also. I tried to gd=
b the process but ... that unblocked the situation.
>=20
> 2016-04-05 12:25:36,304.304 DEBUG:teuthology.misc:find: `/usr/lib/jvm=
/java/': No such file or directory
> 2016-04-05 12:25:36,307.307 DEBUG:teuthology.misc:find: `/usr/lib/jvm=
/java-gcj/': No such file or directory
> 2016-04-05 12:25:36,313.313 DEBUG:teuthology.misc:You have no CLASSPA=
TH, I hope it is good
> 2016-04-05 12:25:36,314.314 DEBUG:teuthology.misc:checking for javac.=
=2E. javac
> 2016-04-05 13:25:56,431.431 DEBUG:teuthology.misc:checking if javac w=
orks... yes
> 2016-04-05 13:25:56,432.432 DEBUG:teuthology.misc:checking for javah.=
=2E. /usr/bin/javah
> 2016-04-05 13:25:56,484.484 DEBUG:teuthology.misc:configure: WARNING:=
 unable to include <jni.h>
>=20
> see the one hour gap after "checking for javac". It's running a=20
>=20
> Linux teuthology 3.13.0-40-generic #69-Ubuntu SMP Thu Nov 13 19:05:44=
 UTC 2014 aarch64 aarch64 aarch64 GNU/Linux
>=20
> and since we've been told runabove had trouble with 3.13 and needed a=
t least 3.19 for things to work, I wonder if we're not experiencing the=
 same kind of issues. I'm tempted to try and use runabove kernel (4.2 r=
ecompiled by cavium) on cloudlab and see if that improves things.=20
>=20
> What do you think ?
>=20
> On 05/04/2016 12:16, Loic Dachary wrote:
>> While installing packages on an arm64 virtual machine with 6 proc 24=
GB RAM today, it got stuck installing packages
>>
>> root      9299  0.0  0.0   5996  3984 pts/1    Ss+  09:24   0:01  | =
                      \_ /usr/bin/dpkg --status-fd 23 --configure libex=
pat1:arm64 libgcrypt11:arm64 libtasn1-6:arm64 libgnutls26:arm64 libgnut=
ls-openssl27:arm64 libmagic1:arm64 file:arm64 libssl1.0.0:arm64 libpyth=
on3.4-minimal:arm64 python3.4-minimal:arm64 libpython3.4-stdlib:arm64 p=
ython3.4:arm64 libudev1:arm64 udev:arm64 bash-completion:all libasprint=
f0c2:arm64 libkrb5support0:arm64 libk5crypto3:arm64 libkrb5-3:arm64 lib=
gssapi-krb5-2:arm64 libldap-2.4-2:arm64 libcurl3-gnutls:arm64 libsystem=
d-daemon0:arm64 libapparmor1:arm64 libsystemd-login0:arm64 dbus:arm64 s=
ystemd-shim:arm64 systemd-services:arm64 libpam-systemd:arm64 libparted=
0debian1:arm64 libpipeline1:arm64 libpolkit-gobject-1-0:arm64 libusb-1.=
0-0:arm64 libxml2:arm64 bsdmainutils:arm64 man-db:arm64 ntfs-3g:arm64 l=
ibaio1:arm64 liblzo2-2:arm64 libnettle4:arm64 libarchive13:arm64 libaso=
und2-data:all libasound2:arm64 libasyncns0:arm64 libatasmart4:arm64 lib=
atk1
 .
0
> -
>>  d
>> ata:all libatk1.0-0:arm64 libatspi2.0-0:arm64 libatk-bridge2.0-0:arm=
64 libgtk2.0-common:all fonts-dejavu-core:all fontconfig-config:all lib=
freetype6:arm64 libfontconfig1:arm64 libpixman-1-0:arm64 libxcb-render0=
:arm64 libxcb-shm0:arm64 libxrender1:arm64 libcairo2:arm64 libavahi-com=
mon-data:arm64 libavahi-common3:arm64 libavahi-client3:arm64 libcups2:a=
rm64 libjpeg-turbo8:arm64 libjpeg8:arm64 libjasper1:arm64 libjbig0:arm6=
4 libtiff5:arm64 libgdk-pixbuf2.0-common:all libgdk-pixbuf2.0-0:arm64 l=
ibthai-data:all libdatrie1:arm64 libthai0:arm64 fontconfig:arm64 libpan=
go-1.0-0:arm64 libgraphite2-3:arm64 libharfbuzz0b:arm64 libpangoft2-1.0=
-0:arm64 libpangocairo-1.0-0:arm64 libxcomposite1:arm64 libxfixes3:arm6=
4 libxcursor1:arm64 libxdamage1:arm64 libxi6:arm64 libxinerama1:arm64 l=
ibxrandr2:arm64 libgtk2.0-0:arm64 libnspr4:arm64 libnss3-nssdb:all libn=
ss3:arm64 tzdata-java:all java-common:all liblcms2-2:arm64 libpcsclite1=
:arm64 libogg0:arm64 libflac8:arm64 libvorbis0a:arm64 libvorbisenc2:arm=
64 l
 i
b
> s
>>  n
>> dfile1:arm64 libpulse0:arm64 libsctp1:arm64 ca-certificates-java:all=
 openjdk-7-jre-headless:arm64 default-jre-headless:arm64 libgif4:arm64 =
x11-common:all libxtst6:arm64 libglapi-mesa:arm64 libx11-xcb1:arm64 lib=
xcb-dri2-0:arm64 libxcb-dri3-0:arm64 libxcb-glx0:arm64 libxcb-present0:=
arm64 libxcb-sync1:arm64 libxshmfence1:arm64 libxxf86vm1:arm64 libgl1-m=
esa-glx:arm64 libatk-wrapper-java:all libatk-wrapper-java-jni:arm64 ope=
njdk-7-jre:arm64 default-jre:arm64 libavahi-glib1:arm64 libbonobo2-comm=
on:all libidl-common:all libidl0:arm64 liborbit-2-0:arm64 liborbit2:arm=
64 libbonobo2-0:arm64 libboost-atomic1.54.0:arm64 libboost-system1.54.0=
:arm64 libboost-chrono1.54.0:arm64 libboost-date-time1.54.0:arm64 libbo=
ost-iostreams1.54.0:arm64 libboost-program-options1.54.0:arm64 libboost=
-random1.54.0:arm64 libicu52:arm64 libboost-regex1.54.0:arm64 libboost-=
serialization1.54.0:arm64 libboost-thread1.54.0:arm64 libcairo-gobject2=
:arm64 libltdl7:arm64 libtdb1:arm64 libvorbisfile3:arm64
>> sound-theme-freedesktop:all libcanberra0:arm64 libcolord1:arm64 libc=
roco3:arm64 libcurl3:arm64 libdconf1:arm64 libdrm-nouveau2:arm64 libdrm=
-radeon1:arm64 libexif12:arm64 libfontenc1:arm64 gconf2-common:all libg=
conf-2-4:arm64 libvpx1:arm64 libxpm4:arm64 libgd3:arm64 libunistring0:a=
rm64 libgettextpo0:arm64 libgl1-mesa-dri:arm64 gconf-service-backend:ar=
m64 gconf-service:arm64 psmisc:arm64 dbus-x11:arm64 gconf2:arm64 libgno=
mevfs2-common:arm64 libgnomevfs2-0:arm64 libgnome2-common:all libgnome2=
-bin:arm64 libgnome2-0:arm64 libgphoto2-port10:arm64 libgphoto2-6:arm64=
 libgssrpc4:arm64 dconf-service:arm64 dconf-gsettings-backend:arm64 lib=
gtk-3-common:all libwayland-client0:arm64 libwayland-cursor0:arm64 libx=
kbcommon0:arm64 libgtk-3-0:arm64 libgudev-1.0-0:arm64 libice6:arm64 lib=
ieee1284-3:arm64 libkadm5clnt-mit9:arm64 libkdb5-7:arm64 libkadm5srv-mi=
t9:arm64 libsnappy1:arm64 libleveldb1:arm64 libpaper1:arm64 libpcrecpp0=
:arm64 libpolkit-agent-1-0:arm64 libpolkit-backend-1-0:arm64 libpython2=
=2E7-m
 i
n
> i
>>  m
>> al:arm64 python2.7-minimal:arm64 libpython2.7-stdlib:arm64 python2.7=
:arm64 libpython2.7:arm64 libexpat1-dev:arm64 libpython2.7-dev:arm64 li=
bpython3.4:arm64 libreadline5:arm64 acl:arm64 libsane-common:arm64 libv=
4lcon
>> root       659  0.0  0.0   4680  1548 pts/1    S+   09:27   0:00  | =
                          \_ /bin/bash /var/lib/dpkg/info/ca-certificat=
es-java.postinst configure
>> root       692  0.0  0.1 7712980 40988 pts/1   Sl+  09:27   0:01  | =
                              \_ java -jar /usr/share/ca-certificates-j=
ava/ca-certificates-java.jar -storepass changeit
>>
>> waited 45 minutes, no progress.
>>
>> $ sudo strace -p 692
>> Process 692 attached
>> futex(0x7f849f12c0, FUTEX_WAIT, 705, NULL^CProcess 692 detached
>>  <detached ...>
>>
>> CPU / disk / network otherwise idle.
>>
>> Another clue :-)
>>
>> On 03/04/2016 23:30, Loic Dachary wrote:
>>> While compiling with 6 proc
>>>
>>> $ cat /proc/cpuinfo
>>> Processor	: AArch64 Processor rev 1 (aarch64)
>>> processor	: 0
>>> processor	: 1
>>> processor	: 2
>>> processor	: 3
>>> processor	: 4
>>> processor	: 5
>>> Features	: fp asimd evtstrm
>>> CPU implementer	: 0x50
>>> CPU architecture: AArch64
>>> CPU variant	: 0x0
>>> CPU part	: 0x000
>>> CPU revision	: 1
>>>
>>> Hardware	: linux,dummy-virt
>>>
>>> I noticed via htop that only 5 of them are in use during make -j6. =
Processor 4 is not used. I'm not sure how / if that can be repeated.
>>>
>>> On 03/04/2016 23:18, Loic Dachary wrote:
>>>> Hi Martin,
>>>>
>>>> In your quest to understand why the arm64 qemu sometimes hangs whe=
n using as many processors as the host, maybe this will help.=20
>>>>
>>>> Today while watching an installation on an arm64 qemu machine, I n=
oticed it was stuck in setting up fontconfig. So I logged in the machin=
e, CPU was not busy, no IOwait either, a lot of free RAM. The host was =
also mostly idle. I straced the process and saw it moving. Unfortunatel=
y ( or maybe I was the cause of things starting to move on again ?) the=
 font regeneration finished while I was observing and things seem to be=
 going at a normal speed now.=20
>>>>
>>>> Note that there is almost a 2 hours gap between Setting up fontcon=
fig and Regenerating fonts cache.
>>>>
>>>> Maybe the pattern we're sometime seeing (i.e. all blocked, not eve=
n possible to ssh) is another case of the same issue ?
>>>>
>>>> I'm starting to think we should bring this discussion to some arm6=
4 mailing list or IRC channel but I don't know any.
>>>>
>>>> 2016-04-03 19:17:34,858.858 DEBUG:teuthology.misc:Setting up libgd=
k-pixbuf2.0-0:arm64 (2.30.7-0ubuntu1.2) ...
>>>> 2016-04-03 19:17:35,057.057 DEBUG:teuthology.misc:Setting up libth=
ai-data (0.1.20-3) ...
>>>> 2016-04-03 19:17:35,183.183 DEBUG:teuthology.misc:Setting up libda=
trie1:arm64 (0.2.8-1) ...
>>>> 2016-04-03 19:17:35,350.350 DEBUG:teuthology.misc:Setting up libth=
ai0:arm64 (0.1.20-3) ...
>>>> 2016-04-03 19:17:35,546.546 DEBUG:teuthology.misc:Setting up fontc=
onfig (2.11.0-0ubuntu4.1) ...
>>>> 2016-04-03 21:09:52,094.094 DEBUG:teuthology.misc:Regenerating fon=
ts cache... done.
>>>> 2016-04-03 21:09:52,136.136 DEBUG:teuthology.misc:Setting up libpa=
ngo-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>>>> 2016-04-03 21:09:52,303.303 DEBUG:teuthology.misc:Setting up libgr=
aphite2-3:arm64 (1.3.6-1ubuntu0.14.04.1) ...
>>>> 2016-04-03 21:09:52,465.465 DEBUG:teuthology.misc:Setting up libha=
rfbuzz0b:arm64 (0.9.27-1ubuntu1) ...
>>>> 2016-04-03 21:09:52,641.641 DEBUG:teuthology.misc:Setting up libpa=
ngoft2-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>>>> 2016-04-03 21:09:52,806.806 DEBUG:teuthology.misc:Setting up libpa=
ngocairo-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
>>>> 2016-04-03 21:09:52,971.971 DEBUG:teuthology.misc:Setting up libxc=
omposite1:arm64 (1:0.4.4-1) ...
>>>>
>>>> Cheers
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
