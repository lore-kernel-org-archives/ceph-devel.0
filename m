From: Ming Lin <minggr@gmail.com>
Subject: Re: code question: PGQueueable VS OpRequestRef
Date: Fri, 27 Jan 2017 10:26:43 -0800
Message-ID: <CAF1ivSZxHNO5SUD70_Q1Eex5tzzzuLoZZn5J9dmEoLVtDN_XyQ@mail.gmail.com>
References: <CAF1ivSYfmH9hezSc-Vcqdd7nU6y33TDZ1E9KVHm-XJRz+1w5dw@mail.gmail.com>
 <CACKY0b8kB3FsG-vfRDXuZW=eXUD8R+HyWUZ6dCbpuJaJno=mUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:34020 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdA0S0p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2017 13:26:45 -0500
Received: by mail-it0-f51.google.com with SMTP id k200so10728246itb.1
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2017 10:26:45 -0800 (PST)
In-Reply-To: <CACKY0b8kB3FsG-vfRDXuZW=eXUD8R+HyWUZ6dCbpuJaJno=mUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jan 27, 2017 at 3:33 AM, liuchang0812 <liuchang0812@gmail.com> wrote:
> Hi, Ming.
>
> PGQueueable class has a constructor as: `PGQueueable(OpRequestRef
> op)`, which does not have `explicit`, so CPP compiler translates
> OpRequestRef to PGQueueable in `
> osd->op_wq.queue(make_pair(PGRef(this), op));`, as `
> osd->op_wq.queue(make_pair(PGRef(this), PGQueueable(op)));`

Hi Chang,

Thanks for the explanation. I just verify it with below test code.

class Foo {

};

class Bar {
public:
        Bar(Foo f)
        {
                cout << "Bar constructor called" << endl;
        }
};

void test(Bar t)
{
}

int main()
{
        Foo f;

        test(f);

        return 0;
}

>
>
>
> 2017-01-27 15:41 GMT+08:00 Ming Lin <minggr@gmail.com>:
>> void PG::queue_op(OpRequestRef& op)
>> {
>> ...
>>   osd->op_wq.queue(make_pair(PGRef(this), op));
>>
>>
>> class OSDService {
>> ....
>>   ShardedThreadPool::ShardedWQ < pair <PGRef, PGQueueable> > &op_wq;
>>
>> "op" is of type OpRequestRef, but op_wq second is of type PGQueueable
>>
>> How does this work? Is "PGQueueable" same as "OpRequestRef"?
>>
>> Thanks.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
