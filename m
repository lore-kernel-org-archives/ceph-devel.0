From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: bucket index sharding - IO throttle
Date: Wed, 30 Jul 2014 10:00:18 -0700
Message-ID: <CABBk=J9H+ncDjp6ABVmraaPOx5x5ubvfn2vb3UK6y3R=B=zLBQ@mail.gmail.com>
References: <1963E3AE-B242-4896-904C-B0868F5AC569@outlook.com>
	<BLU437-SMTP904C06D419679BD5A09056DFF90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43744 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbaG3RAT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 13:00:19 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so1910696iec.33
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jul 2014 10:00:19 -0700 (PDT)
In-Reply-To: <BLU437-SMTP904C06D419679BD5A09056DFF90@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Can you send this code through a github pull request (or at least as a
patch)? It'lll be easier to review and comment.

Thanks,
Yehuda

On Wed, Jul 30, 2014 at 7:58 AM, Guang Yang <yguang11@outlook.com> wrote:
> +ceph-devel.
>
> Thanks,
> Guang
>
> On Jul 29, 2014, at 10:20 PM, Guang Yang <yguang11@outlook.com> wrote:
>
>> Hi Yehuda,
>> Per you review comment in terms of IO throttling for bucket index operation, I prototyped the below code (details still need to polish), can you take a look if that is right way to go?
>>
>> Another problem I came across is that ClsBucketIndexOpCtx::handle_compeltion was not called for the bucket index init op (below), is there anything I missed obviously here?
>>
>> Thanks,
>> Guang
>>
>>
>> class ClsBucketIndexAioThrottler {
>> protected:
>>  int completed;
>>  int ret_code;
>>  IoCtx& io_ctx;
>>  Mutex lock;
>>  struct LockCond {
>>    Mutex lock;
>>    Cond cond;
>>    LockCond() : lock("LockCond"), cond() {}
>>  } lock_cond;
>> public:
>>  ClsBucketIndexAioThrottler(IoCtx& _io_ctx)
>>    : completed(0), ret_code(0), io_ctx(_io_ctx),
>>    lock("ClsBucketIndexAioThrottler"), lock_cond() {}
>>
>>  virtual ~ClsBucketIndexAioThrottler() {}
>>  virtual void do_next() = 0;
>>  virtual bool is_completed () = 0;
>>
>>  void complete(int ret) {
>>    {
>>      Mutex::Locker l(lock);
>>      if (ret < 0)
>>        ret_code = ret;
>>      ++completed;
>>    }
>>
>>    lock_cond.lock.Lock();
>>    lock_cond.cond.Signal();
>>    lock_cond.lock.Unlock();
>>  }
>>
>>  int get_ret_code () {
>>    Mutex::Locker l(lock);
>>    return ret_code;
>>  }
>>
>>  virtual int wait_completion() {
>>    lock_cond.lock.Lock();
>>    while (1) {
>>      if (is_completed()) {
>>        lock_cond.lock.Unlock();
>>        return ret_code;
>>      }
>>      lock_cond.cond.Wait(lock_cond.lock);
>>      lock_cond.lock.Lock();
>>    }
>>  }
>> };
>>
>> class ClsBucketIndexListAioThrottler : public ClsBucketIndexAioThrottler {
>> protected:
>>  vector<string> bucket_objects;
>>  vector<string>::iterator iter_pos;
>> public:
>>  ClsBucketIndexListAioThrottler(IoCtx& _io_ctx, const vector<string> _bucket_objs)
>>    : ClsBucketIndexAioThrottler(_io_ctx), bucket_objects(_bucket_objs),
>>    iter_pos(bucket_objects.begin()) {}
>>
>>  virtual bool is_completed() {
>>    Mutex::Locker l(lock);
>>    int sent = 0;
>>    vector<string>::iterator iter = bucket_objects.begin();
>>    for (; iter != iter_pos; ++iter) ++sent;
>>
>>    return (sent == completed &&
>>        (iter_pos == bucket_objects.end() /*Success*/ || ret_code < 0 /*Failure*/));
>>  }
>> };
>>
>> template<typename T>
>> class ClsBucketIndexOpCtx : public ObjectOperationCompletion {
>> private:
>>  T* data;
>>  // Return code of the operation
>>  int* ret_code;
>>
>>  // The Aio completion object associated with this Op, it should
>>  // be release from within the completion handler
>>  librados::AioCompletion* completion;
>>  ClsBucketIndexAioThrottler* throttler;
>> public:
>>  ClsBucketIndexOpCtx(T* _data, int* _ret_code, librados::AioCompletion* _completion,
>>          ClsBucketIndexAioThrottler* _throttler)
>>    : data(_data), ret_code(_ret_code), completion(_completion), throttler(_throttler) {}
>>  ~ClsBucketIndexOpCtx() {}
>>
>>  // The completion callback, fill the response data
>>  void handle_completion(int r, bufferlist& outbl) {
>>    if (r >= 0) {
>>      if (data) {
>>        try {
>>          bufferlist::iterator iter = outbl.begin();
>>          ::decode((*data), iter);
>>        } catch (buffer::error& err) {
>>          r = -EIO;
>>        }
>>      }
>>      // Do the next request
>>    }
>>    throttler->do_next();
>>    throttler->complete(r);
>>    if (completion) {
>>      completion->release();
>>    }
>>  }
>> };
>>
>>
>> class ClsBucketIndexInitAioThrottler : public ClsBucketIndexListAioThrottler {
>> public:
>>  ClsBucketIndexInitAioThrottler(IoCtx& _io_ctx, const vector<string> _bucket_objs) :
>>    ClsBucketIndexListAioThrottler(_io_ctx, _bucket_objs) {}
>>
>>  virtual void do_next() {
>>    string oid;
>>    {
>>      Mutex::Locker l(lock);
>>      if (iter_pos == bucket_objects.end())
>>        return;
>>      oid = *(iter_pos++);
>>    }
>>    AioCompletion* c = librados::Rados::aio_create_completion(NULL, NULL, NULL);
>>    // Dummy
>>    bufferlist in;
>>    librados::ObjectWriteOperation op;
>>    op.create(true);
>>    op.exec("rgw", "bucket_init_index", in, new ClsBucketIndexOpCtx<int>(NULL, NULL, c, this));
>>    io_ctx.aio_operate(oid, c, &op, NULL);
>>  }
>> };
>>
>>
>> int cls_rgw_bucket_index_init_op(librados::IoCtx &io_ctx,
>>        const vector<string>& bucket_objs, uint32_t max_aio)
>> {
>>   vector<string>::const_iterator iter = bucket_objs.begin();
>>   bufferlist in;
>>   ClsBucketIndexAioThrottler* throttler = new ClsBucketIndexInitAioThrottler(io_ctx, bucket_objs);
>>   for (; iter != bucket_objs.end() && max_aio-- > 0; ++iter) {
>>       throttler->do_next();
>>   }
>>   throttler->wait_completion();
>>   return 0;
>> }
>>
>>
>
