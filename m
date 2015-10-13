From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: lltng enabled by default and qemu apparmor|selinux problems
Date: Tue, 13 Oct 2015 04:19:19 +0200 (CEST)
Message-ID: <2024180394.63217405.1444702759816.JavaMail.zimbra@oxygem.tv>
References: <370906433.54234352.1444583214983.JavaMail.zimbra@oxygem.tv> <12AB04D8-665A-4F2B-8CB1-E5268065DDE0@alcatel-lucent.com> <1681969339.44810690.1444674763678.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:36622 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbJMCTW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 22:19:22 -0400
In-Reply-To: <1681969339.44810690.1444674763678.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: "Paul HEWLETT (Paul)" <paul.hewlett@alcatel-lucent.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

>>I have an open PR [1] to dynamically enable LTTng-UST via new config =
options

Great ,Thanks Jason !



----- Mail original -----
De: "Jason Dillaman" <dillaman@redhat.com>
=C3=80: "Paul HEWLETT (Paul)" <paul.hewlett@alcatel-lucent.com>
Cc: "aderumier" <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.ke=
rnel.org>, "Sage Weil" <sweil@redhat.com>
Envoy=C3=A9: Lundi 12 Octobre 2015 20:32:43
Objet: Re: lltng enabled by default and qemu apparmor|selinux problems

I have an open PR [1] to dynamically enable LTTng-UST via new config op=
tions. This change will hopefully trickle down to older release and wil=
l avoid the SElinux / AppArmor issues in the default case (which led to=
 downstream Ubuntu and Fedora disabling LTTng-UST support). Anyone that=
 wants to use LTTng-UST (i.e. for generating RBD replay traces) can ena=
ble the support and adjust their SElinux / AppArmor rules to accommodat=
e.=20

[1] https://github.com/ceph/ceph/pull/6135=20

--=20

Jason Dillaman=20


----- Original Message -----=20
> From: "Paul HEWLETT (Paul)" <paul.hewlett@alcatel-lucent.com>=20
> To: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-de=
vel@vger.kernel.org>=20
> Cc: "Sage Weil" <sweil@redhat.com>=20
> Sent: Monday, October 12, 2015 4:28:06 AM=20
> Subject: Re: lltng enabled by default and qemu apparmor|selinux probl=
ems=20
>=20
> IF I can add my $0.02 - we were unable to use the libradosstriper lib=
rary in=20
> RHEL6 because it uses the same initialisation tags as librados and lt=
tng=20
> does not like that. We had no problems with RHEL7 version of ceph bec=
ause=20
> lttng is not enabled. Please do not re-enable lttng in RHEL7 and late=
r=20
> branches=E2=80=A6.=20
>=20
> Regards=20
> Paul=20
>=20
>=20
>=20
>=20
> On 11/10/2015 18:06, "ceph-devel-owner@vger.kernel.org on behalf of A=
lexandre=20
> DERUMIER" <ceph-devel-owner@vger.kernel.org on behalf of=20
> aderumier@odiso.com> wrote:=20
>=20
> >Hi,=20
> >=20
> >it seem that since this commit=20
> >=20
> >https://github.com/ceph/ceph/pull/4261/files=20
> >=20
> >lltng is enabled by default.=20
> >=20
> >But this give error with qemu when apparmor|selinux is enabled.=20
> >=20
> >That's why ubuntu && redhat now disable it for their own packages.=20
> >=20
> >https://bugzilla.redhat.com/show_bug.cgi?id=3D1223319=20
> >https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1432644=20
> >=20
> >In the ubuntu launchpad, Sage has made a reply=20
> >=20
> >"=20
> >Sage Weil (sage-newdream) wrote on 2015-04-02: #21=20
> >FWIW, we are disabling the lttng support in the final hammer release=
 to=20
> >avoid this issue (until we come up with a better solution)."=20
> >=20
> >=20
> >It seem that it's still enabled by default in ceph git and ceph.com=20
> >packages.=20
> >=20
> >Is it still planned to disable by default ?=20
> >=20
> >=20
> >=20
> >--=20
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
> >the body of a message to majordomo@vger.kernel.org=20
> >More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
