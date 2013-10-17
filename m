From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Efficiently scan all objects in a rados pool/namespace
Date: Thu, 17 Oct 2013 13:06:57 +0800
Message-ID: <CAMm-wcKTNcErY14kHdLpKmRsVffT=i5qjbOUZHTehE__NEfPaQ@mail.gmail.com>
References: <loom.20131016T060803-617@post.gmane.org>
	<alpine.DEB.2.00.1310160849360.29488@cobra.newdream.net>
	<loom.20131017T062448-736@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59010 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab3JQFG6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Oct 2013 01:06:58 -0400
Received: by mail-wg0-f44.google.com with SMTP id n12so1685703wgh.23
        for <ceph-devel@vger.kernel.org>; Wed, 16 Oct 2013 22:06:57 -0700 (PDT)
In-Reply-To: <loom.20131017T062448-736@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit Tiwary <tiwaryamt@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 17 October 2013 12:25, Amit Tiwary <tiwaryamt@gmail.com> wrote:
> Sage Weil <sage <at> inktank.com> writes:
>
>>
>> On Wed, 16 Oct 2013, Amit Tiwary wrote:
>> > We are using ceph version 0.56.6, librados C++ APIs and have more than
> 750
>> > million objects in a single pool. Objects are named as "domain-
> name_file-
>> > name".
>> >
>> > We are unable to ascertain in what order objects are listed with the
> command
>> > "rados -p poolname ls". They are neither ordered on objectname, nor size
> or
>> > mtime.
>> >
>> > Q1) Is there any way we can control the way objects are scanned/listed
> in a
>> > pool with the below librados c++ code? We are interested in getting list
> of
>> > objects sorted or grouped by object name
>> >     librados::ObjectIterator it = ioctx.objects_begin();
>> >     for (; it != ioctx.objects_end(); ++it)
>> >         ...
>>
>> They are ordered by hash(object name).
>>
>> > Q2) In near future, if we upgrade and make use of namespaces (i.e make
>> > domain-name as namespace and store all objects of a particular domain in
> that
>> > namespace); would scanning of objects in a namespace be efficient than
>> > current scenario where we have to scan the entire pool to fetch all
> objects?
>>
>> The namespaces do not improve object listing efficiency; it is still
>> O(size of the pool).
>>
>> > Q3) Do you any other recommendations on top of your mind that can
> improve
>> > time required to scan all objects of pool/namespace?
>>
>> If you need efficient queries by name prefix (or whatever else) you need
>> to maintain some sort of seperate index.  Radosgw does this for the S3
>> interface by using key/value objects for each bucket.  The kvstore class
>> implements a btree on top of such objects to provide improved scalability.
>>
>> Hope that helps!
>> sage
>
>
> Thanks Yuan and Sage. I feel namespace level stats would definitely be a
> good thing to have in future releases.
>
> I have been lately following threads regarding optimal number of pools and I
> understand that increasing the number of pools increases memory footprint
> and can become a bottleneck.
> Does number of objects or amount of data in each pool (i.e if number of
> objects or data is highly skewed in different pools) has any impact on
> performance of ceph.

In my opinion , there is no impact.

By default crush map, the pool distributes over all osds..


>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
