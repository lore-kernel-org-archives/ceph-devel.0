From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Sat, 21 Feb 2015 10:02:53 +0100 (CET)
Message-ID: <1725252187.1574758.1424509373883.JavaMail.zimbra@oxygem.tv>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com> <54E6F96B.9080202@ubuntu.com> <CA+z5DszfGOE3bE0M6ti-4GyRj2CXypsNRv1J=6Wx4b65NqE=Vg@mail.gmail.com> <54E754DA.6060703@redhat.com> <252858605.1545602.1424448205171.JavaMail.zimbra@oxygem.tv> <54E75CFE.70601@redhat.com> <893632926.1573877.1424506229039.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52910 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbBUJC4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Feb 2015 04:02:56 -0500
In-Reply-To: <1429598219.1574757.1424509359439.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, James Page <james.page@ubuntu.com>, ceph-devel <ceph-devel@vger.kernel.org>, Stephen L Blinick <stephen.l.blinick@intel.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Colin Ian King <colin.king@canonical.com>, Patricia Gaughen <patricia.gaughen@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

>>One Other thing you could also check, is if transparent hugepages is =
enabled or not.
>>It's known to slowdown some applications, like databases for example.=
 (So maybe memstore too)
>>
>>#cat /sys/kernel/mm/transparent_hugepage/enabled
>>    always madvise [never]

This is disabled by default is you use the network-latency tuned profil=
e

https://developerblog.redhat.com/2015/02/11/low-latency-performance-tun=
ing-rhel-7/


----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "Mark Nelson" <mnelson@redhat.com>
Cc: "Blair Bethwaite" <blair.bethwaite@gmail.com>, "James Page" <james.=
page@ubuntu.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Stephen L=
 Blinick" <stephen.l.blinick@intel.com>, "Jay Vosburgh" <jay.vosburgh@c=
anonical.com>, "Colin Ian King" <colin.king@canonical.com>, "Patricia G=
aughen" <patricia.gaughen@canonical.com>, "Leann Ogasawara" <leann.ogas=
awara@canonical.com>
Envoy=C3=A9: Samedi 21 F=C3=A9vrier 2015 09:10:29
Objet: Re: Memstore performance improvements v0.90 vs v0.87

>>At least at first glance it doesn't look like it's enabled on either =
our=20
>>RHEL7 or Ubuntu nodes. No numad running either.=20

Do you have disable autonuma balancing manually ?=20

because look at kernel config of both rhel7 and ubuntu, it's really see=
m to be enabled by default:=20

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy=20
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy=20
CONFIG_NUMA_BALANCING=3Dy=20


>>No numad running either.=20

AFAIK, numad was used by RHEL6, and auto-numabalancing is used since RH=
EL7.=20




One Other thing you could also check, is if transparent hugepages is en=
abled or not.=20
It's known to slowdown some applications, like databases for example. (=
So maybe memstore too)=20

#cat /sys/kernel/mm/transparent_hugepage/enabled=20
always madvise [never]=20



----- Mail original -----=20
De: "Mark Nelson" <mnelson@redhat.com>=20
=C3=80: "aderumier" <aderumier@odiso.com>=20
Cc: "Blair Bethwaite" <blair.bethwaite@gmail.com>, "James Page" <james.=
page@ubuntu.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Stephen L=
 Blinick" <stephen.l.blinick@intel.com>, "Jay Vosburgh" <jay.vosburgh@c=
anonical.com>, "Colin Ian King" <colin.king@canonical.com>, "Patricia G=
aughen" <patricia.gaughen@canonical.com>, "Leann Ogasawara" <leann.ogas=
awara@canonical.com>=20
Envoy=C3=A9: Vendredi 20 F=C3=A9vrier 2015 17:12:46=20
Objet: Re: Memstore performance improvements v0.90 vs v0.87=20

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
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
