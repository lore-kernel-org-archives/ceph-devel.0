From: Guang Yang <yguang11@outlook.com>
Subject: Re: bucket index sharding - IO throttle
Date: Wed, 30 Jul 2014 22:58:46 +0800
Message-ID: <BLU437-SMTP904C06D419679BD5A09056DFF90@phx.gbl>
References: <1963E3AE-B242-4896-904C-B0868F5AC569@outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s12.hotmail.com ([65.55.111.151]:64289 "EHLO
	BLU004-OMC4S12.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753483AbaG3O64 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jul 2014 10:58:56 -0400
In-Reply-To: <1963E3AE-B242-4896-904C-B0868F5AC569@outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

+ceph-devel.

Thanks,
Guang

On Jul 29, 2014, at 10:20 PM, Guang Yang <yguang11@outlook.com> wrote:

> Hi Yehuda,
> Per you review comment in terms of IO throttling for bucket index operation, I prototyped the below code (details still need to polish), can you take a look if that is right way to go?
> 
> Another problem I came across is that ClsBucketIndexOpCtx::handle_compeltion was not called for the bucket index init op (below), is there anything I missed obviously here?
> 
> Thanks,
> Guang
> 
> 
> class ClsBucketIndexAioThrottler {
> protected:
>  int completed;
>  int ret_code;
>  IoCtx& io_ctx;
>  Mutex lock;
>  struct LockCond {
>    Mutex lock;
>    Cond cond;
>    LockCond() : lock("LockCond"), cond() {}
>  } lock_cond;
> public:
>  ClsBucketIndexAioThrottler(IoCtx& _io_ctx)
>    : completed(0), ret_code(0), io_ctx(_io_ctx),
>    lock("ClsBucketIndexAioThrottler"), lock_cond() {}
> 
>  virtual ~ClsBucketIndexAioThrottler() {}
>  virtual void do_next() = 0;
>  virtual bool is_completed () = 0;
> 
>  void complete(int ret) {
>    {
>      Mutex::Locker l(lock);
>      if (ret < 0)
>        ret_code = ret;
>      ++completed;
>    }
> 
>    lock_cond.lock.Lock();
>    lock_cond.cond.Signal();
>    lock_cond.lock.Unlock();
>  }
> 
>  int get_ret_code () {
>    Mutex::Locker l(lock);
>    return ret_code;
>  }
> 
>  virtual int wait_completion() {
>    lock_cond.lock.Lock();
>    while (1) {
>      if (is_completed()) {
>        lock_cond.lock.Unlock();
>        return ret_code;
>      }
>      lock_cond.cond.Wait(lock_cond.lock);
>      lock_cond.lock.Lock();
>    }
>  }
> };
> 
> class ClsBucketIndexListAioThrottler : public ClsBucketIndexAioThrottler {
> protected:
>  vector<string> bucket_objects;
>  vector<string>::iterator iter_pos;
> public:
>  ClsBucketIndexListAioThrottler(IoCtx& _io_ctx, const vector<string> _bucket_objs)
>    : ClsBucketIndexAioThrottler(_io_ctx), bucket_objects(_bucket_objs),
>    iter_pos(bucket_objects.begin()) {}
> 
>  virtual bool is_completed() {
>    Mutex::Locker l(lock);
>    int sent = 0;
>    vector<string>::iterator iter = bucket_objects.begin();
>    for (; iter != iter_pos; ++iter) ++sent;
> 
>    return (sent == completed &&
>        (iter_pos == bucket_objects.end() /*Success*/ || ret_code < 0 /*Failure*/));
>  }
> };
> 
> template<typename T>
> class ClsBucketIndexOpCtx : public ObjectOperationCompletion {
> private:
>  T* data;
>  // Return code of the operation
>  int* ret_code;
> 
>  // The Aio completion object associated with this Op, it should
>  // be release from within the completion handler
>  librados::AioCompletion* completion;
>  ClsBucketIndexAioThrottler* throttler;
> public:
>  ClsBucketIndexOpCtx(T* _data, int* _ret_code, librados::AioCompletion* _completion,
>          ClsBucketIndexAioThrottler* _throttler)
>    : data(_data), ret_code(_ret_code), completion(_completion), throttler(_throttler) {}
>  ~ClsBucketIndexOpCtx() {}
> 
>  // The completion callback, fill the response data
>  void handle_completion(int r, bufferlist& outbl) {
>    if (r >= 0) {
>      if (data) {
>        try {
>          bufferlist::iterator iter = outbl.begin();
>          ::decode((*data), iter);
>        } catch (buffer::error& err) {
>          r = -EIO;
>        }
>      }
>      // Do the next request
>    }
>    throttler->do_next();
>    throttler->complete(r);
>    if (completion) {
>      completion->release();
>    }
>  }
> };
> 
> 
> class ClsBucketIndexInitAioThrottler : public ClsBucketIndexListAioThrottler {
> public:
>  ClsBucketIndexInitAioThrottler(IoCtx& _io_ctx, const vector<string> _bucket_objs) :
>    ClsBucketIndexListAioThrottler(_io_ctx, _bucket_objs) {}
> 
>  virtual void do_next() {
>    string oid;
>    {
>      Mutex::Locker l(lock);
>      if (iter_pos == bucket_objects.end())
>        return;
>      oid = *(iter_pos++);
>    }
>    AioCompletion* c = librados::Rados::aio_create_completion(NULL, NULL, NULL);
>    // Dummy
>    bufferlist in;
>    librados::ObjectWriteOperation op;
>    op.create(true);
>    op.exec("rgw", "bucket_init_index", in, new ClsBucketIndexOpCtx<int>(NULL, NULL, c, this));
>    io_ctx.aio_operate(oid, c, &op, NULL); 
>  }
> };
> 
> 
> int cls_rgw_bucket_index_init_op(librados::IoCtx &io_ctx,
>        const vector<string>& bucket_objs, uint32_t max_aio)
> {
>   vector<string>::const_iterator iter = bucket_objs.begin();
>   bufferlist in;
>   ClsBucketIndexAioThrottler* throttler = new ClsBucketIndexInitAioThrottler(io_ctx, bucket_objs);
>   for (; iter != bucket_objs.end() && max_aio-- > 0; ++iter) {
>       throttler->do_next();
>   }
>   throttler->wait_completion();
>   return 0;
> }
> 
> 

