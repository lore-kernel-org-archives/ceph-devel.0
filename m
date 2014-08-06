From: Guang Yang <yguang11@outlook.com>
Subject: Re: bucket index sharding - IO throttle
Date: Wed, 6 Aug 2014 15:51:04 +0800
Message-ID: <BLU436-SMTP83CD77326525755EABAAEADFE00@phx.gbl>
References: <1963E3AE-B242-4896-904C-B0868F5AC569@outlook.com> <BLU437-SMTP904C06D419679BD5A09056DFF90@phx.gbl> <CABBk=J9H+ncDjp6ABVmraaPOx5x5ubvfn2vb3UK6y3R=B=zLBQ@mail.gmail.com> <BLU436-SMTP258261DA4CD49AE6829E5A9DFE60@phx.gbl> <BLU436-SMTP530E3373FB99617E291C2ADFE20@phx.gbl> <53E1B129.4060006@yunify.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s21.hotmail.com ([65.55.111.160]:59501 "EHLO
	BLU004-OMC4S21.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753799AbaHFHvN convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Aug 2014 03:51:13 -0400
In-Reply-To: <53E1B129.4060006@yunify.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Osier Yang <osier@yunify.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Ceph-devel <ceph-devel@vger.kernel.org>

Hi Osier,
I doubt the issue is related (the error message is connection failure),=
 the below patch is pretty simple (and incomplete), what it does is to =
add a configuration to bucket meta info so that we can configure the nu=
mber of shards on bucket basis (again, this is not included in the patc=
h).

The patch should be completely backward compatible which means if you d=
on=A1=AFt change the number of shards configuration, nothing should be =
changed for bucket creation/listing.

My plan is to use this patch as a starting point to review, as the key =
building blocks are included in the patch and once it is passed review,=
 I will create a bunch of following patches to implement the feature co=
mpletely (which are mostly done in the previous big patch - https://git=
hub.com/ceph/ceph/pull/2013).

I tested the patch locally in my cluster and it looks good for bucket c=
reation.

Thanks,
Guang

On Aug 6, 2014, at 12:38 PM, Osier Yang <osier@yunify.com> wrote:

>=20
> On 2014=C4=EA08=D4=C204=C8=D5 15:20, Guang Yang wrote:
>> Hi Yehuda,
>> Here is the new pull request - https://github.com/ceph/ceph/pull/218=
7
>=20
> I simply applied the patch on git top, and the testing shows
> "rest-bench" is completely
> broken with the 2 patches:
>=20
>=20
> root@testing-s3gw0:~/s3-tests# /usr/bin/rest-bench
> --api-host=3Dtesting-s3gw0 --access-key=3D93EEF3F5O7VY89Q2GSWC
> --secret=3D"lf2bwxiRf1e9/nrOTCZyN/HgTqCz7XwrB2LDocY1" --protocol=3Dht=
tp
> --uri_style=3Dpath --bucket=3Dcool0 --seconds=3D20 --concurrent-ios=3D=
50
> --block-size=3D204800 --show-time write
> host=3Dtesting-s3gw0
> 2014-08-06 12:28:56.500235 7f1336645780 -1 did not load config file,
> using default settings.
> ERROR: failed to create bucket: ConnectionFailed
> failed initializing benchmark
>=20
> The related debug log entry:
>=20
> 2014-08-06 12:29:48.137559 7fea62fcd700 20 state for
> obj=3D.rgw:.bucket.meta.rest-bench-bucket:default.9738.2 is not atomi=
c,
> not appending atomic test
>=20
> After a short time, all the memory was eaten up:
>=20
> root@testing-s3gw0:~/s3-tests# /usr/bin/rest-bench
> --api-host=3Dtesting-s3gw0 --access-key=3D93EEF3F5O7VY89Q2GSWC
> --secret=3D"lf2bwxiRf1e9/nrOTCZyN/HgTqCz7XwrB2LDocY1" --protocol=3Dht=
tp
> --uri_style=3Dpath --seconds=3D20 --concurrent-ios=3D50 --block-size=3D=
204800
> --show-time write
> -bash: fork: Cannot allocate memory
> root@testing-s3gw0:~/s3-tests# /usr/bin/rest-bench
> --api-host=3Dtesting-s3gw0 --access-key=3D93EEF3F5O7VY89Q2GSWC
> --secret=3D"lf2bwxiRf1e9/nrOTCZyN/HgTqCz7XwrB2LDocY1" --protocol=3Dht=
tp
> --uri_style=3Dpath --seconds=3D20 --concurrent-ios=3D50 --block-size=3D=
204800
> --show-time write
> -bash: fork: Cannot allocate memory
> root@testing-s3gw0:~/s3-tests# free
> -bash: fork: Cannot allocate memory
>=20
> A few mins later, the VM is completely unresponsible. And I had to
> destroy it and restart again.
>=20
> Guang, how was your testing when creating the patches?
>=20
>>=20
>>=20
>> Thanks,
>> Guang
>> On Jul 31, 2014, at 10:40 PM, Guang Yang <yguang11@outlook.com> wrot=
e:
>>=20
>>> Thanks Yehuda. I will do that (sorry I was occupied by some other s=
tuff recently but I will try my best to provide a patch as soon as poss=
ible).
>>>=20
>>> Thanks,
>>> Guang
>>>=20
>>> =D4=DA 2014=C4=EA7=D4=C231=C8=D5=A3=AC=C9=CF=CE=E71:00=A3=ACYehuda =
Sadeh <yehuda@inktank.com> =D0=B4=B5=C0=A3=BA
>>>=20
>>>> Can you send this code through a github pull request (or at least =
as a
>>>> patch)? It'lll be easier to review and comment.
>>>>=20
>>>> Thanks,
>>>> Yehuda
>>>>=20
>>>> On Wed, Jul 30, 2014 at 7:58 AM, Guang Yang <yguang11@outlook.com>=
 wrote:
>>>>> +ceph-devel.
>>>>>=20
>>>>> Thanks,
>>>>> Guang
>>>>>=20
>>>>> On Jul 29, 2014, at 10:20 PM, Guang Yang <yguang11@outlook.com> w=
rote:
>>>>>=20
>>>>>> Hi Yehuda,
>>>>>> Per you review comment in terms of IO throttling for bucket inde=
x operation, I prototyped the below code (details still need to polish)=
, can you take a look if that is right way to go?
>>>>>>=20
>>>>>> Another problem I came across is that ClsBucketIndexOpCtx::handl=
e_compeltion was not called for the bucket index init op (below), is th=
ere anything I missed obviously here?
>>>>>>=20
>>>>>> Thanks,
>>>>>> Guang
>>>>>>=20
>>>>>>=20
>>>>>> class ClsBucketIndexAioThrottler {
>>>>>> protected:
>>>>>> int completed;
>>>>>> int ret_code;
>>>>>> IoCtx& io_ctx;
>>>>>> Mutex lock;
>>>>>> struct LockCond {
>>>>>> Mutex lock;
>>>>>> Cond cond;
>>>>>> LockCond() : lock("LockCond"), cond() {}
>>>>>> } lock_cond;
>>>>>> public:
>>>>>> ClsBucketIndexAioThrottler(IoCtx& _io_ctx)
>>>>>> : completed(0), ret_code(0), io_ctx(_io_ctx),
>>>>>> lock("ClsBucketIndexAioThrottler"), lock_cond() {}
>>>>>>=20
>>>>>> virtual ~ClsBucketIndexAioThrottler() {}
>>>>>> virtual void do_next() =3D 0;
>>>>>> virtual bool is_completed () =3D 0;
>>>>>>=20
>>>>>> void complete(int ret) {
>>>>>> {
>>>>>>   Mutex::Locker l(lock);
>>>>>>   if (ret < 0)
>>>>>>     ret_code =3D ret;
>>>>>>   ++completed;
>>>>>> }
>>>>>>=20
>>>>>> lock_cond.lock.Lock();
>>>>>> lock_cond.cond.Signal();
>>>>>> lock_cond.lock.Unlock();
>>>>>> }
>>>>>>=20
>>>>>> int get_ret_code () {
>>>>>> Mutex::Locker l(lock);
>>>>>> return ret_code;
>>>>>> }
>>>>>>=20
>>>>>> virtual int wait_completion() {
>>>>>> lock_cond.lock.Lock();
>>>>>> while (1) {
>>>>>>   if (is_completed()) {
>>>>>>     lock_cond.lock.Unlock();
>>>>>>     return ret_code;
>>>>>>   }
>>>>>>   lock_cond.cond.Wait(lock_cond.lock);
>>>>>>   lock_cond.lock.Lock();
>>>>>> }
>>>>>> }
>>>>>> };
>>>>>>=20
>>>>>> class ClsBucketIndexListAioThrottler : public ClsBucketIndexAioT=
hrottler {
>>>>>> protected:
>>>>>> vector<string> bucket_objects;
>>>>>> vector<string>::iterator iter_pos;
>>>>>> public:
>>>>>> ClsBucketIndexListAioThrottler(IoCtx& _io_ctx, const vector<stri=
ng> _bucket_objs)
>>>>>> : ClsBucketIndexAioThrottler(_io_ctx), bucket_objects(_bucket_ob=
js),
>>>>>> iter_pos(bucket_objects.begin()) {}
>>>>>>=20
>>>>>> virtual bool is_completed() {
>>>>>> Mutex::Locker l(lock);
>>>>>> int sent =3D 0;
>>>>>> vector<string>::iterator iter =3D bucket_objects.begin();
>>>>>> for (; iter !=3D iter_pos; ++iter) ++sent;
>>>>>>=20
>>>>>> return (sent =3D=3D completed &&
>>>>>>     (iter_pos =3D=3D bucket_objects.end() /*Success*/ || ret_cod=
e < 0 /*Failure*/));
>>>>>> }
>>>>>> };
>>>>>>=20
>>>>>> template<typename T>
>>>>>> class ClsBucketIndexOpCtx : public ObjectOperationCompletion {
>>>>>> private:
>>>>>> T* data;
>>>>>> // Return code of the operation
>>>>>> int* ret_code;
>>>>>>=20
>>>>>> // The Aio completion object associated with this Op, it should
>>>>>> // be release from within the completion handler
>>>>>> librados::AioCompletion* completion;
>>>>>> ClsBucketIndexAioThrottler* throttler;
>>>>>> public:
>>>>>> ClsBucketIndexOpCtx(T* _data, int* _ret_code, librados::AioCompl=
etion* _completion,
>>>>>>       ClsBucketIndexAioThrottler* _throttler)
>>>>>> : data(_data), ret_code(_ret_code), completion(_completion), thr=
ottler(_throttler) {}
>>>>>> ~ClsBucketIndexOpCtx() {}
>>>>>>=20
>>>>>> // The completion callback, fill the response data
>>>>>> void handle_completion(int r, bufferlist& outbl) {
>>>>>> if (r >=3D 0) {
>>>>>>   if (data) {
>>>>>>     try {
>>>>>>       bufferlist::iterator iter =3D outbl.begin();
>>>>>>       ::decode((*data), iter);
>>>>>>     } catch (buffer::error& err) {
>>>>>>       r =3D -EIO;
>>>>>>     }
>>>>>>   }
>>>>>>   // Do the next request
>>>>>> }
>>>>>> throttler->do_next();
>>>>>> throttler->complete(r);
>>>>>> if (completion) {
>>>>>>   completion->release();
>>>>>> }
>>>>>> }
>>>>>> };
>>>>>>=20
>>>>>>=20
>>>>>> class ClsBucketIndexInitAioThrottler : public ClsBucketIndexList=
AioThrottler {
>>>>>> public:
>>>>>> ClsBucketIndexInitAioThrottler(IoCtx& _io_ctx, const vector<stri=
ng> _bucket_objs) :
>>>>>> ClsBucketIndexListAioThrottler(_io_ctx, _bucket_objs) {}
>>>>>>=20
>>>>>> virtual void do_next() {
>>>>>> string oid;
>>>>>> {
>>>>>>   Mutex::Locker l(lock);
>>>>>>   if (iter_pos =3D=3D bucket_objects.end())
>>>>>>     return;
>>>>>>   oid =3D *(iter_pos++);
>>>>>> }
>>>>>> AioCompletion* c =3D librados::Rados::aio_create_completion(NULL=
, NULL, NULL);
>>>>>> // Dummy
>>>>>> bufferlist in;
>>>>>> librados::ObjectWriteOperation op;
>>>>>> op.create(true);
>>>>>> op.exec("rgw", "bucket_init_index", in, new ClsBucketIndexOpCtx<=
int>(NULL, NULL, c, this));
>>>>>> io_ctx.aio_operate(oid, c, &op, NULL);
>>>>>> }
>>>>>> };
>>>>>>=20
>>>>>>=20
>>>>>> int cls_rgw_bucket_index_init_op(librados::IoCtx &io_ctx,
>>>>>>     const vector<string>& bucket_objs, uint32_t max_aio)
>>>>>> {
>>>>>> vector<string>::const_iterator iter =3D bucket_objs.begin();
>>>>>> bufferlist in;
>>>>>> ClsBucketIndexAioThrottler* throttler =3D new ClsBucketIndexInit=
AioThrottler(io_ctx, bucket_objs);
>>>>>> for (; iter !=3D bucket_objs.end() && max_aio-- > 0; ++iter) {
>>>>>>    throttler->do_next();
>>>>>> }
>>>>>> throttler->wait_completion();
>>>>>> return 0;
>>>>>> }
>>>>>>=20
>>>>>>=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
