From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: btrfs for mon server?
Date: Sun, 04 Nov 2012 19:59:05 +0100
Message-ID: <5096BAF9.7090005@profihost.ag>
References: <5096B811.1030904@profihost.ag> <alpine.DEB.2.00.1211041052070.8980@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56713 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2KDS7J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 13:59:09 -0500
In-Reply-To: <alpine.DEB.2.00.1211041052070.8980@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 04.11.2012 19:53, schrieb Sage Weil:
> On Sun, 4 Nov 2012, Stefan Priebe wrote:
>> Hello,
>>
>> does the mon service also suffer from btrfs as fs? Right now i've only the
>> osd's running btrfs.
>
> Do you mean 'benefit' instead of 'suffer'?
Yes sorry.

> The mon doesn't do anything special with the file system, so there's no
> extra benefit beyond whatever btrfs normally gives you (like checksums).
> I'd just run whatever fs you're most comfortable with.
Thanks.

Stefan
