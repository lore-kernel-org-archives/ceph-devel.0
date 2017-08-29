From: zengran zhang <z13121369189@gmail.com>
Subject: Re: question on bluestore wal io behavior
Date: Tue, 29 Aug 2017 20:34:58 +0800
Message-ID: <CALi+v1-NDBFCjgfUdq8D+9Vp5ePR_4Xd8HFxCK1NK8b7eUtRZA@mail.gmail.com>
References: <CALi+v1-yrvT1Q_rTHN88s3aTHmVV8c51cxqKkNCxxbKM2bJDJA@mail.gmail.com>
 <alpine.DEB.2.11.1708281325130.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34269 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdH2Me7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 08:34:59 -0400
Received: by mail-io0-f194.google.com with SMTP id d81so2759983ioj.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 05:34:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708281325130.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

thanks, the result with `bluefs preextend wal files = true` is as follow:

bstore_kv_sync 31622 [000] 279011.804497: block:block_rq_issue: 8,112
WS 0 () 31744816 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279011.817726: block:block_rq_issue: 8,112
WS 0 () 31744824 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [008] 279011.896340: block:block_rq_issue: 8,112
WS 0 () 31744824 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [008] 279011.913248: block:block_rq_issue: 8,112
WS 0 () 31744832 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [008] 279011.922135: block:block_rq_issue: 8,112
WS 0 () 31744840 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [009] 279012.066157: block:block_rq_issue: 8,112
WS 0 () 31744840 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.091929: block:block_rq_issue: 8,112
WS 0 () 31744848 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.104784: block:block_rq_issue: 8,112
WS 0 () 31744848 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.119474: block:block_rq_issue: 8,112
WS 0 () 31744856 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.177620: block:block_rq_issue: 8,112
WS 0 () 31744864 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.189050: block:block_rq_issue: 8,112
WS 0 () 31744864 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.222644: block:block_rq_issue: 8,112
WS 0 () 31744872 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.390916: block:block_rq_issue: 8,112
WS 0 () 31744880 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.405258: block:block_rq_issue: 8,112
WS 0 () 31744880 + 24 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.415339: block:block_rq_issue: 8,112
WS 0 () 31744896 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279012.477234: block:block_rq_issue: 8,112
WS 0 () 31744896 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [001] 279012.488351: block:block_rq_issue: 8,112
WS 0 () 31744904 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [002] 279012.519237: block:block_rq_issue: 8,112
WS 0 () 31744912 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [002] 279012.572239: block:block_rq_issue: 8,112
WS 0 () 31744912 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [002] 279012.588633: block:block_rq_issue: 8,112
WS 0 () 31744920 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [008] 279012.612379: block:block_rq_issue: 8,112
WS 0 () 31744928 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [008] 279012.966390: block:block_rq_issue: 8,112
WS 0 () 31744936 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [008] 279012.980747: block:block_rq_issue: 8,112
WS 0 () 31744936 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [001] 279012.990396: block:block_rq_issue: 8,112
WS 0 () 31744944 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [002] 279013.261043: block:block_rq_issue: 8,112
WS 0 () 31744952 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [002] 279013.272202: block:block_rq_issue: 8,112
WS 0 () 31744952 + 24 [bstore_kv_sync]
bstore_kv_sync 31622 [009] 279013.281706: block:block_rq_issue: 8,112
WS 0 () 31744968 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [009] 279013.342029: block:block_rq_issue: 8,112
WS 0 () 31744968 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [009] 279013.355062: block:block_rq_issue: 8,112
WS 0 () 31744976 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279013.375022: block:block_rq_issue: 8,112
WS 0 () 31744984 + 8 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279013.626828: block:block_rq_issue: 8,112
WS 0 () 31744984 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279013.647313: block:block_rq_issue: 8,112
WS 0 () 31744992 + 16 [bstore_kv_sync]
bstore_kv_sync 31622 [000] 279013.661472: block:block_rq_issue: 8,112
WS 0 () 31745000 + 8 [bstore_kv_sync]

