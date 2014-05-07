From: suxinyi <suxinyi@tsinghua.org.cn>
Subject: Issue about ObjectCache::put method
Date: Wed, 7 May 2014 19:31:06 +0800 (CST)
Message-ID: <10038971.893981399462266519.JavaMail.coremail@mailserver3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [211.151.65.104] ([211.151.65.104]:42206 "EHLO tsinghua.org.cn"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755574AbaEGMDq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 08:03:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.orgceph-devel@vger.kernel.org

Hi, all

I am using S3 api to access radosgw to put/get object. I found some iss=
ue about ObjectCache::put implementation.
In radosgw implementation, it will do authorizing before reading the ob=
ject.
During authorizing, it will get user object from .users pool. If the ob=
ject is not cache hit, it will send [getxattrs, stat] op and [read] op =
in two separate and sequential ops. These two op will update radosgw ca=
che both.

In the [read] op, when updating cache, =C2=A0it will check the flag if =
it contains CACHE_FLAG_MODIFY_XATTRS and will clear CACHE_FLAG_META if =
not contains, just as the code I pasted below. Thus it will cause CACHE=
_FLAG_META =C2=A0cleared because info.flags passed in is CACHE_FLAG_DAT=
A. It does not contain CACHE_FLAG_MODIFY_XATTRS.

I have marked the code red.
void ObjectCache::put(string& name, ObjectCacheInfo& info)
{
=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6...
         if (info.flags & CACHE_FLAG_META)
                 target.meta =3D info.meta;
	 else if (!(info.flags & CACHE_FLAG_MODIFY_XATTRS))
=C2=A0 =C2=A0		 target.flags &=3D ~CACHE_FLAG_META; // non-meta change =
should reset meta
=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6...
}


Then if I fetch the object using S3 API again, radosgw will get user ob=
ject from cache and find cache miss because flags mismatch. It need (CA=
CHE_FLAG_MODIFY_XATTRS|CACHE_FLAG_META), but the cached object flag is =
(CACHE_FLAG_MODIFY_XATTRS|CACHE_FLAG_DATA) . It will cause radosgw subm=
itting op[getxattr,stat] again to get the same object.

I wonder why it will clear CACHE_FLAG_META and should we comment them s=
ince it will cause another extra op.=20

Btw, The ceph version I am using is 0.67.7.

I am looking for your reply and thanks ahead.

Best regards.
Xinyi

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
