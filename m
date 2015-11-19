From: Samuel Just <sjust@redhat.com>
Subject: Re: OSD memory usage during startup - advice needed
Date: Thu, 19 Nov 2015 14:26:24 -0800
Message-ID: <CAN=+7FVRGm7Dh6uiL5G-giD32vw8XVP16bpi_8qgCJ+iC38atA@mail.gmail.com>
References: <564E11ED.7080001@beyond.pl>
	<564E316A.8050601@beyond.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37448 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbbKSW0Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 17:26:25 -0500
Received: by igcto18 with SMTP id to18so74573989igc.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 14:26:24 -0800 (PST)
In-Reply-To: <564E316A.8050601@beyond.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Marcin_Gibu=C5=82a?= <m.gibula@beyond.pl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Actually, looks like Xiaoxi beat you to it for infernalis!
42a3ab95ec459042e92198fb061c8393146bd1b4
-Sam

On Thu, Nov 19, 2015 at 12:30 PM, Marcin Gibu=C5=82a <m.gibula@beyond.p=
l> wrote:
>> Judging from debug output, the problem is in journal recovery, when =
it
>> tries to delete object with huge (several milion keys - it is radosg=
w
>> index* for bucket with over 50mln objects) amount of keys, using
>> leveldb's rmkeys_by_prefix() method.
>>
>> Looking at the source code, rmkeys_by_prefix() batches all operation=
s
>> into one list and then submit_transaction() executes them all atomic=
ally.
>>
>> I'd love to write a patch for this issue, but it seems unfixable (or=
 is
>> it?) with current API and method behaviour. Could you offer any advi=
ce
>> on how to proceed?
>
>
> Answering myself, could anyone verify if attached patch looks ok? Sho=
uld
> reduce memory footprint a bit.
>
> When I first read this code, I assumed that data pointed by leveldb::=
Slice
> have to be reachable until db->Write is called.
>
> However, looking into leveldb and into its source code, there is no s=
uch
> requirement - leveldb makes its own copy of key, so we're effectivly
> doubling memory footprint for no reason.
>
> --
> mg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
