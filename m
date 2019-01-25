From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH net-next] libceph, ceph: use struct_size() in kmalloc()
Date: Thu, 24 Jan 2019 21:50:24 -0600
Message-ID: <daf3595f-c1fc-7964-3543-74529e9f6067@embeddedor.com>
References: <20190115194153.GA9565@embeddedor>
 <CAOi1vP_yWH2mhquFObC6VnUzNTzc7PX7tqA3RP=ci71BMm-gqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_yWH2mhquFObC6VnUzNTzc7PX7tqA3RP=ci71BMm-gqA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



On 1/17/19 8:17 AM, Ilya Dryomov wrote:
> On Tue, Jan 15, 2019 at 8:41 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> One of the more common cases of allocation size calculations is finding
>> the size of a structure that has a zero-sized array at the end, along
>> with memory for some number of elements for that array. For example:
>>
>> struct foo {
>>     int stuff;
>>     struct boo entry[];
>> };
>>
>> instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can
>> now use the new struct_size() helper:
>>
>> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  net/ceph/osdmap.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 98c0ff3d6441..48a31dc9161c 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -495,9 +495,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>>                           / sizeof(struct crush_rule_step))
>>                         goto bad;
>>  #endif
>> -               r = c->rules[i] = kmalloc(sizeof(*r) +
>> -                                         yes*sizeof(struct crush_rule_step),
>> -                                         GFP_NOFS);
>> +               r = kmalloc(struct_size(r, steps, yes), GFP_NOFS);
>> +               c->rules[i] = r;
>>                 if (r == NULL)
>>                         goto badmem;
>>                 dout(" rule %d is at %p\n", i, r);
> 
> Applied.
> 

Thanks, Ilya.

--
Gustavo
