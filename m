From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: lltng enabled by default and qemu apparmor|selinux problems
Date: Mon, 12 Oct 2015 14:32:43 -0400 (EDT)
Message-ID: <1681969339.44810690.1444674763678.JavaMail.zimbra@redhat.com>
References: <370906433.54234352.1444583214983.JavaMail.zimbra@oxygem.tv> <12AB04D8-665A-4F2B-8CB1-E5268065DDE0@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:52804 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbbJLScu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 14:32:50 -0400
In-Reply-To: <12AB04D8-665A-4F2B-8CB1-E5268065DDE0@alcatel-lucent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Paul HEWLETT (Paul)" <paul.hewlett@alcatel-lucent.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

I have an open PR [1] to dynamically enable LTTng-UST via new config op=
tions.  This change will hopefully trickle down to older release and wi=
ll avoid the SElinux / AppArmor issues in the default case (which led t=
o downstream Ubuntu and Fedora disabling LTTng-UST support).  Anyone th=
at wants to use LTTng-UST (i.e. for generating RBD replay traces) can e=
nable the support and adjust their SElinux / AppArmor rules to accommod=
ate.

[1] https://github.com/ceph/ceph/pull/6135

--=20

Jason Dillaman=20


----- Original Message -----
> From: "Paul HEWLETT (Paul)" <paul.hewlett@alcatel-lucent.com>
> To: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-de=
vel@vger.kernel.org>
> Cc: "Sage Weil" <sweil@redhat.com>
> Sent: Monday, October 12, 2015 4:28:06 AM
> Subject: Re: lltng enabled by default and qemu apparmor|selinux probl=
ems
>=20
> IF I can add my $0.02 - we were unable to use the libradosstriper lib=
rary in
> RHEL6 because it uses the same initialisation tags as librados and lt=
tng
> does not like that. We had no problems with RHEL7 version of ceph bec=
ause
> lttng is not enabled. Please do not re-enable lttng in RHEL7 and late=
r
> branches=E2=80=A6.
>=20
> Regards
> Paul
>=20
>=20
>=20
>=20
> On 11/10/2015 18:06, "ceph-devel-owner@vger.kernel.org on behalf of A=
lexandre
> DERUMIER" <ceph-devel-owner@vger.kernel.org on behalf of
> aderumier@odiso.com> wrote:
>=20
> >Hi,
> >
> >it seem that since this commit
> >
> >https://github.com/ceph/ceph/pull/4261/files
> >
> >lltng is enabled by default.
> >
> >But this give error with qemu when apparmor|selinux is enabled.
> >
> >That's why ubuntu && redhat now disable it for their own packages.
> >
> >https://bugzilla.redhat.com/show_bug.cgi?id=3D1223319
> >https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1432644
> >
> >In the ubuntu launchpad, Sage has made a reply
> >
> >"
> >Sage Weil (sage-newdream) wrote on 2015-04-02:	#21
> >FWIW, we are disabling the lttng support in the final hammer release=
 to
> >avoid this issue (until we come up with a better solution)."
> >
> >
> >It seem that it's still enabled by default in ceph git and ceph.com
> >packages.
> >
> >Is it still planned to disable by default ?
> >
> >
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
