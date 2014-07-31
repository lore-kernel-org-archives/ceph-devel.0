From: Guang Yang <yguang11@outlook.com>
Subject: Re: bucket index sharding - IO throttle
Date: Thu, 31 Jul 2014 22:40:41 +0800
Message-ID: <BLU436-SMTP258261DA4CD49AE6829E5A9DFE60@phx.gbl>
References: <1963E3AE-B242-4896-904C-B0868F5AC569@outlook.com> <BLU437-SMTP904C06D419679BD5A09056DFF90@phx.gbl> <CABBk=J9H+ncDjp6ABVmraaPOx5x5ubvfn2vb3UK6y3R=B=zLBQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s16.hotmail.com ([65.55.111.155]:58729 "EHLO
	BLU004-OMC4S16.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973AbaGaOkz convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Jul 2014 10:40:55 -0400
In-Reply-To: <CABBk=J9H+ncDjp6ABVmraaPOx5x5ubvfn2vb3UK6y3R=B=zLBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Thanks Yehuda. I will do that (sorry I was occupied by some other stuff=
 recently but I will try my best to provide a patch as soon as possible=
).

Thanks,
Guang

=D4=DA 2014=C4=EA7=D4=C231=C8=D5=A3=AC=C9=CF=CE=E71:00=A3=ACYehuda Sade=
h <yehuda@inktank.com> =D0=B4=B5=C0=A3=BA

> Can you send this code through a github pull request (or at least as =
a
> patch)? It'lll be easier to review and comment.
>=20
> Thanks,
> Yehuda
>=20
> On Wed, Jul 30, 2014 at 7:58 AM, Guang Yang <yguang11@outlook.com> wr=
ote:
>> +ceph-devel.
>>=20
>> Thanks,
>> Guang
>>=20
>> On Jul 29, 2014, at 10:20 PM, Guang Yang <yguang11@outlook.com> wrot=
e:
>>=20
>>> Hi Yehuda,
>>> Per you review comment in terms of IO throttling for bucket index o=
peration, I prototyped the below code (details still need to polish), c=
an you take a look if that is right way to go?
>>>=20
>>> Another problem I came across is that ClsBucketIndexOpCtx::handle_c=
ompeltion was not called for the bucket index init op (below), is there=
 anything I missed obviously here?
>>>=20
>>> Thanks,
>>> Guang
>>>=20
>>>=20
>>> class ClsBucketIndexAioThrottler {
>>> protected:
>>> int completed;
>>> int ret_code;
>>> IoCtx& io_ctx;
>>> Mutex lock;
>>> struct LockCond {
>>>   Mutex lock;
>>>   Cond cond;
>>>   LockCond() : lock("LockCond"), cond() {}
>>> } lock_cond;
>>> public:
>>> ClsBucketIndexAioThrottler(IoCtx& _io_ctx)
>>>   : completed(0), ret_code(0), io_ctx(_io_ctx),
>>>   lock("ClsBucketIndexAioThrottler"), lock_cond() {}
>>>=20
>>> virtual ~ClsBucketIndexAioThrottler() {}
>>> virtual void do_next() =3D 0;
>>> virtual bool is_completed () =3D 0;
>>>=20
>>> void complete(int ret) {
>>>   {
>>>     Mutex::Locker l(lock);
>>>     if (ret < 0)
>>>       ret_code =3D ret;
>>>     ++completed;
>>>   }
>>>=20
>>>   lock_cond.lock.Lock();
>>>   lock_cond.cond.Signal();
>>>   lock_cond.lock.Unlock();
>>> }
>>>=20
>>> int get_ret_code () {
>>>   Mutex::Locker l(lock);
>>>   return ret_code;
>>> }
>>>=20
>>> virtual int wait_completion() {
>>>   lock_cond.lock.Lock();
>>>   while (1) {
>>>     if (is_completed()) {
>>>       lock_cond.lock.Unlock();
>>>       return ret_code;
>>>     }
>>>     lock_cond.cond.Wait(lock_cond.lock);
>>>     lock_cond.lock.Lock();
>>>   }
>>> }
>>> };
>>>=20
>>> class ClsBucketIndexListAioThrottler : public ClsBucketIndexAioThro=
ttler {
>>> protected:
>>> vector<string> bucket_objects;
>>> vector<string>::iterator iter_pos;
>>> public:
>>> ClsBucketIndexListAioThrottler(IoCtx& _io_ctx, const vector<string>=
 _bucket_objs)
>>>   : ClsBucketIndexAioThrottler(_io_ctx), bucket_objects(_bucket_obj=
s),
>>>   iter_pos(bucket_objects.begin()) {}
>>>=20
>>> virtual bool is_completed() {
>>>   Mutex::Locker l(lock);
>>>   int sent =3D 0;
>>>   vector<string>::iterator iter =3D bucket_objects.begin();
>>>   for (; iter !=3D iter_pos; ++iter) ++sent;
>>>=20
>>>   return (sent =3D=3D completed &&
>>>       (iter_pos =3D=3D bucket_objects.end() /*Success*/ || ret_code=
 < 0 /*Failure*/));
>>> }
>>> };
>>>=20
>>> template<typename T>
>>> class ClsBucketIndexOpCtx : public ObjectOperationCompletion {
>>> private:
>>> T* data;
>>> // Return code of the operation
>>> int* ret_code;
>>>=20
>>> // The Aio completion object associated with this Op, it should
>>> // be release from within the completion handler
>>> librados::AioCompletion* completion;
>>> ClsBucketIndexAioThrottler* throttler;
>>> public:
>>> ClsBucketIndexOpCtx(T* _data, int* _ret_code, librados::AioCompleti=
on* _completion,
>>>         ClsBucketIndexAioThrottler* _throttler)
>>>   : data(_data), ret_code(_ret_code), completion(_completion), thro=
ttler(_throttler) {}
>>> ~ClsBucketIndexOpCtx() {}
>>>=20
>>> // The completion callback, fill the response data
>>> void handle_completion(int r, bufferlist& outbl) {
>>>   if (r >=3D 0) {
>>>     if (data) {
>>>       try {
>>>         bufferlist::iterator iter =3D outbl.begin();
>>>         ::decode((*data), iter);
>>>       } catch (buffer::error& err) {
>>>         r =3D -EIO;
>>>       }
>>>     }
>>>     // Do the next request
>>>   }
>>>   throttler->do_next();
>>>   throttler->complete(r);
>>>   if (completion) {
>>>     completion->release();
>>>   }
>>> }
>>> };
>>>=20
>>>=20
>>> class ClsBucketIndexInitAioThrottler : public ClsBucketIndexListAio=
Throttler {
>>> public:
>>> ClsBucketIndexInitAioThrottler(IoCtx& _io_ctx, const vector<string>=
 _bucket_objs) :
>>>   ClsBucketIndexListAioThrottler(_io_ctx, _bucket_objs) {}
>>>=20
>>> virtual void do_next() {
>>>   string oid;
>>>   {
>>>     Mutex::Locker l(lock);
>>>     if (iter_pos =3D=3D bucket_objects.end())
>>>       return;
>>>     oid =3D *(iter_pos++);
>>>   }
>>>   AioCompletion* c =3D librados::Rados::aio_create_completion(NULL,=
 NULL, NULL);
>>>   // Dummy
>>>   bufferlist in;
>>>   librados::ObjectWriteOperation op;
>>>   op.create(true);
>>>   op.exec("rgw", "bucket_init_index", in, new ClsBucketIndexOpCtx<i=
nt>(NULL, NULL, c, this));
>>>   io_ctx.aio_operate(oid, c, &op, NULL);
>>> }
>>> };
>>>=20
>>>=20
>>> int cls_rgw_bucket_index_init_op(librados::IoCtx &io_ctx,
>>>       const vector<string>& bucket_objs, uint32_t max_aio)
>>> {
>>>  vector<string>::const_iterator iter =3D bucket_objs.begin();
>>>  bufferlist in;
>>>  ClsBucketIndexAioThrottler* throttler =3D new ClsBucketIndexInitAi=
oThrottler(io_ctx, bucket_objs);
>>>  for (; iter !=3D bucket_objs.end() && max_aio-- > 0; ++iter) {
>>>      throttler->do_next();
>>>  }
>>>  throttler->wait_completion();
>>>  return 0;
>>> }
>>>=20
>>>=20
>>=20
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
