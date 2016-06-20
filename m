From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: zero length write fro store_test to bluestore
Date: Mon, 20 Jun 2016 16:57:26 +0300
Message-ID: <37e7147d-cda6-f17e-0a51-36f8cf205976@mirantis.com>
References: <e175ac33-0398-2154-6edd-6ee932509c8c@mirantis.com>
 <alpine.DEB.2.11.1606201354350.21827@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36134 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbcFTOFD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 10:05:03 -0400
Received: by mail-lf0-f51.google.com with SMTP id q132so38369096lfe.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2016 07:05:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606201354350.21827@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 20.06.2016 16:55, Sage Weil wrote:
> On Mon, 20 Jun 2016, Igor Fedotov wrote:
>> Hi All,
>>
>> I'm hitting the following issue while running Synthetic test case (from
>> store_test.cc) against bluestore:
>>
>> store_test asserts on read data mismatch when read happens after the
>> zero-length write above object boundary.
>>
>> Test case assumes all the data between the old and new object boundaries are
>> filled with zeros. But current bluestore write path implementation simply
>> discards zero-length writes and hence doesn't raise object size. As a result
>> subsequent read doesn't return anything above the old boundary.
>>
>> The question is what's the proper fix for that:
>>
>> 1) Ignore zero-length writes in the test case and do not increase object
>> size/fill content on them.
>>
>> or
>>
>> 2) Increase object content size on such writes in the bluestore.
> Heh, I just hit this too.  I think it makes more sense for 0
> length writes to not affect object size.  I added a test for it
> and fixed Memstore.  store_test.cc needs to be adjusted still though...
>
> Pushed patches to top of wip-bluestore-2q, do you mind pulling those 2 out
> and fixing store_test in another PR?
OK, will do.
>
> Thanks!
> sage
>

