From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Filesystem size inconsistance problem
Date: Sun, 6 Jan 2013 14:42:35 +0800
Message-ID: <CAJiejCQ60+n_EgFe9CCpe9tBtLT-Q188OFP2tc36sEoZ_hr_MA@mail.gmail.com>
References: <CAJiejCTmQYy7DpY-p27oseEAbbeNiFcxonL2pZGTofnwz1D79A@mail.gmail.com>
 <alpine.DEB.2.00.1301052230260.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:41826 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3AFGm4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:42:56 -0500
Received: by mail-qc0-f171.google.com with SMTP id d1so10634624qca.30
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jan 2013 22:42:55 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301052230260.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

2013/1/6 Sage Weil <sage@inktank.com>:
> On Sun, 6 Jan 2013, Drunkard Zhang wrote:
>> Some times ago, I did ceph upgrade offline, then ethernet bonding
>> while ceph online, and also I removed some OSDs, the cluster
>> experienced big movements, after sometime it calms down finally. Whe=
n
>> I verify the consistance, I found that the filesystem size by 'ceph
>> -s'(true size) and mounted size is different. What's the problem?
>>
>> It's still usable, and the used percent is right too, but the wrong
>> size displayed looks really uncomfortable !!!
>
> What OS and kernel are you running?  In order to get big numbers to c=
ome
> out of statfs, we report a huge block size, and some combinations of =
the
> system utilies, glibc, or something else result in bad output.  I don=
't
> think we've ever fully tracked it down... :(
>
All nodes are based on Gentoo, and up-to-date.

