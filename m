From: Osier Yang <osier@yunify.com>
Subject: Re: bucket index sharding - IO throttle
Date: Wed, 06 Aug 2014 12:38:01 +0800
Message-ID: <53E1B129.4060006@yunify.com>
References: <1963E3AE-B242-4896-904C-B0868F5AC569@outlook.com> <BLU437-SMTP904C06D419679BD5A09056DFF90@phx.gbl> <CABBk=J9H+ncDjp6ABVmraaPOx5x5ubvfn2vb3UK6y3R=B=zLBQ@mail.gmail.com> <BLU436-SMTP258261DA4CD49AE6829E5A9DFE60@phx.gbl> <BLU436-SMTP530E3373FB99617E291C2ADFE20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m50-211.qiye.163.com ([123.125.50.211]:47173 "EHLO
	m50-211.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbaHFExo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Aug 2014 00:53:44 -0400
In-Reply-To: <BLU436-SMTP530E3373FB99617E291C2ADFE20@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>, Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>


On 2014=C4=EA08=D4=C204=C8=D5 15:20, Guang Yang wrote:
> Hi Yehuda,
> Here is the new pull request - https://github.com/ceph/ceph/pull/2187

I simply applied the patch on git top, and the testing shows
"rest-bench" is completely
broken with the 2 patches:


root@testing-s3gw0:~/s3-tests# /usr/bin/rest-bench
--api-host=3Dtesting-s3gw0 --access-key=3D93EEF3F5O7VY89Q2GSWC
--secret=3D"lf2bwxiRf1e9/nrOTCZyN/HgTqCz7XwrB2LDocY1" --protocol=3Dhttp
--uri_style=3Dpath --bucket=3Dcool0 --seconds=3D20 --concurrent-ios=3D5=
0
--block-size=3D204800 --show-time write
host=3Dtesting-s3gw0
2014-08-06 12:28:56.500235 7f1336645780 -1 did not load config file,
using default settings.
ERROR: failed to create bucket: ConnectionFailed
failed initializing benchmark

The related debug log entry:

2014-08-06 12:29:48.137559 7fea62fcd700 20 state for
obj=3D.rgw:.bucket.meta.rest-bench-bucket:default.9738.2 is not atomic,
not appending atomic test

After a short time, all the memory was eaten up:

root@testing-s3gw0:~/s3-tests# /usr/bin/rest-bench
--api-host=3Dtesting-s3gw0 --access-key=3D93EEF3F5O7VY89Q2GSWC
--secret=3D"lf2bwxiRf1e9/nrOTCZyN/HgTqCz7XwrB2LDocY1" --protocol=3Dhttp
--uri_style=3Dpath --seconds=3D20 --concurrent-ios=3D50 --block-size=3D=
204800
--show-time write
-bash: fork: Cannot allocate memory
root@testing-s3gw0:~/s3-tests# /usr/bin/rest-bench
--api-host=3Dtesting-s3gw0 --access-key=3D93EEF3F5O7VY89Q2GSWC
--secret=3D"lf2bwxiRf1e9/nrOTCZyN/HgTqCz7XwrB2LDocY1" --protocol=3Dhttp
--uri_style=3Dpath --seconds=3D20 --concurrent-ios=3D50 --block-size=3D=
204800
--show-time write
-bash: fork: Cannot allocate memory
root@testing-s3gw0:~/s3-tests# free
-bash: fork: Cannot allocate memory

A few mins later, the VM is completely unresponsible. And I had to
destroy it and restart again.

Guang, how was your testing when creating the patches?

> =20
>
> Thanks,
> Guang
> On Jul 31, 2014, at 10:40 PM, Guang Yang <yguang11@outlook.com> wrote=
:
>
>> Thanks Yehuda. I will do that (sorry I was occupied by some other st=
uff recently but I will try my best to provide a patch as soon as possi=
ble).
>>
>> Thanks,
>> Guang
>>
>> =D4=DA 2014=C4=EA7=D4=C231=C8=D5=A3=AC=C9=CF=CE=E71:00=A3=ACYehuda S=
adeh <yehuda@inktank.com> =D0=B4=B5=C0=A3=BA
>>
>>> Can you send this code through a github pull request (or at least a=
s a
>>> patch)? It'lll be easier to review and comment.
>>>
>>> Thanks,
>>> Yehuda
>>>
>>> On Wed, Jul 30, 2014 at 7:58 AM, Guang Yang <yguang11@outlook.com> =
wrote:
>>>> +ceph-devel.
>>>>
>>>> Thanks,
>>>> Guang
>>>>
>>>> On Jul 29, 2014, at 10:20 PM, Guang Yang <yguang11@outlook.com> wr=
ote:
>>>>
>>>>> Hi Yehuda,
>>>>> Per you review comment in terms of IO throttling for bucket index=
 operation, I prototyped the below code (details still need to polish),=
 can you take a look if that is right way to go?
>>>>>
>>>>> Another problem I came across is that ClsBucketIndexOpCtx::handle=
_compeltion was not called for the bucket index init op (below), is the=
re anything I missed obviously here?
>>>>>
>>>>> Thanks,
>>>>> Guang
>>>>>
>>>>>
>>>>> class ClsBucketIndexAioThrottler {
>>>>> protected:
>>>>> int completed;
>>>>> int ret_code;
>>>>> IoCtx& io_ctx;
>>>>> Mutex lock;
>>>>> struct LockCond {
>>>>>  Mutex lock;
>>>>>  Cond cond;
>>>>>  LockCond() : lock("LockCond"), cond() {}
>>>>> } lock_cond;
>>>>> public:
>>>>> ClsBucketIndexAioThrottler(IoCtx& _io_ctx)
>>>>>  : completed(0), ret_code(0), io_ctx(_io_ctx),
>>>>>  lock("ClsBucketIndexAioThrottler"), lock_cond() {}
>>>>>
>>>>> virtual ~ClsBucketIndexAioThrottler() {}
>>>>> virtual void do_next() =3D 0;
>>>>> virtual bool is_completed () =3D 0;
>>>>>
>>>>> void complete(int ret) {
>>>>>  {
>>>>>    Mutex::Locker l(lock);
>>>>>    if (ret < 0)
>>>>>      ret_code =3D ret;
>>>>>    ++completed;
>>>>>  }
>>>>>
>>>>>  lock_cond.lock.Lock();
>>>>>  lock_cond.cond.Signal();
>>>>>  lock_cond.lock.Unlock();
>>>>> }
>>>>>
>>>>> int get_ret_code () {
>>>>>  Mutex::Locker l(lock);
>>>>>  return ret_code;
>>>>> }
>>>>>
>>>>> virtual int wait_completion() {
>>>>>  lock_cond.lock.Lock();
>>>>>  while (1) {
>>>>>    if (is_completed()) {
>>>>>      lock_cond.lock.Unlock();
>>>>>      return ret_code;
>>>>>    }
>>>>>    lock_cond.cond.Wait(lock_cond.lock);
>>>>>    lock_cond.lock.Lock();
>>>>>  }
>>>>> }
>>>>> };
>>>>>
>>>>> class ClsBucketIndexListAioThrottler : public ClsBucketIndexAioTh=
rottler {
>>>>> protected:
>>>>> vector<string> bucket_objects;
>>>>> vector<string>::iterator iter_pos;
>>>>> public:
>>>>> ClsBucketIndexListAioThrottler(IoCtx& _io_ctx, const vector<strin=
g> _bucket_objs)
>>>>>  : ClsBucketIndexAioThrottler(_io_ctx), bucket_objects(_bucket_ob=
js),
>>>>>  iter_pos(bucket_objects.begin()) {}
>>>>>
>>>>> virtual bool is_completed() {
>>>>>  Mutex::Locker l(lock);
>>>>>  int sent =3D 0;
>>>>>  vector<string>::iterator iter =3D bucket_objects.begin();
>>>>>  for (; iter !=3D iter_pos; ++iter) ++sent;
>>>>>
>>>>>  return (sent =3D=3D completed &&
>>>>>      (iter_pos =3D=3D bucket_objects.end() /*Success*/ || ret_cod=
e < 0 /*Failure*/));
>>>>> }
>>>>> };
>>>>>
>>>>> template<typename T>
>>>>> class ClsBucketIndexOpCtx : public ObjectOperationCompletion {
>>>>> private:
>>>>> T* data;
>>>>> // Return code of the operation
>>>>> int* ret_code;
>>>>>
>>>>> // The Aio completion object associated with this Op, it should
>>>>> // be release from within the completion handler
>>>>> librados::AioCompletion* completion;
>>>>> ClsBucketIndexAioThrottler* throttler;
>>>>> public:
>>>>> ClsBucketIndexOpCtx(T* _data, int* _ret_code, librados::AioComple=
tion* _completion,
>>>>>        ClsBucketIndexAioThrottler* _throttler)
>>>>>  : data(_data), ret_code(_ret_code), completion(_completion), thr=
ottler(_throttler) {}
>>>>> ~ClsBucketIndexOpCtx() {}
>>>>>
>>>>> // The completion callback, fill the response data
>>>>> void handle_completion(int r, bufferlist& outbl) {
>>>>>  if (r >=3D 0) {
>>>>>    if (data) {
>>>>>      try {
>>>>>        bufferlist::iterator iter =3D outbl.begin();
>>>>>        ::decode((*data), iter);
>>>>>      } catch (buffer::error& err) {
>>>>>        r =3D -EIO;
>>>>>      }
>>>>>    }
>>>>>    // Do the next request
>>>>>  }
>>>>>  throttler->do_next();
>>>>>  throttler->complete(r);
>>>>>  if (completion) {
>>>>>    completion->release();
>>>>>  }
>>>>> }
>>>>> };
>>>>>
>>>>>
>>>>> class ClsBucketIndexInitAioThrottler : public ClsBucketIndexListA=
ioThrottler {
>>>>> public:
>>>>> ClsBucketIndexInitAioThrottler(IoCtx& _io_ctx, const vector<strin=
g> _bucket_objs) :
>>>>>  ClsBucketIndexListAioThrottler(_io_ctx, _bucket_objs) {}
>>>>>
>>>>> virtual void do_next() {
>>>>>  string oid;
>>>>>  {
>>>>>    Mutex::Locker l(lock);
>>>>>    if (iter_pos =3D=3D bucket_objects.end())
>>>>>      return;
>>>>>    oid =3D *(iter_pos++);
>>>>>  }
>>>>>  AioCompletion* c =3D librados::Rados::aio_create_completion(NULL=
, NULL, NULL);
>>>>>  // Dummy
>>>>>  bufferlist in;
>>>>>  librados::ObjectWriteOperation op;
>>>>>  op.create(true);
>>>>>  op.exec("rgw", "bucket_init_index", in, new ClsBucketIndexOpCtx<=
int>(NULL, NULL, c, this));
>>>>>  io_ctx.aio_operate(oid, c, &op, NULL);
>>>>> }
>>>>> };
>>>>>
>>>>>
>>>>> int cls_rgw_bucket_index_init_op(librados::IoCtx &io_ctx,
>>>>>      const vector<string>& bucket_objs, uint32_t max_aio)
>>>>> {
>>>>> vector<string>::const_iterator iter =3D bucket_objs.begin();
>>>>> bufferlist in;
>>>>> ClsBucketIndexAioThrottler* throttler =3D new ClsBucketIndexInitA=
ioThrottler(io_ctx, bucket_objs);
>>>>> for (; iter !=3D bucket_objs.end() && max_aio-- > 0; ++iter) {
>>>>>     throttler->do_next();
>>>>> }
>>>>> throttler->wait_completion();
>>>>> return 0;
>>>>> }
>>>>>
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
