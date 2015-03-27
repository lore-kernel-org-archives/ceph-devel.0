From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: tcmalloc issue
Date: Fri, 27 Mar 2015 08:21:53 +0100 (CET)
Message-ID: <976582620.219210.1427440913479.JavaMail.zimbra@oxygem.tv>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:51981 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbbC0HV4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 03:21:56 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sommath,

is it only on osds ?

or also clients ?

What is the tmalloc version on ubuntu ? (I would like to known if the p=
roblem exist also on debian)

Regards,

Alexandre
----- Mail original -----
De: "Somnath Roy" <Somnath.Roy@sandisk.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Vendredi 27 Mars 2015 00:18:57
Objet: tcmalloc issue

Sage,=20
Here is the tcmalloc issue I was talking in the performance meeting.=20

http://code.google.com/p/gperftools/issues/detail?id=3D585=20

The tcmalloc is consuming lot of cpus (and eventually slowing down the =
performance) with the following perf top trace.=20

25.73% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::FetchFromSpa=
ns()=20
12.52% libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentral=
Cache(tcmalloc::ThreadCache::FreeList*, unsigned long, int)=20
11.62% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseToSpa=
ns(void*)=20
1.56% [kernel] [k] __copy_user_nocache=20
1.44% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::RemoveRange(v=
oid*, void*, int)=20
1.39% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseListTo=
Spans(void*)=20
0.89% libtcmalloc.so.4.1.2 [.] operator new(unsigned long)=20


The TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is alleviating that but the e=
nv variable setting for this is a noop in the binary we are having in U=
buntu 14.04. It is fixed in gperftools-2.1.90 release.=20
See the following link.=20

http://code.google.com/p/gperftools/=20

We can request Ubuntu guys to incorporate this version or the latest tc=
malloc version which is gperftools-2.4.=20

It will be really helpful if you can push them to incorporate this in 1=
4.04 updates.=20

Thanks & Regards=20
Somnath=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

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
