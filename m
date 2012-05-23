From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 23:30:11 -0700
Message-ID: <4FBC83F3.7070400@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBC811F.5060004@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62459 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab2EWGaN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 02:30:13 -0400
Received: by dady13 with SMTP id y13so9294861dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 23:30:13 -0700 (PDT)
In-Reply-To: <4FBC811F.5060004@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 05/22/2012 11:18 PM, Stefan Priebe - Profihost AG wrote:
> Hi,
>
>>> So try enabling RBD writeback caching =E2=80=94 see http://marc.inf=
o
>>> /?l=3Dceph-devel&m=3D133758599712768&w=3D2
>>> will test tomorrow. Thanks.
> Can we path this to the qemu-drive option?

Yup, see http://article.gmane.org/gmane.comp.file-systems.ceph.devel/64=
00

The normal qemu cache=3Dwriteback/writethrough/none option will work in=
=20
qemu 1.2.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
