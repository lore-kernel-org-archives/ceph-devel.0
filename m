From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Thu, 24 Mar 2016 09:30:06 -0600
Message-ID: <2A04A68C-9C5D-4E51-BDFA-B829BA75B8B4@redhat.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com> <1454742006-85706-3-git-send-email-zyan@redhat.com> <5D648505-7766-4D93-A94D-43703C560BE2@redhat.com> <02898380-15B7-470A-844C-3F9D10DF5D2A@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32948 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcCXPaU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 11:30:20 -0400
Received: by mail-ig0-f177.google.com with SMTP id ig19so124633051igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 08:30:19 -0700 (PDT)
In-Reply-To: <02898380-15B7-470A-844C-3F9D10DF5D2A@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, idryomov@gmail.com


> On Mar 23, 2016, at 7:39 PM, Yan, Zheng <zyan@redhat.com> wrote:
>=20
>=20
>> On Mar 23, 2016, at 23:39, Douglas Fuller <dfuller@redhat.com> wrote=
:
>>=20
>>=20
>>> +#define ceph_try_get_string(x)					\
>>> +({								\
>>> +	struct ceph_string *___str;				\
>>> +	rcu_read_lock();					\
>>> +	___str =3D rcu_dereference(x);				\
>>> +	if (___str && !kref_get_unless_zero(&___str->kref))	\
>>> +		___str =3D NULL;					\
>>> +	rcu_read_unlock();					\
>>> +	(___str);						\
>>=20
>> Isn=E2=80=99t this an unsafe use of __str? As I understand it, it co=
uld be updated after rcu_read_unlock().
>=20
> where does it get updated?

By a later RCU update. As I understand it, an rcu_dereference()d pointe=
r is only guaranteed stable inside rcu_read_lock()/rcu_read_unlock().

>=20
> Regards
> Yan, Zheng
>=20
>>=20
>>> +})
>>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
