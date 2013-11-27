From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] rocksdb Seen today - replacement for leveldb?
Date: Wed, 27 Nov 2013 19:52:06 +0800
Message-ID: <CACJqLybC1n9ywRdrzG5cd2aWunJb5S2x9sLF_eEREJgu-hpOTg@mail.gmail.com>
References: <5295CF96.6040708@profihost.ag>
	<5295CFE2.8070603@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34594 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab3K0LwG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 06:52:06 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so10260449pbb.14
        for <ceph-devel@vger.kernel.org>; Wed, 27 Nov 2013 03:52:06 -0800 (PST)
In-Reply-To: <5295CFE2.8070603@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, we have related bp for rocksdb backend.
wiki.ceph.com/index.php?title=01Planning/02Blueprints/Firefly/osd:_new_key%2F%2Fvalue_backend

On Wed, Nov 27, 2013 at 6:56 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> the performance comparisions are very impressive:
>
> https://github.com/facebook/rocksdb/wiki/Performance-Benchmarks
>
> Stefan
>
> Am 27.11.2013 11:55, schrieb Stefan Priebe - Profihost AG:
>> Hi,
>>
>> while googles leveldb was too slow for facebook they created rocksdb
>> (http://rocksdb.org/) may be interesting for Ceph? It's already
>> production quality.
>>
>> Greets,
>> Stefan
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
