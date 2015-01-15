From: Wido den Hollander <wido@42on.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 16:52:47 +0100
Message-ID: <54B7E24F.9000309@42on.com>
References: <54B7D2D6.4020503@42on.com> <3BFFC9C1-0253-4218-9065-3E203027D46A@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:40219 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbbAOPwt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Jan 2015 10:52:49 -0500
In-Reply-To: <3BFFC9C1-0253-4218-9065-3E203027D46A@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 01/15/2015 04:39 PM, Dan Van Der Ster wrote:
> Hi Wido,
>=20
> +1 for safeguards.
>=20
> Yeah that is scary: it's one api call to delete a pool, and perhaps e=
ven a client with w capability on a pool can delete it?? (I didn=E2=80=99=
t try...)
>=20

Quick try, yes! Created a pool and user which only has access to that
pool. I was able to remove that pool.

> I can think of many ways that fat fingers can create crazy loads, den=
y client access, ...
>=20

Sure, but none of those actually make you loose your data.

I know that you should create backups, but by accident removing a pool
is something that is very dangerous and it will take a lot of time to
restore from backups.

>  1. changing pool size
>  2. setting pool quotas
>  3. unplanned PG splitting
>  4. creating an EC pool on a cluster with dumpling clients
>  5. reweight-by-utilization
>  6. changing crush rules/tunables
>=20
> =E2=80=94yes-i-really-really-mean-it is nice when it=E2=80=99s there.=
 But regardless it is probably not a good practice to work daily (or ru=
n librados cron jobs) in a shell that has access to the client.admin ke=
yring. I=E2=80=99ve thought of using sudo to restrict our admin shell t=
o subset of ceph admin commands. But even better would be a internal bi=
t which locks out the API beneath =E2=80=9Cceph osd pool =E2=80=A6=E2=80=
=9D and =E2=80=9Cceph osd crush =E2=80=A6=E2=80=9D, even for client.adm=
in.
>=20
> Maybe this is already possible by creating a client.admin-readonly ac=
count for daily work and crons, and limit access to client.admin except=
 when absolutely necessary ?
>=20

That would be great indeed. The client.admin key currently has all the
capabilities and I would indeed like a RO account.

But still, another safeguard against deleting pools would be something
I'd like to see.

Wido

> Cheers, Dan
>=20
>=20
>> On 15 Jan 2015, at 15:46, Wido den Hollander <wido@42on.com> wrote:
>>
>> Hi,
>>
>> Although the userland tools like 'ceph' and 'rados' have a safeguard
>> against fat fingers when it comes to removing a pool there is no suc=
h
>> safeguard when using native librados.
>>
>> The danger still exists that by accident you remove a pool which is =
then
>> completely gone, no way to restore it.
>>
>> This is still something I find quite dangerous, so I was thinking ab=
out
>> a additional 'Immutable bit' which could be set on a pool before
>> rados_pool_delete() allows this pool to be removed.
>>
>> Is it a sane thing to look at 'features' which pools could have? Oth=
er
>> features which might be set on a pool:
>>
>> - Read Only (all write operations return -EPERM)
>> - Delete Protected
>>
>> It's just that looking at a 20TB RBD pool and thinking that just one=
 API
>> call could remove this pool make me a bit scared.
>>
>> Am I the only one or is this something worth looking in to?
>>
>> --=20
>> Wido den Hollander
>> 42on B.V.
>> Ceph trainer and consultant
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
