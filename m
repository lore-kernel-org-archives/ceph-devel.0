From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: fix memory leak when reallocating pages array for
 writepages
Date: Mon, 27 Jul 2020 21:44:02 +0800
Message-ID: <96aa56d1-ce71-27b4-67c1-32da656fd329@redhat.com>
References: <20200726122804.16008-1-jlayton@kernel.org>
 <3c8fb2aa-834b-a202-24b4-7eb29cd9b7c3@redhat.com>
 <ff6497016429a0ba962d97d6997427a5020ac6d4.camel@kernel.org>
 <f1265009-9d5c-4685-8ecf-8e06e7500baa@redhat.com>
 <b9c88da029462acd45dea1035e5be3c4f40463d0.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728169AbgG0NoP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jul 2020 09:44:15 -0400
In-Reply-To: <b9c88da029462acd45dea1035e5be3c4f40463d0.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org

On 2020/7/27 21:35, Jeff Layton wrote:
> On Mon, 2020-07-27 at 21:27 +0800, Xiubo Li wrote:
>> On 2020/7/27 21:18, Jeff Layton wrote:
>>> On Mon, 2020-07-27 at 20:16 +0800, Xiubo Li wrote:
>>>> On 2020/7/26 20:28, Jeff Layton wrote:
>>>>> Once we've replaced it, we don't want to keep the old one around
>>>>> anymore.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>>     fs/ceph/addr.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>>>>> index 01ad09733ac7..01e167efa104 100644
>>>>> --- a/fs/ceph/addr.c
>>>>> +++ b/fs/ceph/addr.c
>>>>> @@ -1212,6 +1212,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>>>>>     			       locked_pages * sizeof(*pages));
>>>>>     			memset(data_pages + i, 0,
>>>>>     			       locked_pages * sizeof(*pages));
>>>> BTW， do we still need to memset() the data_pages ?
>>>>
>>> Self-NAK on this patch...
>>>
>>> Zheng pointed out that this array is actually freed by the request
>>> handler after the submission. This loop is creating a new pages array
>>> for a second request.
>> Do you mean ceph_osd_data_release() ?
>>
>> The request is only freeing the pages in that arrary, not the arrary
>> itself, did I miss something ?
>>
>>
> No, I meant in writepages_finish(). It has this:
>
>          if (osd_data->pages_from_pool)
>                  mempool_free(osd_data->pages,
>                               ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
>          else
>                  kfree(osd_data->pages);
>
> The pages themselves are freed in the loop above that point however.

Okay, that's right.

Thanks.


>>> As far as whether we need to memset the end of the original array...I
>>> don't think we do. It looks like the pointers at the end of the array
>>> are ignored once you go past the length of the request. That said, it's
>>> fairly cheap to do so, and I'm not inclined to change it, just in case
>>> there is code that does look at those pointers.
>>>
>>>>> +			kfree(data_pages);
>>>>>     		} else {
>>>>>     			BUG_ON(num_ops != req->r_num_ops);
>>>>>     			index = pages[i - 1]->index + 1;
