From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Infiniband 40GB
Date: Thu, 07 Jun 2012 13:25:07 +0200 (CEST)
Message-ID: <d0e700bd-f7f5-423f-9955-28c3835969e2@mailpro>
References: <bccb917b-a474-45a8-a260-ef45f4901309@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45304 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab2FGLZa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 07:25:30 -0400
In-Reply-To: <bccb917b-a474-45a8-a260-ef45f4901309@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, Yann Dupont <Yann.Dupont@univ-nantes.fr>

others tests done today: (kernel 3.4 - ubuntu precise)

3 nodes with 5 osd with btrfs, 1GB journal in tmps forced in writeahead
3 nodes with 1 osd with xfs,8GB journal in tmpfs
3 nodes with 1 osd with btfs,8GB journal in tmpfs forced in writeahead

3 nodes with 5 osd with btrfs, 20G journal on disk forced in writeahead
3 nodes with 1 osd with xfs,20GB journal on disk
3 nodes with 1 osd with btfs,20GB journal on disk forced in writeahead




same behaviour for all cases, writes are constant to disk.

benched with:
rados -p pool3 bench 60 write -t 16

also with=20
fio, bonnie  , random/seq write from guest vm with differents block siz=
e.




----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Amon Ott" <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann =
Dupont" <Yann.Dupont@univ-nantes.fr>=20
Envoy=C3=A9: Jeudi 7 Juin 2012 05:31:15=20
Objet: Re: Infiniband 40GB=20

Hi again,=20
I have done some tests with journals on a real disk, I have same behavi=
our.=20

iostat show constant write to journal and write to disks at the same ti=
me since the beginning of the benchmark.=20


maybe can I try to use differents partitions for each journal ? (curren=
tly I have 1 partition with 5 journal files of each osd)=20

-Alexandre=20



----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Amon Ott" <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann =
Dupont" <Yann.Dupont@univ-nantes.fr>=20
Envoy=C3=A9: Jeudi 7 Juin 2012 05:11:15=20
Objet: Re: Infiniband 40GB=20

Hi mark,=20
I have attached a blktrace of /dev/sdb1 of node1 (osd.0)=20

and also iostat (showing constant writes)=20

bench used:=20

rados -p pool3 bench 60 write -t 16=20


kernel use : 3.4 from intank=20

I'll do tests with journal on an xfs partition today=20

----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Amon Ott" <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann =
Dupont" <Yann.Dupont@univ-nantes.fr>=20
Envoy=C3=A9: Mercredi 6 Juin 2012 18:43:50=20
Objet: Re: Infiniband 40GB=20

Hi Alexandre,=20

If you can run blktrace during your test on one of the OSD data disks=20
and send me the results I can take a look at them. Also, the rados=20
bench settings and output would be useful too.=20

Thanks,=20
Mark=20

On 6/6/12 11:05 AM, Alexandre DERUMIER wrote:=20
> Hi, I have rebuild my cluster with ubuntu precise,=20
>=20
> -kernel 3.2=20
> -ceph 0.47.2=20
> -libc6 2.15=20
> -3 nodes - 5 osd (xfs) by node and 1 tmpfs with 5 journal file.=20
>=20
> I had launch rados bench,=20
> and I see again constant writes to xfs....=20
>=20
> Maybe this is related to tmpfs ?=20
>=20
>=20
> I'll retry with kernel 3.4 from intank tomorrow.=20
> I'll also try with journal on a physical disk with xfs partition.=20
>=20
> I'll keep you in touch.=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Mark Nelson"<mark.nelson@inktank.com>=20
> =C3=80: "Alexandre DERUMIER"<aderumier@odiso.com>=20
> Cc: "Amon Ott"<a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann=
 Dupont"<Yann.Dupont@univ-nantes.fr>=20
> Envoy=C3=A9: Lundi 4 Juin 2012 14:59:58=20
> Objet: Re: Infiniband 40GB=20
>=20
> On 6/4/12 6:40 AM, Alexandre DERUMIER wrote:=20
>> Hi,=20
>>=20
>> I'm currently doing some tests with xfs, debian wheezy with standard=
 libc6 (2.11.3-3) and 3.2 kernel.=20
>>=20
>> I'm doing some iostats(3 nodes with 5 osd), and I see constant write=
s to disks.(as the datas are flushed each second from journal to disk).=
=20
>>=20
>> Journal is big enough (20GB tmpfs) to handle 30s of write.=20
>>=20
>> Do you think it's related to the missing syncfs() support ?=20
>>=20
>> -Alexandre=20
>=20
> Hi Alexandre,=20
>=20
> I've included some seekwatcher results for rados bench tests using 16=
=20
> concurrent 4MB writes on XFS OSD. One shows ubuntu oneiric and the=20
> other precise (ie no syncfs support vs syncfs support in libc).=20
> Unfortunately the original test was on 0.46 and the second test was o=
n=20
> 0.47.2, so multiple things changed between the tests. Both were teste=
d=20
> with kernel 3.4. Interestingly the seeks/second don't seem to drop mu=
ch=20
> but the overall performance has about doubled. This was using a singl=
e=20
> 7200rpm disk for the OSD data disk and a seperate 7200rpm disk for th=
e=20
> journal in both cases. I'd definitely try 0.47.2 with a new libc thou=
gh=20
> and see how that works for you.=20
>=20
> ceph 0.46/oneiric:=20
> http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-oneiric-3.4.mpg=
=20
>=20
> ceph 0.47.2/precise:=20
> http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-precise-3.4.mpg=
=20
>=20
> Mark=20
>=20
>=20
>=20




--=20

--=20




Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20



--=20

--=20




Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
