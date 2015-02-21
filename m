From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Sat, 21 Feb 2015 09:10:29 +0100 (CET)
Message-ID: <893632926.1573877.1424506229039.JavaMail.zimbra@oxygem.tv>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com> <54E6F96B.9080202@ubuntu.com> <CA+z5DszfGOE3bE0M6ti-4GyRj2CXypsNRv1J=6Wx4b65NqE=Vg@mail.gmail.com> <54E754DA.6060703@redhat.com> <252858605.1545602.1424448205171.JavaMail.zimbra@oxygem.tv> <54E75CFE.70601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50345 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbBUIKb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Feb 2015 03:10:31 -0500
In-Reply-To: <298703592.1573873.1424506210041.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, James Page <james.page@ubuntu.com>, ceph-devel <ceph-devel@vger.kernel.org>, Stephen L Blinick <stephen.l.blinick@intel.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Colin Ian King <colin.king@canonical.com>, Patricia Gaughen <patricia.gaughen@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

>>At least at first glance it doesn't look like it's enabled on either =
our=20
>>RHEL7 or Ubuntu nodes. No numad running either.=20

Do you have disable autonuma balancing manually ?

because look at kernel config of both rhel7 and ubuntu, it's really see=
m to be enabled by default:

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
CONFIG_NUMA_BALANCING=3Dy


>>No numad running either.=20

AFAIK, numad was used by RHEL6, and auto-numabalancing is used since RH=
EL7.




One Other thing you could also check, is if transparent hugepages is en=
abled or not.
It's known to slowdown some applications, like databases for example. (=
So maybe memstore too)

#cat /sys/kernel/mm/transparent_hugepage/enabled
    always madvise [never]



----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "Blair Bethwaite" <blair.bethwaite@gmail.com>, "James Page" <james.=
page@ubuntu.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Stephen L=
 Blinick" <stephen.l.blinick@intel.com>, "Jay Vosburgh" <jay.vosburgh@c=
anonical.com>, "Colin Ian King" <colin.king@canonical.com>, "Patricia G=
aughen" <patricia.gaughen@canonical.com>, "Leann Ogasawara" <leann.ogas=
awara@canonical.com>
Envoy=C3=A9: Vendredi 20 F=C3=A9vrier 2015 17:12:46
Objet: Re: Memstore performance improvements v0.90 vs v0.87

On 02/20/2015 10:03 AM, Alexandre DERUMIER wrote:=20
>>> http://rhelblog.redhat.com/2015/01/12/mysteries-of-numa-memory-mana=
gement-revealed/=20
>>> It's possible that this could be having an effect on the results.=20
>=20
> Isn't auto numa balancing enabled by default since kernel 3.8 ?=20

No idea, I'm behind the times on what's been going on with numa tuning.=
=20

>=20
> it can be checked with=20
>=20
> cat /proc/sys/kernel/numa_balancing=20

At least at first glance it doesn't look like it's enabled on either ou=
r=20
RHEL7 or Ubuntu nodes. No numad running either.=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
