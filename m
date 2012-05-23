From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 09:01:21 +0200
Message-ID: <4FBC8B41.1020300@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBC811F.5060004@profihost.ag> <4FBC83F3.7070400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42751 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab2EWHBO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 03:01:14 -0400
In-Reply-To: <4FBC83F3.7070400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Am 23.05.2012 08:30, schrieb Josh Durgin:
> On 05/22/2012 11:18 PM, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>>>> So try enabling RBD writeback caching =E2=80=94 see http://marc.in=
fo
>>>> /?l=3Dceph-devel&m=3D133758599712768&w=3D2
>>>> will test tomorrow. Thanks.
>> Can we path this to the qemu-drive option?
>=20
> Yup, see http://article.gmane.org/gmane.comp.file-systems.ceph.devel/=
6400
I'm sorry, i still don't get it where to pass rbd_cache_max_dirty, ...
can i add it just to the ceph.conf? Even with qemu 1.0?

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
