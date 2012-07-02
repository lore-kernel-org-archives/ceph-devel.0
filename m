From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: btrfs big metadata
Date: Mon, 02 Jul 2012 19:40:09 +0200
Message-ID: <4FF1DCF9.6050604@profihost.ag>
References: <4FF1461D.9060304@profihost.ag> <CAPYLRzjDHf7m3BujRPw=BB_XHqrRqshgHjRetSqrb-EPF4GgXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42026 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab2GBRkO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 13:40:14 -0400
In-Reply-To: <CAPYLRzjDHf7m3BujRPw=BB_XHqrRqshgHjRetSqrb-EPF4GgXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 02.07.2012 18:42, schrieb Gregory Farnum:
> On Sun, Jul 1, 2012 at 11:56 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hello list,
>>
>> i found several people who use big metadata -n 64k -l 64k for ceph. But i
>> haven't found any ceph doc or info why to use this?
>>
>> What's the reason to use big metadata feature with ceph?
>
> One of the big problems users have had with Ceph-on-btrfs is that
> Ceph's usage patterns cause btrfs to dramatically fragment its
> metadata. Big metadata blocks reduce this fragmentation to a level
> where some users find it faster than xfs (which it previously wasn't).

Thanks!

Stefan

