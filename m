From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [RFC PATCH] ceph: do not direct write executes in parallel if
 O_APPEND is set
Date: Mon, 3 Feb 2020 17:14:10 +0800
Message-ID: <4956fdbe-605e-7bdb-93f5-7d28fe61568d@redhat.com>
References: <20200131133619.14209-1-xiubli@redhat.com>
 <20200203083646.GB5005@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47274 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbgBCJOX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2020 04:14:23 -0500
In-Reply-To: <20200203083646.GB5005@infradead.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/3 16:36, Christoph Hellwig wrote:
> On Fri, Jan 31, 2020 at 08:36:19AM -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> In O_APPEND & O_DIRECT mode, the data from different writers will
>> be possiblly overlapping each other. Just use the exclusive clock
>> instead in O_APPEND & O_DIRECT mode.
> s/clock/lock/
>
Will fix it :-)

Thanks.

BRs
