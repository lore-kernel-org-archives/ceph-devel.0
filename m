From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Thu, 24 Mar 2016 09:39:58 +0800
Message-ID: <02898380-15B7-470A-844C-3F9D10DF5D2A@redhat.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com> <1454742006-85706-3-git-send-email-zyan@redhat.com> <5D648505-7766-4D93-A94D-43703C560BE2@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbcCXBkG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 21:40:06 -0400
In-Reply-To: <5D648505-7766-4D93-A94D-43703C560BE2@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, idryomov@gmail.com


> On Mar 23, 2016, at 23:39, Douglas Fuller <dfuller@redhat.com> wrote:
>=20
>=20
>> +#define ceph_try_get_string(x)					\
>> +({								\
>> +	struct ceph_string *___str;				\
>> +	rcu_read_lock();					\
>> +	___str =3D rcu_dereference(x);				\
>> +	if (___str && !kref_get_unless_zero(&___str->kref))	\
>> +		___str =3D NULL;					\
>> +	rcu_read_unlock();					\
>> +	(___str);						\
>=20
> Isn=E2=80=99t this an unsafe use of __str? As I understand it, it cou=
ld be updated after rcu_read_unlock().

where does it get updated?

Regards
Yan, Zheng

>=20
>> +})
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
