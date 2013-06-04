From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: flatten rbd export / export-diff ?
Date: Tue, 04 Jun 2013 20:04:20 +0200
Message-ID: <51AE2C24.6060200@profihost.ag>
References: <51ADEE2B.4050403@profihost.ag> <alpine.DEB.2.00.1306040821550.12900@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:34943 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3FDSEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 14:04:16 -0400
In-Reply-To: <alpine.DEB.2.00.1306040821550.12900@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 04.06.2013 17:23, schrieb Sage Weil:
> On Tue, 4 Jun 2013, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>> is there a way to flatten the rbd export-diff to a "new" image FILE. Or
>> do i always have to:
>>
>> rbd import "OLD BASE IMAGE"
>> rbd import-diff diff1
>> rbd import-diff diff1-2
>> rbd import-diff diff2-3
>> rbd import-diff diff3-4
>> rbd import-diff diff4-5
>> ...
>> and so on?
>>
>> I would like to apply the diffs on local disk and then import the new file.
>
> Not currently.  The format is very simple, though; it should be pretty
> simple to implement a subcommand in the rbd tool to do it.

Oh my C skills are more than limited ;-( i could do it in perl ;-) Is 
there a format description?

Stefan
