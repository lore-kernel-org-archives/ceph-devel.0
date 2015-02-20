From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Fri, 20 Feb 2015 17:03:25 +0100 (CET)
Message-ID: <252858605.1545602.1424448205171.JavaMail.zimbra@oxygem.tv>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com> <54B6F103.9000708@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com> <54E6F96B.9080202@ubuntu.com> <CA+z5DszfGOE3bE0M6ti-4GyRj2CXypsNRv1J=6Wx4b65NqE=Vg@mail.gmail.com> <54E754DA.6060703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:53848 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbbBTQD1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 11:03:27 -0500
In-Reply-To: <524687337.1545267.1424448115086.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, James Page <james.page@ubuntu.com>, ceph-devel <ceph-devel@vger.kernel.org>, Stephen L Blinick <stephen.l.blinick@intel.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Colin Ian King <colin.king@canonical.com>, Patricia Gaughen <patricia.gaughen@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

>>http://rhelblog.redhat.com/2015/01/12/mysteries-of-numa-memory-manage=
ment-revealed/=20
>>It's possible that this could be having an effect on the results.=20

Isn't auto numa balancing enabled by default since kernel 3.8 ?

it can be checked with=20

cat /proc/sys/kernel/numa_balancing



----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "Blair Bethwaite" <blair.bethwaite@gmail.com>, "James Page" <ja=
mes.page@ubuntu.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Stephen L Blinick" <ste=
phen.l.blinick@intel.com>, "Jay Vosburgh" <jay.vosburgh@canonical.com>,=
 "Colin Ian King" <colin.king@canonical.com>, "Patricia Gaughen" <patri=
cia.gaughen@canonical.com>, "Leann Ogasawara" <leann.ogasawara@canonica=
l.com>
Envoy=C3=A9: Vendredi 20 F=C3=A9vrier 2015 16:38:02
Objet: Re: Memstore performance improvements v0.90 vs v0.87

I think paying attention to NUMA is good advice. One of the things that=
=20
apparently changed in RHEL7 is that they are now doing automatic NUMA=20
tuning:=20

http://rhelblog.redhat.com/2015/01/12/mysteries-of-numa-memory-manageme=
nt-revealed/=20

It's possible that this could be having an effect on the results.=20

Mark=20

On 02/20/2015 03:49 AM, Blair Bethwaite wrote:=20
> Hi James,=20
>=20
> Interesting results, but did you do any tests with a NUMA system? IIU=
C=20
> the original report was from a dual socket setup, and that'd=20
> presumably be the standard setup for most folks (both OSD server and=20
> client side).=20
>=20
> Cheers,=20
>=20
> On 20 February 2015 at 20:07, James Page <james.page@ubuntu.com> wrot=
e:=20
>> -----BEGIN PGP SIGNED MESSAGE-----=20
>> Hash: SHA256=20
>>=20
>> Hi All=20
>>=20
>> The Ubuntu Kernel team have spent the last few weeks investigating t=
he=20
>> apparent performance disparity between RHEL 7 and Ubuntu 14.04; we'v=
e=20
>> focussed efforts in a few ways (see below).=20
>>=20
>> All testing has been done using the latest Firefly release.=20
>>=20
>> 1) Base network latency=20
>>=20
>> Jay Vosburgh looked at the base network latencies between RHEL 7 and=
=20
>> Ubuntu 14.04; under default install, RHEL actually had slightly wors=
e=20
>> latency than Ubuntu due to the default enablement of a firewall;=20
>> disabling this brought latency back inline between the two distribut=
ions:=20
>>=20
>> OS rtt min/avg/max/mdev=20
>> Ubuntu 14.04 (3.13) 0.013/0.016/0.018/0.005 ms=20
>> RHEL7 (3.10) 0.010/0.018/0.025/0.005 ms=20
>>=20
>> ...base network latency is pretty much the same.=20
>>=20
>> This testing was performed on a matched pair of Dell Poweredge R610'=
s,=20
>> configured with a single 4 core CPU and 8G of RAM.=20
>>=20
>> 2) Latency and performance in Ceph using Rados bench=20
>>=20
>> Colin King spent a number of days testing and analysing results usin=
g=20
>> rados bench against a single node ceph deployment, configured with a=
=20
>> single memory backed OSD, to see if we could reproduce the dispariti=
es=20
>> reported.=20
>>=20
>> He ran 120 second OSD benchmarks on RHEL 7 as well as Ubuntu 14.04 L=
TS=20
>> with a selection of kernels including 3.10 vanilla, 3.13.0-44 (relea=
se=20
>> kernel), 3.16.0-30 (utopic HWE kernel), 3.18.0-12 (vivid HWE kernel)=
=20
>> and 3.19-rc6 with 1, 16 and 128 client threads. The data collected i=
s=20
>> available at [0].=20
>>=20
>> Each round of tests consisted of 15 runs, from which we computed=20
>> average latency, latency deviation and latency distribution:=20
>>=20
>>> 120 second x 1 thread=20
>>=20
>> Results all seem to cluster around 0.04->0.05ms, with RHEL 7 averagi=
ng=20
>> at 0.044 and recent Ubuntu kernels at 0.036-0.037ms. The older 3.10=20
>> kernel in RHEL 7 does have some slightly higher average latency.=20
>>=20
>>> 120 second x 16 threads=20
>>=20
>> Results all seem to cluster around 0.6-0.7ms. 3.19.0-rc6 had a coupl=
e=20
>> of 1.4ms outliers which pushed it out to be worse than RHEL 7. On th=
e=20
>> whole Ubuntu 3.10-3.18 kernels are better than RHEL 7 by ~0.1ms. RHE=
L=20
>> shows a far higher standard deviation, due to the bimodal latency=20
>> distribution, which from the casual observer may appear to be more=20
>> "jittery".=20
>>=20
>>> 120 second x 128 threads=20
>>=20
>> Later kernels show up to have less standard deviation than RHEL 7, s=
o=20
>> that shows perhaps less jitter in the stats than RHEL 7's 3.10 kerne=
l.=20
>> With this many threads pounding the test, we get a wider spread of=20
>> latencies and it is hard to tell any kind of latency distribution=20
>> patterns with just 15 rounds because of the large amount of latency=20
>> jitter. All systems show a latency of ~ 5ms. Taking into=20
>> consideration the amount of jitter, we think these results do not ma=
ke=20
>> much sense unless we repeat these tests with say 100 samples.=20
>>=20
>> 3) Conclusion=20
>>=20
>> We=E2=80=99ve have not been able to show any major anomalies in Ceph=
 on Ubuntu=20
