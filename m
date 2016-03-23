From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Wed, 23 Mar 2016 09:39:36 -0600
Message-ID: <5D648505-7766-4D93-A94D-43703C560BE2@redhat.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com> <1454742006-85706-3-git-send-email-zyan@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33041 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbcCWPjo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 11:39:44 -0400
Received: by mail-vk0-f42.google.com with SMTP id k1so24410235vkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 08:39:44 -0700 (PDT)
In-Reply-To: <1454742006-85706-3-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, idryomov@gmail.com


> +#define ceph_try_get_string(x)					\
> +({								\
> +	struct ceph_string *___str;				\
> +	rcu_read_lock();					\
> +	___str =3D rcu_dereference(x);				\
> +	if (___str && !kref_get_unless_zero(&___str->kref))	\
> +		___str =3D NULL;					\
> +	rcu_read_unlock();					\
> +	(___str);						\

Isn=E2=80=99t this an unsafe use of __str? As I understand it, it could=
 be updated after rcu_read_unlock().

> +})

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