# emerge --info
Portage 2.1.11.31 (default/linux/amd64/10.0, gcc-4.6.3, glibc-2.15-r3,
3.7.1-gentoo x86_64)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
System uname: Linux-3.7.1-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5620_@_2.=
40GHz-with-gentoo-2.1
Timestamp of tree: Sat, 22 Dec 2012 21:30:01 +0000
ld GNU ld (GNU Binutils) 2.22
app-shells/bash:          4.2_p37
dev-lang/python:          2.7.3-r2, 3.1.5, 3.2.3
dev-util/pkgconfig:       0.27.1
sys-apps/baselayout:      2.1-r1
sys-apps/openrc:          0.11.8
sys-apps/sandbox:         2.5
sys-devel/autoconf:       2.69
sys-devel/automake:       1.11.6
sys-devel/binutils:       2.22-r1
sys-devel/gcc:            4.6.3
sys-devel/gcc-config:     1.7.3
sys-devel/libtool:        2.4-r1
sys-devel/make:           3.82-r4
sys-kernel/linux-headers: 3.6 (virtual/os-headers)
sys-libs/glibc:           2.15-r3
Repositories: gentoo
ACCEPT_KEYWORDS=3D"amd64"
ACCEPT_LICENSE=3D"* -@EULA"
CBUILD=3D"x86_64-pc-linux-gnu"
CFLAGS=3D"-march=3Dcorei7 -O2 -pipe"
CHOST=3D"x86_64-pc-linux-gnu"
CONFIG_PROTECT=3D"/etc"
CONFIG_PROTECT_MASK=3D"/etc/ca-certificates.conf /etc/env.d /etc/gconf
/etc/gentoo-release /etc/revdep-rebuild /etc/sandbox.d /etc/terminfo"
CXXFLAGS=3D"-march=3Dcorei7 -O2 -pipe"
DISTDIR=3D"/usr/portage/distfiles"
=46CFLAGS=3D"-O2 -pipe"
=46EATURES=3D"assume-digests binpkg-logs config-protect-if-modified
distlocks ebuild-locks fixlafiles merge-sync news parallel-fetch
protect-owned sandbox sfperms strict unknown-features-warn
unmerge-logs unmerge-orphans userfetch"
=46FLAGS=3D"-O2 -pipe"
GENTOO_MIRRORS=3D"http://gentoo.gwbnsh.net.cn/"
LANG=3D"en_US.utf8"
LDFLAGS=3D"-Wl,-O1 -Wl,--as-needed"
MAKEOPTS=3D"-j9"
PKGDIR=3D"/usr/portage/packages"
PORTAGE_CONFIGROOT=3D"/"
PORTAGE_RSYNC_OPTS=3D"--recursive --links --safe-links --perms --times
--compress --force --whole-file --delete --stats --human-readable
--timeout=3D180 --exclude=3D/distfiles --exclude=3D/local
--exclude=3D/packages"
PORTAGE_TMPDIR=3D"/var/tmp"
PORTDIR=3D"/usr/portage"
PORTDIR_OVERLAY=3D""
SYNC=3D"rsync://gentoo.gwbnsh.net.cn/gentoo-portage"
USE=3D"acl acpi aio amd64 bash-completion berkdb bzip2 cli cracklib
crypt cups cxx dri fortran gdbm gpm iconv ipv6 mmap mmx modules
mudflap multilib ncurses nls nptl openmp pam pcre pppd readline
session smp sse sse2 ssl ssse3 tcpd threads unicode vim-syntax zlib"
ALSA_CARDS=3D"ali5451 als4000 atiixp atiixp-modem bt87x ca0106 cmipci
emu10k1x ens1370 ens1371 es1938 es1968 fm801 hda-intel intel8x0
intel8x0m maestro3 trident usb-audio via82xx via82xx-modem ymfpci"
ALSA_PCM_PLUGINS=3D"adpcm alaw asym copy dmix dshare dsnoop empty
extplug file hooks iec958 ioplug ladspa lfloat linear meter mmap_emul
mulaw multi null plug rate route share shm softvol"
APACHE2_MODULES=3D"authn_core authz_core socache_shmcb unixd actions
alias auth_basic authn_alias authn_anon authn_dbm authn_default
authn_file authz_dbm authz_default authz_groupfile authz_host
authz_owner authz_user autoindex cache cgi cgid dav dav_fs dav_lock
deflate dir disk_cache env expires ext_filter file_cache filter
headers include info log_config logio mem_cache mime mime_magic
negotiation rewrite setenvif speling status unique_id userdir
usertrack vhost_alias" CALLIGRA_FEATURES=3D"kexi words flow plan sheets
stage tables krita karbon braindump" CAMERAS=3D"ptp2"
COLLECTD_PLUGINS=3D"df interface irq load memory rrdtool swap syslog"
ELIBC=3D"glibc" GPSD_PROTOCOLS=3D"ashtech aivdm earthmate evermore fv18
garmin garmintxt gpsclock itrax mtk3301 nmea ntrip navcom oceanserver
oldstyle oncore rtcm104v2 rtcm104v3 sirf superstar2 timing tsip
tripmate tnt ubx" INPUT_DEVICES=3D"keyboard mouse evdev" KERNEL=3D"linu=
x"
LCD_DEVICES=3D"bayrad cfontz cfontz633 glk hd44780 lb216 lcdm001 mtxorb
ncurses text" LIBREOFFICE_EXTENSIONS=3D"presenter-console
presenter-minimizer" PHP_TARGETS=3D"php5-3"
PYTHON_SINGLE_TARGET=3D"python2_7" PYTHON_TARGETS=3D"python2_7 python3_=
2"
RUBY_TARGETS=3D"ruby18 ruby19" USERLAND=3D"GNU" VIDEO_CARDS=3D"fbdev gl=
int
intel mach64 mga nouveau nv r128 radeon savage sis tdfx trident vesa
via vmware dummy v4l" XTABLES_ADDONS=3D"quota2 psd pknock lscan length2
ipv4options ipset ipp2p iface geoip fuzzy condition tee tarpit sysrq
steal rawnat logmark ipmark dhcpmac delude chaos account"
Unset:  CPPFLAGS, CTARGET, EMERGE_DEFAULT_OPTS, INSTALL_MASK, LC_ALL,
PORTAGE_BUNZIP2_COMMAND, PORTAGE_COMPRESS, PORTAGE_COMPRESS_FLAGS,
PORTAGE_RSYNC_EXTRA_OPTS, USE_PYTHON

>>
>> log3 ~ # mount -t ceph log3:/ /mnt/temp/
>> log3 ~ # df -t ceph
>> Filesystem      Size  Used Avail Use% Mounted on
>> 10.205.119.2:/  404G   62G  343G  16% /mnt/temp
>> log3 ~ # ceph -s
>>    health HEALTH_OK
>>    monmap e1: 3 mons at
>> {log21=3D10.205.118.21:6789/0,log3=3D10.205.119.2:6789/0,squid86-log=
12=3D150.164.100.218:6789/0},
>> election epoch 376, quorum 0,1,2 log21,log3,squid86-log12
>>    osdmap e15719: 37 osds: 37 up, 37 in
>>     pgmap v383025: 9224 pgs: 9224 active+clean; 7829 GB data, 15731 =
GB
>> used, 87614 GB / 100 TB avail
>>    mdsmap e283: 1/1/1 up {0=3Dlog3=3Dup:active}, 1 up:standby
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



--
=E5=BC=A0=E7=BB=8D=E6=96=87
gongfan193@gmail.com
zhangsw@gwbnsh.net.cn
18601633785
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
