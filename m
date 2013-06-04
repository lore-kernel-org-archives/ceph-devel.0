From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: flatten rbd export / export-diff ?
Date: Tue, 04 Jun 2013 11:13:59 -0700
Message-ID: <51AE2E67.1070909@inktank.com>
References: <51ADEE2B.4050403@profihost.ag> <alpine.DEB.2.00.1306040821550.12900@cobra.newdream.net> <51AE2C24.6060200@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62172 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab3FDSOL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 14:14:11 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so605404pdi.25
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jun 2013 11:14:10 -0700 (PDT)
In-Reply-To: <51AE2C24.6060200@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/04/2013 11:04 AM, Stefan Priebe wrote:
> Am 04.06.2013 17:23, schrieb Sage Weil:
>> On Tue, 4 Jun 2013, Stefan Priebe - Profihost AG wrote:
>>> Hi,
>>>
>>> is there a way to flatten the rbd export-diff to a "new" image FILE. Or
>>> do i always have to:
>>>
>>> rbd import "OLD BASE IMAGE"
>>> rbd import-diff diff1
>>> rbd import-diff diff1-2
>>> rbd import-diff diff2-3
>>> rbd import-diff diff3-4
>>> rbd import-diff diff4-5
>>> ...
>>> and so on?
>>>
>>> I would like to apply the diffs on local disk and then import the new
>>> file.
>>
>> Not currently.  The format is very simple, though; it should be pretty
>> simple to implement a subcommand in the rbd tool to do it.
>
> Oh my C skills are more than limited ;-( i could do it in perl ;-) Is
> there a format description?

Yeah, it should be pretty easy to decode in any language:

http://ceph.com/docs/master/dev/rbd-diff/

You could also use the python or C bindings for librbd's diff_iterate to
create a different format if you wanted.

Josh
