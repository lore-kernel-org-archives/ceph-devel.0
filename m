From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: can't build the last master git (`configure.ac' or `configure.in'
 is required)
Date: Fri, 09 Nov 2012 13:23:42 +0000
Message-ID: <509D03DE.80604@inktank.com>
References: <9aa72a1f-39e3-4115-b3e8-16f0cc955cea@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56361 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2KINXq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 08:23:46 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so1640167bkc.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 05:23:44 -0800 (PST)
In-Reply-To: <9aa72a1f-39e3-4115-b3e8-16f0cc955cea@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Alexandre,

=46orgot to CC the list on the previous email.

On 11/09/2012 01:05 PM, Alexandre DERUMIER wrote:
> # ./autogen.sh=20
> libtoolize: putting auxiliary files in `.'.
> libtoolize: copying file `./ltmain.sh'
> libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
> libtoolize: copying file `m4/libtool.m4'
> libtoolize: copying file `m4/ltoptions.m4'
> libtoolize: copying file `m4/ltsugar.m4'
> libtoolize: copying file `m4/ltversion.m4'
> libtoolize: copying file `m4/lt~obsolete.m4'
> libtoolize: `AC_PROG_RANLIB' is rendered obsolete by `LT_INIT'
> autoreconf: Entering directory `.'
> autoreconf: configure.ac: not using Gettext
> autoreconf: running: aclocal --force -I m4
> autoreconf: configure.ac: tracing
> autoreconf: running: libtoolize --copy --force
> libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `build-aux'=
=2E
> libtoolize: copying file `build-aux/ltmain.sh'
> libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
> libtoolize: copying file `m4/libtool.m4'
> libtoolize: copying file `m4/ltoptions.m4'
> libtoolize: copying file `m4/ltsugar.m4'
> libtoolize: copying file `m4/ltversion.m4'
> libtoolize: copying file `m4/lt~obsolete.m4'
> autoreconf: running: /usr/bin/autoconf --force
> autoreconf: running: /usr/bin/autoheader --force
> autoreconf: running: automake --add-missing --copy --force-missing
> autoreconf: Leaving directory `.'
> autoreconf: `configure.ac' or `configure.in' is required
>=20

I just cloned master into a new repo, and everything went just fine.

My bet is now on your third command (git module update), which should
read 'gir submodule update' instead.

See below. I hope this helps.

  -Joao

--- 8< ---

ubuntu@plana41:~$ git clone https://github.com/ceph/ceph.git master-cep=
h.02
Cloning into 'master-ceph.02'...
remote: Counting objects: 162231, done.
remote: Compressing objects: 100% (29963/29963), done.
remote: Total 162231 (delta 131844), reused 160903 (delta 130721)
Receiving objects: 100% (162231/162231), 32.05 MiB | 10.05 MiB/s, done.
Resolving deltas: 100% (131844/131844), done.

ubuntu@plana41:~$ cd master-ceph.02/