2017-08-28 21:26 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Mon, 28 Aug 2017, zengran zhang wrote:
>> hi,
>>
>> we are testing bluestore and rocksdb, we observed that the wal block's
>> io is some odd... the iostate show that the wal block's `avgrq-sz` is
>> arountd 10, the perf record of the `block_rq_issue` captured as
>> follow:
>>
>> bstore_kv_sync 26357 [005] 177034.327414: block:block_rq_issue: 8,96
>> WS 0 () 53904888 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [006] 177034.348115: block:block_rq_issue: 8,96
>> WS 0 () 77472296 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [006] 177034.359633: block:block_rq_issue: 8,96
>> WS 0 () 53904888 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [003] 177034.364816: block:block_rq_issue: 8,96
>> WS 0 () 77472304 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [009] 177034.550656: block:block_rq_issue: 8,96
>> WS 0 () 53904896 + 80 [bstore_kv_sync]
>> bstore_kv_sync 26357 [009] 177034.556734: block:block_rq_issue: 8,96
>> WS 0 () 77472320 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [008] 177034.592900: block:block_rq_issue: 8,96
>> WS 0 () 53904968 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177034.598323: block:block_rq_issue: 8,96
>> WS 0 () 77472328 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [011] 177034.635053: block:block_rq_issue: 8,96
>> WS 0 () 53904976 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [012] 177034.640036: block:block_rq_issue: 8,96
>> WS 0 () 77472336 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [014] 177034.670053: block:block_rq_issue: 8,96
>> WS 0 () 53904976 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [015] 177034.681708: block:block_rq_issue: 8,96
>> WS 0 () 77472344 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [015] 177034.692890: block:block_rq_issue: 8,96
>> WS 0 () 53904976 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [015] 177034.698320: block:block_rq_issue: 8,96
>> WS 0 () 77472352 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [016] 177034.710399: block:block_rq_issue: 8,96
>> WS 0 () 53904984 + 32 [bstore_kv_sync]
>> bstore_kv_sync 26357 [016] 177034.740153: block:block_rq_issue: 8,96
>> WS 0 () 77472360 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [013] 177034.760271: block:block_rq_issue: 8,96
>> WS 0 () 53905008 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [015] 177034.931293: block:block_rq_issue: 8,96
>> WS 0 () 53905016 + 56 [bstore_kv_sync]
>> bstore_kv_sync 26357 [017] 177034.973679: block:block_rq_issue: 8,96
>> WS 0 () 77472376 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [018] 177035.001517: block:block_rq_issue: 8,96
>> WS 0 () 53905064 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [010] 177035.006956: block:block_rq_issue: 8,96
>> WS 0 () 77472384 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [019] 177035.018570: block:block_rq_issue: 8,96
>> WS 0 () 53905072 + 24 [bstore_kv_sync]
>> bstore_kv_sync 26357 [010] 177035.032255: block:block_rq_issue: 8,96
>> WS 0 () 77472392 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [012] 177035.157029: block:block_rq_issue: 8,96
>> WS 0 () 77472400 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [013] 177035.172142: block:block_rq_issue: 8,96
>> WS 0 () 53905096 + 48 [bstore_kv_sync]
>> bstore_kv_sync 26357 [014] 177035.182179: block:block_rq_issue: 8,96
>> WS 0 () 77472408 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [015] 177035.209644: block:block_rq_issue: 8,96
>> WS 0 () 53905136 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [016] 177035.215506: block:block_rq_issue: 8,96
>> WS 0 () 77472416 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [017] 177035.226028: block:block_rq_issue: 8,96
>> WS 0 () 53905144 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [018] 177035.232176: block:block_rq_issue: 8,96
>> WS 0 () 77472424 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177035.246060: block:block_rq_issue: 8,96
>> WS 0 () 53905144 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177035.257132: block:block_rq_issue: 8,96
>> WS 0 () 77472432 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177035.268880: block:block_rq_issue: 8,96
>> WS 0 () 53905144 + 24 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177035.344242: block:block_rq_issue: 8,96
>> WS 0 () 53905160 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177035.382172: block:block_rq_issue: 8,96
>> WS 0 () 77472448 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177035.393062: block:block_rq_issue: 8,96
>> WS 0 () 53905168 + 16 [bstore_kv_sync]
>> bstore_kv_sync 26357 [000] 177035.398896: block:block_rq_issue: 8,96
>> WS 0 () 77472456 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [017] 177035.420992: block:block_rq_issue: 8,96
>> WS 0 () 53905176 + 8 [bstore_kv_sync]
>> bstore_kv_sync 26357 [018] 177035.432239: block:block_rq_issue: 8,96
>> WS 0 () 77472464 + 8 [bstore_kv_sync]
>>
>> the io request on LBA 77xxx is always 8 sectors, and the the io
>> request on LBA 53xxx had some overlay areas...
>> my understand of the two sequent address (77xxx and 53xxx) is bluefs's
>> log and rocksdb'wal, why they alternate one by one so strictly...
>>
>> we think this behavior may hurt the performance, hope anyone who could
>> give an analysis, thanks so much!
>
> This should go away (the bluefs log) once the wal files have been written
> through once.  There is an experimental bluefs option
>
>  bluefs preextend wal files = true
>
> that will avoid this for the purposes of benchmarking, but do not use it
> on a production OSD because it is not fully crash safe.
>
> sage
