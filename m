From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: can't build the last master git (`configure.ac' or `configure.in' is required)
Date: Fri, 09 Nov 2012 14:37:37 +0100 (CET)
Message-ID: <98db07fd-3543-43ac-9c57-8ad042466e4c@mailpro>
References: <509D03DE.80604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:37184 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab2KINiI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 08:38:08 -0500
In-Reply-To: <509D03DE.80604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks, It's works !

I check my history, seem that "git submodule init"  didn't retrieve cor=
rectly git://github.com/ceph/leveldb.git. (maybe a temp network problem=
).

Thanks again,

Regards,

Alexandre

----- Mail original -----=20

De: "Joao Eduardo Luis" <joao.luis@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, ceph-devel@vger.ker=
nel.org=20
Envoy=C3=A9: Vendredi 9 Novembre 2012 14:23:42=20
Objet: Re: can't build the last master git (`configure.ac' or `configur=
e.in' is required)=20

Hi Alexandre,=20

=46orgot to CC the list on the previous email.=20

On 11/09/2012 01:05 PM, Alexandre DERUMIER wrote:=20
> # ./autogen.sh=20
> libtoolize: putting auxiliary files in `.'.=20
> libtoolize: copying file `./ltmain.sh'=20
> libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.=20
> libtoolize: copying file `m4/libtool.m4'=20
> libtoolize: copying file `m4/ltoptions.m4'=20
> libtoolize: copying file `m4/ltsugar.m4'=20
> libtoolize: copying file `m4/ltversion.m4'=20
> libtoolize: copying file `m4/lt~obsolete.m4'=20
> libtoolize: `AC_PROG_RANLIB' is rendered obsolete by `LT_INIT'=20
> autoreconf: Entering directory `.'=20
> autoreconf: configure.ac: not using Gettext=20
> autoreconf: running: aclocal --force -I m4=20
> autoreconf: configure.ac: tracing=20
> autoreconf: running: libtoolize --copy --force=20
> libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `build-aux'=
=2E=20
> libtoolize: copying file `build-aux/ltmain.sh'=20
> libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.=20
> libtoolize: copying file `m4/libtool.m4'=20
> libtoolize: copying file `m4/ltoptions.m4'=20
> libtoolize: copying file `m4/ltsugar.m4'=20
> libtoolize: copying file `m4/ltversion.m4'=20
> libtoolize: copying file `m4/lt~obsolete.m4'=20
> autoreconf: running: /usr/bin/autoconf --force=20
> autoreconf: running: /usr/bin/autoheader --force=20
> autoreconf: running: automake --add-missing --copy --force-missing=20
> autoreconf: Leaving directory `.'=20
> autoreconf: `configure.ac' or `configure.in' is required=20
>=20

I just cloned master into a new repo, and everything went just fine.=20

My bet is now on your third command (git module update), which should=20
read 'gir submodule update' instead.=20

See below. I hope this helps.=20

-Joao=20

--- 8< ---=20

ubuntu@plana41:~$ git clone https://github.com/ceph/ceph.git master-cep=
h.02=20
Cloning into 'master-ceph.02'...=20
remote: Counting objects: 162231, done.=20
remote: Compressing objects: 100% (29963/29963), done.=20
remote: Total 162231 (delta 131844), reused 160903 (delta 130721)=20
Receiving objects: 100% (162231/162231), 32.05 MiB | 10.05 MiB/s, done.=
=20
Resolving deltas: 100% (131844/131844), done.=20

ubuntu@plana41:~$ cd master-ceph.02/=20