>> compared to RHEL 7 when using memstore. Our current hypothesis is th=
at=20
>> one needs to run the OSD bench stressor many times to get a fair cap=
ture=20
>> of system latency stats. The reason for this is:=20
>>=20
>> * Latencies are very low with memstore, so any small jitter in=20
>> scheduling etc will show up as a large distortion (as shown by the l=
arge=20
>> standard deviations in the samples).=20
>>=20
>> * When memstore is heavily utilized, memory pressure causes the syst=
em=20
>> to page heavily and so we are subject to the nature of perhaps delay=
s on=20
>> paging that cause some latency jitters. Latency differences may be j=
ust=20
>> down to where a random page is in memory or in swap, and with memsto=
re=20
>> these may cause the large perturbations we see when running just a=20
>> single test.=20
>>=20
>> * We needed to make *many* tens of measurements to get a typical ide=
a of=20
>> average latency and the latency distributions. Don't trust the resul=
ts=20
>> from just one test=20
>>=20
>> * We ran the tests with a pool configured to 100 pgs and 100 pgps [1=
].=20
>> One can get different results with different placement group configs=
=2E=20
>>=20
>> I've CC'ed both Colin and Jay on this mail - so if anyone has any=20
>> specific questions about the testing they can chime in with response=
s.=20
>>=20
>> Regards=20
>>=20
>> James=20
>>=20
>> [0] http://kernel.ubuntu.com/~cking/.ceph/ceph-benchmarks.ods=20
>> [1] http://ceph.com/docs/master/rados/configuration/pool-pg-config-r=
ef/=20
>>=20
>> - --=20
>> James Page=20
>> Ubuntu and Debian Developer=20
>> james.page@ubuntu.com=20
>> jamespage@debian.org=20
>> -----BEGIN PGP SIGNATURE-----=20
>> Version: GnuPG v1=20
>>=20
>> iQIcBAEBCAAGBQJU5vlrAAoJEL/srsug59jDMvAQAIhSR4GFTXNc4RLpHtLT6h/X=20
>> K5uyauKZGtL+wqtPKRfsXqbbUw9I5AZDifQuOEJ0APccLIPbgqxEN3d2uht/qygH=20
>> G8q2Ax+M8OyZz07yqTitnD4JV3RmL8wNHUveWPLV0gs2TzBBYwP1ywExbRPed3PY=20
>> cfDrszgkQszA/JwT5W5YNf1LZc+5VpOEFrTiLIaRzUDoxg7mm6Hwr3XT8OFjZhjm=20
>> LSenKREHtrKKWoBh+OKTvuCUnHzEemK+CiwwRbNQ8l7xbp71wLyS08NpSB5C1y70=20
>> 7uft+kP6XOGE9AKLvsdEL1PIXHfeKNonBEN5mO6nsXIW+MQzou01zHgDtne7AxDA=20
>> 5OebQJfJtArmKt78WHuVg7h8gPcIRTRSW43LqJiADnIHL8fnZxj2v5yDiUQj7isw=20
>> nYWXEJ3rR7mlVgydN34KQ7gpVWmGjhrVb8N01+zYOMAaTBnekldHdueEAXR07eU0=20
>> PXiP9aOZiAxbEnDiJmreehjCuNFTagQqNeECRIHssSacfQXPxVljaImvuSfrxf8i=20
>> myQLzftiObINTIHSN4TVDKMyveYrU2hILCKfYuxnSJh29j35wsRSeftjntOEyHai=20
>> RDnrLD3fCPk4h3hCY6l60nqu9MQfbgdSB/FItvhiBGYqXvGb4+wuBeU9RT9SwG8N=20
>> XPih7nLNvqDNw38IkkDN=20
>> =3DqcvG=20
>> -----END PGP SIGNATURE-----=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
>=20
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
