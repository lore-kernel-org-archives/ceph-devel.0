From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: Re: quick way to rebuild deb packages
Date: Wed, 22 Jul 2015 14:14:38 +0200
Message-ID: <20150722141438.6564a034ef183ff652119573@corp.ovh.com>
References: <20150721181507.138bc9380985439e49ac05ab@corp.ovh.com>
	<55AF38D0.8090303@dachary.org>
	<06681238D8946F44A60AA400760A1CBF0201DC4C@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:48556 "EHLO
	5.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934035AbbGVMOo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jul 2015 08:14:44 -0400
Received: from mail139.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with SMTP id D56D41000FD4
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2015 14:14:41 +0200 (CEST)
In-Reply-To: <06681238D8946F44A60AA400760A1CBF0201DC4C@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'll definitely take a look at make-debs.sh, looks promising. Thanks fo=
r the hint.

I can see it's using ccache, let's see how fast it is :) What build tim=
es are you experiencing ?

On Wed, 22 Jul 2015 08:04:44 +0000
"Zhou, Yuan" <yuan.zhou@intel.com> wrote:

> I'm also using make-debs.sh to generate the binaries for some local d=
eployment. Note that if you need the *tests.deb you'll need to change t=
his scripts a bit.
>=20
> @@ -58,8 +58,8 @@ tar -C $releasedir -zxf $releasedir/ceph_$vers.orig=
=2Etar.gz
>  #
>  cp -a debian $releasedir/ceph-$vers/debian
>  cd $releasedir
> -perl -ni -e 'print if(!(/^Package: .*-dbg$/../^$/))' ceph-$vers/debi=
an/control
> -perl -pi -e 's/--dbg-package.*//' ceph-$vers/debian/rules
> +#perl -ni -e 'print if(!(/^Package: .*-dbg$/../^$/))' ceph-$vers/deb=
ian/control
> +#perl -pi -e 's/--dbg-package.*//' ceph-$vers/debian/rules
>  #
>  # always set the debian version to 1 which is ok because the debian
>  # directory is included in the sources and the upstream version will=
=20
>=20
>=20
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Loic Dachary
> Sent: Wednesday, July 22, 2015 2:32 PM
> To: Bart=C5=82omiej =C5=9Awi=C4=99cki; ceph-devel@vger.kernel.org
> Subject: Re: quick way to rebuild deb packages
>=20
> Hi,
>=20
> Did you try https://github.com/ceph/ceph/blob/master/make-debs.sh ? I=
 would recommend running https://github.com/ceph/ceph/blob/master/run-m=
ake-check.sh first to make sure you can build and test: this will insta=
ll the dependencies you're missing at the same time.
>=20
> Cheers
>=20
> On 21/07/2015 18:15, Bart=C5=82omiej =C5=9Awi=C4=99cki wrote:
> > Hi all,
> >=20
> > I'm currently working on a test environment for ceph where we're us=
ing deb files to deploy new version on test cluster.
> > To make this work efficiently I'd have to quckly build deb packages=
=2E
> >=20
> > I tried dpkg-buildpackages -nc which should keep the results of pre=
vious build but it ends up in a linking error:
> >=20
> >> ...
> >>   CXXLD    ceph_rgw_jsonparser
> >> ./.libs/libglobal.a(json_spirit_reader.o): In function `~thread_sp=
ecific_ptr':
> >> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boos=
t::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::t=
ss_cleanup_function>, void*, bool)'
> >> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boos=
t::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::t=
ss_cleanup_function>, void*, bool)'
> >> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boos=
t::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::t=
ss_cleanup_function>, void*, bool)'
> >> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boos=
t::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::t=
ss_cleanup_function>, void*, bool)'
> >> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boos=
t::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::t=
ss_cleanup_function>, void*, bool)'
> >> ./.libs/libglobal.a(json_spirit_reader.o):/usr/include/boost/threa=
d/tss.hpp:79: more undefined references to `boost::detail::set_tss_data=
(void const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, v=
oid*, bool)' follow
> >> ./.libs/libglobal.a(json_spirit_reader.o): In function `call_once<=
void (*)()>':
> >> ...
> >=20
> > Any ideas on what could go wrong here ?
> >=20
> > Version I'm compiling is v0.94.1 but I've observed same results wit=
h 9.0.1.
> >=20
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20


--=20
Bartlomiej Swiecki <bartlomiej.swiecki@corp.ovh.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
