From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 16:43:53 +0200
Message-ID: <4FC4E0A9.8010008@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:34234 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab2E2Onx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 10:43:53 -0400
In-Reply-To: <4FC4D1A8.1080001@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: ceph-devel@vger.kernel.org

Am 29.05.2012 15:39, schrieb Yann Dupont:
> On 29/05/2012 11:46, Stefan Priebe - Profihost AG wrote:
>> It would be really nice if somebody from inktank can comment this whole
>> sitation.
>>
> Hello.
> I think I have the same bug :
> 
> My setup is with 8 OSD nodes, 3 MDS (1 active) & 3 MON.
> All my machines are debian, using a custom 3.4.0 kernel. Ceph is
> 0.47.2-1~bpo60+1 (debian package)

That sounds absolutely like the same issue. Sadly nobody from inktank
has replied to this problems for the last days.

> As you can see, much more stable bandwith with this pool.
That's pretty strange...

> I understand data & rbd pool probably don't use the same internals, but
> is this difference expected ?

There must be differences in pool handling.

Stefan
