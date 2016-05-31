From: Haomai Wang <haomai@xsky.com>
Subject: Re: RocksDB Incorrect API Usage
Date: Wed, 1 Jun 2016 01:47:46 +0800
Message-ID: <CACJqLyb-8QbTM6U_MDGctTQSgeyZpv75MS_fzALTXWQHkjZnUQ@mail.gmail.com>
References: <CACJqLyYtHkeQ+jSNi7JPJzRb6wfCcNAuCSr_YyTwdqA_kzzP_g@mail.gmail.com>
	<20160531171729.GC20357@predictor>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0138.outbound.protection.outlook.com ([104.47.126.138]:13435
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755968AbcEaRr7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 13:47:59 -0400
Received: by mail-vk0-f45.google.com with SMTP id c189so271245653vkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 10:47:54 -0700 (PDT)
In-Reply-To: <20160531171729.GC20357@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <branch@predictor.org.pl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 1, 2016 at 1:17 AM, Piotr Da=C5=82ek <branch@predictor.org.=
pl> wrote:
> On Wed, Jun 01, 2016 at 12:49:53AM +0800, Haomai Wang wrote:
>> Hi Sage and Mark,
>>
>> As mentioned in BlueStore standup, I found rocksdb iterator *Seek*
>> won't use bloom filter like *Get*.
>>
>> *Get* impl: it will look at filter firstly
>> https://github.com/facebook/rocksdb/blob/master/table/block_based_ta=
ble_reader.cc#L1369
>>
>> Iterator *Seek*: it will do binary search, by default we don't speci=
fy
>> prefix feature(https://github.com/facebook/rocksdb/wiki/Prefix-Seek-=
API-Changes).
>> https://github.com/facebook/rocksdb/blob/master/table/block.cc#L94
>>
>> [..]
>> --- a/db/db_bench.cc
>> +++ b/db/db_bench.cc
>> @@ -2923,14 +2923,12 @@ class Benchmark {
>>          int64_t key_rand =3D thread->rand.Next() & (pot - 1);
>>          GenerateKeyFromInt(key_rand, FLAGS_num, &key);
>>          ++read;
>> -        auto status =3D db->Get(options, key, &value);
>> -        if (status.ok()) {
>> -          ++found;
>> -        } else if (!status.IsNotFound()) {
>> -          fprintf(stderr, "Get returned an error: %s\n",
>> -                  status.ToString().c_str());
>> -          abort();
>> -        }
>> +        Iterator* iter =3D db->NewIterator(options);
>> +      iter->Seek(key);
>> +      if (iter->Valid() && iter->key().compare(key) =3D=3D 0) {
>> +        found++;
>> +      }
>> +
>>          if (key_rand >=3D FLAGS_num) {
>>            ++nonexist;
>>          }
>
> Aren't you missing "delete iter" here?

oh, sure. I retest this, now it's 20us/op. Much better :-). 20 vs 4.

And actually this test set is seq int key and the value is small, it
will be make the gap not so much. Consider the binary search vs bloom
filter, I think the latency is huge. We shouldn't use any iterate
except we ensure it's a continuous key set.

>
> --
> Piotr Da=C5=82ek
> branch@predictor.org.pl
> http://blog.predictor.org.pl
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
