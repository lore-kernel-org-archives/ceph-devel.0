From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 06 Jul 2012 05:50:40 +0200 (CEST)
Message-ID: <9437d87e-97db-48fc-a133-f25042b21a38@mailpro>
References: <CAPYLRzhU9pyp-ExVL0wfXL4=F=CHY4uWd7=3tPzgKA4-kPYTZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49064 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab2GFDvE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 23:51:04 -0400
In-Reply-To: <CAPYLRzhU9pyp-ExVL0wfXL4=F=CHY4uWd7=3tPzgKA4-kPYTZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>

Hi,=20
Stefan is on vacation for the moment,I don't know if he can reply you.

But I can reoly for him for the kvm part (as we do same tests together =
in parallel).

- kvm is 1.1
- rbd 0.48
- drive option rbd:pool/volume:auth_supported=3Dcephx;none;keyring=3D/e=
tc/pve/priv/ceph/ceph.keyring:mon_host=3DX.X.X.X";
-using writeback

writeback tuning in ceph.conf on the kvm host

rbd_cache_size =3D 33554432=20
rbd_cache_max_age =3D 2.0=20

benchmark use in kvm guest:
fio --filename=3D$DISK --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=3D=
200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1

results show max 14000io/s with 1 vm, 7000io/s by vm with 2vm,...
so it doesn't scale

(bench is with directio, so maybe writeback cache don't help)

hardware for ceph , is 3 nodes with 4 intel ssd each. (1 drive can hand=
le 40000io/s randwrite locally)


- Alexandre

----- Mail original -----=20

De: "Gregory Farnum" <greg@inktank.com>=20
=C3=80: "Stefan Priebe" <s.priebe@profihost.ag>=20
Cc: ceph-devel@vger.kernel.org, "Sage Weil" <sage@inktank.com>=20
Envoy=C3=A9: Jeudi 5 Juillet 2012 23:33:18=20
Objet: Re: speedup ceph / scaling / find the bottleneck=20

Could you send over the ceph.conf on your KVM host, as well as how=20
you're configuring KVM to use rbd?=20

On Tue, Jul 3, 2012 at 11:20 AM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:=20
> I'm sorry but this is the KVM Host Machine there is no ceph running o=
n this=20
> machine.=20
>=20
> If i change the admin socket to:=20
> admin_socket=3D/var/run/ceph_$name.sock=20
>=20
> i don't have any socket at all ;-(=20
>=20
> Am 03.07.2012 17:31, schrieb Sage Weil:=20
>=20
>> On Tue, 3 Jul 2012, Stefan Priebe - Profihost AG wrote:=20
>>>=20
>>> Hello,=20
>>>=20
>>> Am 02.07.2012 22:30, schrieb Josh Durgin:=20
>>>>=20
>>>> If you add admin_socket=3D/path/to/admin_socket for your client ru=
nning=20
>>>> qemu (in that client's ceph.conf section or manually in the qemu=20
>>>> command line) you can check that caching is enabled:=20
>>>>=20
>>>> ceph --admin-daemon /path/to/admin_socket show config | grep rbd_c=
ache=20
>>>>=20
>>>> And see statistics it generates (look for cache) with:=20
>>>>=20
>>>> ceph --admin-daemon /path/to/admin_socket perfcounters_dump=20
>>>=20
>>>=20
>>> This doesn't work for me:=20
>>> ceph --admin-daemon /var/run/ceph.sock show config=20
>>> read only got 0 bytes of 4 expected for response length; invalid=20
>>> command?2012-07-03 09:46:57.931821 7fa75d129700 -1 asok(0x8115a0)=20
>>> AdminSocket:=20
>>> request 'show config' not defined=20
>>=20
>>=20
>> Oh, it's 'config show'. Also, 'help' will list the supported command=
s.=20
>>=20
>>> Also perfcounters does not show anything:=20
>>> # ceph --admin-daemon /var/run/ceph.sock perfcounters_dump=20
>>> {}=20
>>=20
>>=20
>> There may be another daemon that tried to attach to the same socket =
file.=20
>> You might want to set 'admin socket =3D /var/run/ceph/$name.sock' or=
=20
>> something similar, or whatever else is necessary to make it a unique=
 file.=20
>>=20
>>> ~]# ceph -v=20
>>> ceph version 0.48argonaut-2-gb576faa=20
>>> (commit:b576faa6f24356f4d3ec7205e298d58659e29c68)=20
>>=20
>>=20
>> Out of curiousity, what patches are you applying on top of the relea=
se?=20
>>=20
>> sage=20
>>=20
>=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
