From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw-admin: symbol lookup error
Date: Mon, 21 Jul 2014 17:15:10 -0700
Message-ID: <CABBk=J_o8=r_H0UaRSkhtZodmtmrqtFfXUtQ7HEgZOOKGPQ-Gw@mail.gmail.com>
References: <53CD1B3A.7060008@gmail.com>
	<53CDAA37.90209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:48300 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaGVAPL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jul 2014 20:15:11 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so13688237vcb.18
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jul 2014 17:15:10 -0700 (PDT)
In-Reply-To: <53CDAA37.90209@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bhubbard@redhat.com, =?UTF-8?B?6LW15Lit5Lqu?= <zhaozhongliang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 21, 2014 at 5:03 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> On 07/21/2014 11:52 PM, Zhongliang Zhao wrote:
>>
>> Dear all,
>>
>> I am trying to test the feature of geo-replication, which is suported
>> via radosgw service.
>> After following
>>
>> http://ceph.com/docs/master/radosgw/config/#adjust-path-ownership-permissions,
>>
>> $sudo /etc/init.d/radosgw start (start the gateway)
>> returns
>> $Starting client.radosgw.instance-1...
>> $/usr/bin/radosgw is running
>>
>> However, when I want to use the radosgw-admin command, it gives error
>> like:
>>
>> radosgw-admin: symbol lookup error: radosgw-admin: undefined symbol:
>> _ZTVN4ceph6crypto8HMACSHA1E
>
>
> Looks like it is missing a definition for a crypto function.
>
> $ c++filt  _ZTVN4ceph6crypto8HMACSHA1E
> vtable for ceph::crypto::HMACSHA1


That would usually mean that it couldn't find librados. Try running
'ldd radosgw-admin' to verify linkage target, and adjust
LD_LIBRARY_PATH appropriately.

Yehuda