ubuntu@plana41:~/master-ceph.02$ git submodule init
Submodule 'ceph-object-corpus'
(git://ceph.com/git/ceph-object-corpus.git) registered for path
'ceph-object-corpus'
Submodule 'src/leveldb' (git://github.com/ceph/leveldb.git) registered
for path 'src/leveldb'
Submodule 'src/libs3' (git://github.com/ceph/libs3.git) registered for
path 'src/libs3'

ubuntu@plana41:~/master-ceph.02$ git module update
git: 'module' is not a git command. See 'git --help'.

Did you mean this?
	submodule
ubuntu@plana41:~/master-ceph.02$ git submodule update
Cloning into 'ceph-object-corpus'...
remote: Counting objects: 6245, done.
remote: Compressing objects: 100% (3454/3454), done.
remote: Total 6245 (delta 770), reused 6103 (delta 655)
Receiving objects: 100% (6245/6245), 734.84 KiB, done.
Resolving deltas: 100% (770/770), done.
Submodule path 'ceph-object-corpus': checked out
'7f23ee1127101d311ec0c50adb719367a0789fad'
Cloning into 'src/leveldb'...
remote: Counting objects: 1074, done.
remote: Compressing objects: 100% (256/256), done.
remote: Total 1074 (delta 804), reused 1065 (delta 795)
Receiving objects: 100% (1074/1074), 443.15 KiB | 154 KiB/s, done.
Resolving deltas: 100% (804/804), done.
Submodule path 'src/leveldb': checked out
'c79c270174307411819ddfdd8c9b671ec4fb69c9'
Cloning into 'src/libs3'...
remote: Counting objects: 1000, done.
remote: Compressing objects: 100% (289/289), done.
remote: Total 1000 (delta 720), reused 976 (delta 696)
Receiving objects: 100% (1000/1000), 347.92 KiB, done.
Resolving deltas: 100% (720/720), done.
Submodule path 'src/libs3': checked out
'9dc3a9c683385abfe4ad92b7c6ff30719acc3c13'

ubuntu@plana41:~/master-ceph.02$ ./autogen.sh
libtoolize: putting auxiliary files in `.'.
libtoolize: copying file `./ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
libtoolize: copying file `m4/libtool.m4'
libtoolize: copying file `m4/ltoptions.m4'
libtoolize: copying file `m4/ltsugar.m4'
libtoolize: copying file `m4/ltversion.m4'
libtoolize: copying file `m4/lt~obsolete.m4'
libtoolize: `AC_PROG_RANLIB' is rendered obsolete by `LT_INIT'
configure.ac:28: installing `./compile'
configure.ac:23: installing `./config.guess'
configure.ac:23: installing `./config.sub'
configure.ac:27: installing `./install-sh'
configure.ac:27: installing `./missing'
src/Makefile.am: installing `./depcomp'
src/Makefile.am:1362: installing `./py-compile'
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal --force -I m4
autoreconf: configure.ac: tracing
autoreconf: running: libtoolize --install --copy --force
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `build-aux'.
libtoolize: copying file `build-aux/config.guess'
libtoolize: copying file `build-aux/config.sub'
libtoolize: copying file `build-aux/install-sh'
libtoolize: copying file `build-aux/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
libtoolize: copying file `m4/libtool.m4'
libtoolize: copying file `m4/ltoptions.m4'
libtoolize: copying file `m4/ltsugar.m4'
libtoolize: copying file `m4/ltversion.m4'
libtoolize: copying file `m4/lt~obsolete.m4'
autoreconf: running: /usr/bin/autoconf --force
autoreconf: running: /usr/bin/autoheader --force
autoreconf: running: automake --add-missing --copy --force-missing
configure.ac:24: installing `build-aux/missing'
Makefile.am: installing `build-aux/depcomp'
autoreconf: Leaving directory `.'
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal --force -I m4
autoreconf: configure.ac: tracing
autoreconf: running: libtoolize --install --copy --force
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
libtoolize: copying file `m4/libtool.m4'
libtoolize: copying file `m4/ltoptions.m4'
libtoolize: copying file `m4/ltsugar.m4'
libtoolize: copying file `m4/ltversion.m4'
libtoolize: copying file `m4/lt~obsolete.m4'
autoreconf: running: /usr/bin/autoconf --force
autoreconf: running: /usr/bin/autoheader --force
autoreconf: running: automake --add-missing --copy --force-missing
configure.ac:5: installing `../../ar-lib'
autoreconf: Leaving directory `.'
ubuntu@plana41:~/master-ceph.02$

--- 8< ---

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
>>
>> #git clone git://ceph.newdream.net/git/ceph.git=20
>> #git submodule init=20
>> #git module update=20
>> #dpkg-buildpackage=20
>>
>> ...=20
>> autoreconf: running: /usr/bin/autoconf --force=20
>> autoreconf: running: /usr/bin/autoheader --force=20
>> autoreconf: running: automake --add-missing --copy --force-missing=20
>> autoreconf: Leaving directory `.'=20
>> autoreconf: `configure.ac' or `configure.in' is required=20
>> make: *** [configure-stamp] Error 1=20
>> dpkg-buildpackage: error: debian/rules build gave error exit status =
2=20
>>
>>
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
