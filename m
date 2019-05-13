From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 4/5] ceph: fix improper use of smp_mb__before_atomic()
Date: Mon, 13 May 2019 21:04:10 +0800
Message-ID: <6956e700-ef56-7f20-4e6c-3ad86c9fd89e@redhat.com>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-5-git-send-email-andrea.parri@amarulasolutions.com>
 <20190430082332.GB2677@hirez.programming.kicks-ass.net>
 <CAAM7YA=YOM79GJK8b7OOQbzT_-sYRD2UFHYithY7Li1yQt5Hog@mail.gmail.com>
 <20190509205452.GA4359@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509205452.GA4359@andrea>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>, "Yan, Zheng" <ukernel@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: ceph-devel.vger.kernel.org

On 5/10/19 4:55 AM, Andrea Parri wrote:
> On Tue, Apr 30, 2019 at 05:08:43PM +0800, Yan, Zheng wrote:
>> On Tue, Apr 30, 2019 at 4:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Mon, Apr 29, 2019 at 10:15:00PM +0200, Andrea Parri wrote:
>>>> This barrier only applies to the read-modify-write operations; in
>>>> particular, it does not apply to the atomic64_set() primitive.
>>>>
>>>> Replace the barrier with an smp_mb().
>>>>
>>>
>>>> @@ -541,7 +541,7 @@ static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
>>>>                                           long long release_count,
>>>>                                           long long ordered_count)
>>>>   {
>>>> -     smp_mb__before_atomic();
>>>
>>> same
>>>          /*
>>>           * XXX: the comment that explain this barrier goes here.
>>>           */
>>>
>>
>> makes sure operations that setup readdir cache (update page cache and
>> i_size) are strongly ordered with following atomic64_set.
> 
> Thanks for the suggestion, Yan.
> 
> To be clear: would you like me to integrate your comment and resend?
> any other suggestions?
> 

Yes, please

Regards
Yan, Zheng

> Thanx,
>    Andrea
> 
> 
>>
>>>> +     smp_mb();
>>>
>>>>        atomic64_set(&ci->i_complete_seq[0], release_count);
>>>>        atomic64_set(&ci->i_complete_seq[1], ordered_count);
>>>>   }
>>>> --
>>>> 2.7.4
>>>>
