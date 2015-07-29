From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Wed, 29 Jul 2015 12:49:30 -0500
Message-ID: <55B9122A.704@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com> <55B8D677.8040800@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <55B8D677.8040800@ieee.org>
Sender: target-devel-owner@vger.kernel.org
To: Alex Elder <elder@ieee.org>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 07/29/2015 08:34 AM, Alex Elder wrote:
> On 07/29/2015 04:23 AM, mchristi@redhat.com wrote:
>> From: Mike Christie <michaelc@cs.wisc.edu>
>>
>> LIO uses scatterlist for its page/data management. This patch
>> adds a scatterlist messenger data type, so LIO can pass its sg
>> down directly to rbd.
>>
>> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
> 
> I'm not going to be able to review all of these, and this
> isnt' even a complete review.  But it's something...

No problem. Thanks for any comments.

> 
> You're clearly on the right track, but I want to provide
> a meaningful review for correctness and design so I'm
> looking for a bit more information.
> 
>> ---
>>  include/linux/ceph/messenger.h  | 13 ++++++
>>  include/linux/ceph/osd_client.h | 12 +++++-
>>  net/ceph/messenger.c            | 96 +++++++++++++++++++++++++++++++++++++++++
>>  net/ceph/osd_client.c           | 26 +++++++++++
>>  4 files changed, 146 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
>> index 3775327..bc1bde8 100644
>> --- a/include/linux/ceph/messenger.h
>> +++ b/include/linux/ceph/messenger.h
>> @@ -79,6 +79,7 @@ enum ceph_msg_data_type {
>>  #ifdef CONFIG_BLOCK
>>  	CEPH_MSG_DATA_BIO,	/* data source/destination is a bio list */
>>  #endif /* CONFIG_BLOCK */
>> +	CEPH_MSG_DATA_SG,	/* data source/destination is a scatterlist */
>>  };
>>  
>>  static __inline__ bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
>> @@ -90,6 +91,7 @@ static __inline__ bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
>>  #ifdef CONFIG_BLOCK
>>  	case CEPH_MSG_DATA_BIO:
>>  #endif /* CONFIG_BLOCK */
>> +	case CEPH_MSG_DATA_SG:
>>  		return true;
>>  	default:
>>  		return false;
>> @@ -112,6 +114,11 @@ struct ceph_msg_data {
>>  			unsigned int	alignment;	/* first page */
>>  		};
>>  		struct ceph_pagelist	*pagelist;
>> +		struct {
>> +			struct scatterlist *sgl;
>> +			unsigned int	sgl_init_offset;
>> +			u64		sgl_length;
>> +		};
> 
> Can you supply a short explanation of what these fields
> represent?  It seems sgl_init_offset is the offset of the
> starting byte in the sgl, but is the purpose of that for
> page offset calculation, or does it represent an offset
> into the total length of the sgl?  Or put another way,
> does sgl_init_offset represent some portion of the
> sgl_length that has been consumed already (and so the
> initial ressidual length is sgl_length - sgl_init_offset)?


sgl - starting scatterlist entry we are going to send/receive to/from.

sgl_init_offset - byte offset in the sgl above we will start executing
from. It is for cases like where a LIO command crossed segment/object
boundaries, so we had to break it up, and the first obj request ended up
in the middle of a scatterlist entry. For the second obj request we set
the sgl to the sg we ended on in the first request, and then set the
sgl_init_offset to where we left off in the first request.

So it basically allows me to not have to clone the list similar to how
the bio code does it. However, if we did clone it then I could just
manipulate the cloned sg's sg->offset instead of adding the
sgl_init_offset field.

sgl_length - number of bytes in the sgl we are going to send/receive.
This also is for the case where we broke up the LIO command into
multiple obj requests.


> 
>>  	};
>>  };
>>  
>> @@ -139,6 +146,10 @@ struct ceph_msg_data_cursor {
>>  			struct page	*page;		/* page from list */
>>  			size_t		offset;		/* bytes from list */
>>  		};
>> +		struct {
>> +			struct scatterlist	*sg;		/* curr sg */
> 
> 							/* current sg */
> 
>> +			unsigned int		sg_consumed;
> 
> Here too, what does sg_consumed represent with respect to the
> initial offset and the length?

It the number of bytes in the sgl we have sent/received. It is used by
the messenger advance code to track if we need to advance to the next sg
or if we still have data left from the current one.