ubuntu@plana41:~/master-ceph.02$ git submodule init=20
Submodule 'ceph-object-corpus'=20
(git://ceph.com/git/ceph-object-corpus.git) registered for path=20
'ceph-object-corpus'=20
Submodule 'src/leveldb' (git://github.com/ceph/leveldb.git) registered=20
for path 'src/leveldb'=20
Submodule 'src/libs3' (git://github.com/ceph/libs3.git) registered for=20
path 'src/libs3'=20

ubuntu@plana41:~/master-ceph.02$ git module update=20
git: 'module' is not a git command. See 'git --help'.=20

Did you mean this?=20
submodule=20
ubuntu@plana41:~/master-ceph.02$ git submodule update=20
Cloning into 'ceph-object-corpus'...=20
remote: Counting objects: 6245, done.=20
remote: Compressing objects: 100% (3454/3454), done.=20
remote: Total 6245 (delta 770), reused 6103 (delta 655)=20
Receiving objects: 100% (6245/6245), 734.84 KiB, done.=20
Resolving deltas: 100% (770/770), done.=20
Submodule path 'ceph-object-corpus': checked out=20
'7f23ee1127101d311ec0c50adb719367a0789fad'=20
Cloning into 'src/leveldb'...=20
remote: Counting objects: 1074, done.=20
remote: Compressing objects: 100% (256/256), done.=20
remote: Total 1074 (delta 804), reused 1065 (delta 795)=20
Receiving objects: 100% (1074/1074), 443.15 KiB | 154 KiB/s, done.=20
Resolving deltas: 100% (804/804), done.=20
Submodule path 'src/leveldb': checked out=20
'c79c270174307411819ddfdd8c9b671ec4fb69c9'=20
Cloning into 'src/libs3'...=20
remote: Counting objects: 1000, done.=20
remote: Compressing objects: 100% (289/289), done.=20
remote: Total 1000 (delta 720), reused 976 (delta 696)=20
Receiving objects: 100% (1000/1000), 347.92 KiB, done.=20
Resolving deltas: 100% (720/720), done.=20
Submodule path 'src/libs3': checked out=20
'9dc3a9c683385abfe4ad92b7c6ff30719acc3c13'=20

ubuntu@plana41:~/master-ceph.02$ ./autogen.sh=20
libtoolize: putting auxiliary files in `.'.=20
libtoolize: copying file `./ltmain.sh'=20
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.=20
libtoolize: copying file `m4/libtool.m4'=20
libtoolize: copying file `m4/ltoptions.m4'=20
libtoolize: copying file `m4/ltsugar.m4'=20
libtoolize: copying file `m4/ltversion.m4'=20
libtoolize: copying file `m4/lt~obsolete.m4'=20
libtoolize: `AC_PROG_RANLIB' is rendered obsolete by `LT_INIT'=20
configure.ac:28: installing `./compile'=20
configure.ac:23: installing `./config.guess'=20
configure.ac:23: installing `./config.sub'=20
configure.ac:27: installing `./install-sh'=20
configure.ac:27: installing `./missing'=20
src/Makefile.am: installing `./depcomp'=20
src/Makefile.am:1362: installing `./py-compile'=20
autoreconf: Entering directory `.'=20
autoreconf: configure.ac: not using Gettext=20
autoreconf: running: aclocal --force -I m4=20
autoreconf: configure.ac: tracing=20
autoreconf: running: libtoolize --install --copy --force=20
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `build-aux'.=20
libtoolize: copying file `build-aux/config.guess'=20
libtoolize: copying file `build-aux/config.sub'=20
libtoolize: copying file `build-aux/install-sh'=20
libtoolize: copying file `build-aux/ltmain.sh'=20
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.=20
libtoolize: copying file `m4/libtool.m4'=20
libtoolize: copying file `m4/ltoptions.m4'=20
libtoolize: copying file `m4/ltsugar.m4'=20
libtoolize: copying file `m4/ltversion.m4'=20
libtoolize: copying file `m4/lt~obsolete.m4'=20
autoreconf: running: /usr/bin/autoconf --force=20
autoreconf: running: /usr/bin/autoheader --force=20
autoreconf: running: automake --add-missing --copy --force-missing=20
configure.ac:24: installing `build-aux/missing'=20
Makefile.am: installing `build-aux/depcomp'=20
autoreconf: Leaving directory `.'=20
autoreconf: Entering directory `.'=20
autoreconf: configure.ac: not using Gettext=20
autoreconf: running: aclocal --force -I m4=20
autoreconf: configure.ac: tracing=20
autoreconf: running: libtoolize --install --copy --force=20
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.=20
libtoolize: copying file `m4/libtool.m4'=20
libtoolize: copying file `m4/ltoptions.m4'=20
libtoolize: copying file `m4/ltsugar.m4'=20
libtoolize: copying file `m4/ltversion.m4'=20
libtoolize: copying file `m4/lt~obsolete.m4'=20
autoreconf: running: /usr/bin/autoconf --force=20
autoreconf: running: /usr/bin/autoheader --force=20
autoreconf: running: automake --add-missing --copy --force-missing=20
configure.ac:5: installing `../../ar-lib'=20
autoreconf: Leaving directory `.'=20
ubuntu@plana41:~/master-ceph.02$=20

--- 8< ---=20

>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Joao Eduardo Luis" <joao.luis@inktank.com>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Envoy=C3=A9: Vendredi 9 Novembre 2012 12:56:19=20
> Objet: Re: can't build the last master git (`configure.ac' or `config=
ure.in' is required)=20
>=20
> On 11/09/2012 10:53 AM, Alexandre DERUMIER wrote:=20
>> Hi,I need help to build last master git,=20
>> I was building fine before,=20
>>=20
>> #git clone git://ceph.newdream.net/git/ceph.git=20
>> #git submodule init=20
>> #git module update=20
>> #dpkg-buildpackage=20
>>=20
>> ...=20
>> autoreconf: running: /usr/bin/autoconf --force=20
>> autoreconf: running: /usr/bin/autoheader --force=20
>> autoreconf: running: automake --add-missing --copy --force-missing=20
>> autoreconf: Leaving directory `.'=20
>> autoreconf: `configure.ac' or `configure.in' is required=20
>> make: *** [configure-stamp] Error 1=20
>> dpkg-buildpackage: error: debian/rules build gave error exit status =
2=20
>>=20
>>=20
>> Any ideas ?=20
>=20
> Try running 'autogen.sh' first? I'm not familiar with how=20
> dpkg-buildpackage works, so I have no idea if it attempts to run the=20
> autogen script, but if not, then that should be the cause for a missi=
ng=20
> configure.* I think.=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
