From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Interesting results
Date: Mon, 02 Jul 2012 16:07:52 +0200
Message-ID: <4FF1AB38.8050508@profihost.ag>
References: <4FECDCB0.7080406@sandia.gov> <4FF0AB99.4060103@profihost.ag> <4FF1AA80.4070009@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37594 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2GBOHz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 10:07:55 -0400
In-Reply-To: <4FF1AA80.4070009@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 02.07.2012 16:04, schrieb Jim Schutt:
> On 07/01/2012 01:57 PM, Stefan Priebe wrote:
>> thanks for sharing. Which btrfs mount options did you use?
>
>   -o noatime
>
> is all I use.

Thanks. Have you ever measured random I/O performance? Or is sequential 
all you need?

Stefan
