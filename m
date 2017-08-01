From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Re: Mon stats in luminous rc
Date: Tue, 1 Aug 2017 14:37:04 +0000
Message-ID: <D5A5DF8F.94AFE%travis.nielsen@quantum.com>
References: <D5A4AD67.949E8%travis.nielsen@quantum.com>
 <alpine.DEB.2.11.1708010304040.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:62176
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751352AbdHAOhJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 1 Aug 2017 10:37:09 -0400
In-Reply-To: <alpine.DEB.2.11.1708010304040.20435@piezo.novalocal>
Content-Language: en-US
Content-ID: <D2F5462B2B35B14999393CBE56132766@namprd14.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks Sage, I don't see the real need for them either, just wanted to
make sure we didn't miss them in our metrics instrumentation in case they
moved somewhere else.



On 7/31/17, 8:05 PM, "Sage Weil" <sage@newdream.net> wrote:

>On Mon, 31 Jul 2017, Travis Nielsen wrote:
>> The ceph status -f json command has changed quite a bit in luminous RC.
>>I
>> see the following expected change with the health messages.
>>=20
>>https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub=
.c
>>om%2Fceph%2Fceph%2Fpull%2F15643&data=3D02%7C01%7Ctravis.nielsen%40quantum=
.c
>>om%7C23b34577f0a74acce5aa08d4d88a2470%7C322a135f14fb4d72aede122272134ae0%
>>7C1%7C0%7C636371535223952708&sdata=3DM8uEQQFUFq6CjfkHpwsYcpVIxyqABubbDfBR=
eF
>>aj%2FjY%3D&reserved=3D0
>>=20
>> And in the pending release notes there is a new command for
>> time-sync-status.
>>=20
>> However, I can't find what happened with the mon stats in the
>> health_services section. Where can I find them? In 12.1.0 they were
>>there,
>> but not seeing them now in 12.1.1.
>>=20
>> $ ceph health -f json| jq
>> {
>>   "health": {
>>     "health_services": [
>>       {
>>         "mons": [
>>           {
>>             "name": "mon0",
>>             "kb_total": 16888216,
>>             "kb_used": 2345480,
>>             "kb_avail": 13553604,
>>             "avail_percent": 80,
>>             "last_updated": "2017-07-31 15:43:49.107186",
>>             "store_stats": {
>>               "bytes_total": 1486739,
>>               "bytes_sst": 1504,
>>               "bytes_log": 1476780,
>>               "bytes_misc": 8455,
>>               "last_updated": "0.000000"
>>             },
>>             "health": "HEALTH_OK"
>>           },
>
>Ah, these are just gone... I didn't expect anyone to be consuming
>them.  We can add a mon-store-status or similar command to include this
>information if you need it.
>
>sage

