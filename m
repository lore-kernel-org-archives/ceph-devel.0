From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] implement librados aio_stat
Date: Wed, 19 Dec 2012 07:53:46 -0800
Message-ID: <50D1E30A.4060901@inktank.com>
References: <1355483921-15654-1-git-send-email-philipgian@grnet.gr> <CAC-hyiEpvBnGTLQ-2mVx3v6fi3Ku_Tf1fVRyrmGPwQW4afxb=g@mail.gmail.com> <50D18530.7090805@grnet.gr> <alpine.DEB.2.00.1212190741470.13122@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34336 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab2LSQCI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 11:02:08 -0500
Received: by mail-pb0-f48.google.com with SMTP id rq13so1308178pbb.35
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 08:02:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212190741470.13122@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Filippos Giannakos <philipgian@grnet.gr>, Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On 12/19/2012 07:43 AM, Sage Weil wrote:
> On Wed, 19 Dec 2012, Filippos Giannakos wrote:
>> OK. About the LIBRADOS_VER_MINOR, do you want me to bump it and submit a
>> new patch?
>
> Yes, please.  Also, one other thing: can you add a functional test to
> ceph.git/src/test/librados/aio.cc so that all of the the regular testing
> and test suites will exercise the new code?

Also the C++ version can just be aio_stat rather than rados_aio_stat.
It's already in the librados namespace.

Josh

> Thanks!
> sage
>
>
>>
>> Best regards,
>> Filippos
>>
>> On 12/15/2012 09:49 AM, Yehuda Sadeh wrote:
>>> Went through it briefly, looks fine, though I'd like to go over it
>>> some more before picking this up. Note that LIBRADOS_VER_MINOR needs
>>> to be bumped up too.
>>>
>>> Thanks,
>>> Yehuda
>>>
>>> On Fri, Dec 14, 2012 at 3:18 AM, Filippos Giannakos<philipgian@grnet.gr>
>>> wrote:
>>>> ---
>>>>    src/include/rados/librados.h   |   14 ++++++++++++++
>>>>    src/include/rados/librados.hpp |   15 +++++++++++++-
>>>>    src/librados/IoCtxImpl.cc      |   42
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>    src/librados/IoCtxImpl.h       |    9 +++++++++
>>>>    src/librados/librados.cc       |   10 ++++++++++
>>>>    5 files changed, 89 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
>>>> index 44d6f71..7f4b5c0 100644
>>>> --- a/src/include/rados/librados.h
>>>> +++ b/src/include/rados/librados.h
>>>> @@ -1444,6 +1444,20 @@ int rados_aio_read(rados_ioctx_t io, const char
>>>> *oid,
>>>>     */
>>>>    int rados_aio_flush(rados_ioctx_t io);
>>>>
>>>> +
>>>> +/**
>>>> + * Asynchronously get object stats (size/mtime)
>>>> + *
>>>> + * @param io ioctx
>>>> + * @param o object name
>>>> + * @param psize where to store object size
>>>> + * @param pmtime where to store modification time
>>>> + * @returns 0 on success, negative error code on failure
>>>> + */
>>>> +int rados_aio_stat(rados_ioctx_t io, const char *o,
>>>> +                  rados_completion_t completion,
>>>> +                  uint64_t *psize, time_t *pmtime);
>>>> +
>>>>    /** @} Asynchronous I/O */
>>>>
>>>>    /**
>>>> diff --git a/src/include/rados/librados.hpp
>>>> b/src/include/rados/librados.hpp
>>>> index e50acdb..96bfc15 100644
>>>> --- a/src/include/rados/librados.hpp
>>>> +++ b/src/include/rados/librados.hpp
>>>> @@ -473,9 +473,22 @@ namespace librados
>>>>         * other than CEPH_NOSNAP
>>>>         */
>>>>        int aio_remove(const std::string&  oid, AioCompletion *c);
>>>> -
>>>> +
>>>>        int aio_flush();
>>>>
>>>> +    /**
>>>> +     * Asynchronously get object stats (size/mtime)
>>>> +     *
>>>> +     * @param io ioctx
>>>> +     * @param o object name
>>>> +     * @param psize where to store object size
>>>> +     * @param pmtime where to store modification time
>>>> +     * @returns 0 on success, negative error code on failure
>>>> +     */
>>>> +    int rados_aio_stat(rados_ioctx_t io, const char *o,
>>>> +                      rados_completion_t completion,
>>>> +                      uint64_t *psize, time_t *pmtime);
>>>> +
>>>>        int aio_exec(const std::string&  oid, AioCompletion *c, const char
>>>> *cls, const char *method,
>>>>                    bufferlist&  inbl, bufferlist *outbl);
>>>>
>>>> diff --git a/src/librados/IoCtxImpl.cc b/src/librados/IoCtxImpl.cc
>>>> index 01b4a94..50aab1e 100644
>>>> --- a/src/librados/IoCtxImpl.cc
>>>> +++ b/src/librados/IoCtxImpl.cc
>>>> @@ -851,6 +851,21 @@ int librados::IoCtxImpl::aio_remove(const
>>>> object_t&oid, AioCompletionImpl *c)
>>>>      return 0;
>>>>    }
>>>>
>>>> +
>>>> +int librados::IoCtxImpl::aio_stat(const object_t&  oid, AioCompletionImpl
>>>> *c,
>>>> +                                 uint64_t *psize, time_t *pmtime)
>>>> +{
>>>> +  c->io = this;
>>>> +  C_aio_stat_Ack *onack = new C_aio_stat_Ack(c, pmtime);
>>>> +
>>>> +  Mutex::Locker l(*lock);
>>>> +  objecter->stat(oid, oloc,
>>>> +                snap_seq, psize,&onack->mtime, 0,
>>>> +                onack,&c->objver);
>>>> +
>>>> +  return 0;
>>>> +}
>>>> +
>>>>    int librados::IoCtxImpl::remove(const object_t&  oid)
>>>>    {
>>>>      utime_t ut = ceph_clock_now(client->cct);
>>>> @@ -1562,6 +1577,33 @@ void librados::IoCtxImpl::C_aio_Ack::finish(int r)
>>>>      c->put_unlock();
>>>>    }
>>>>
>>>> +///////////////////////////// C_aio_stat_Ack ////////////////////////////
>>>> +
>>>> +librados::IoCtxImpl::C_aio_stat_Ack::C_aio_stat_Ack(AioCompletionImpl
>>>> *_c,
>>>> +                                                   time_t *pm)
>>>> +   : c(_c), pmtime(pm)
>>>> +{
>>>> +  c->get();
>>>> +}
>>>> +
>>>> +void librados::IoCtxImpl::C_aio_stat_Ack::finish(int r)
>>>> +{
>>>> +  c->lock.Lock();
>>>> +  c->rval = r;
>>>> +  c->ack = true;
>>>> +  c->cond.Signal();
>>>> +
>>>> +  if (r>= 0&&  pmtime) {
>>>> +    *pmtime = mtime.sec();
>>>> +  }
>>>> +
>>>> +  if (c->callback_complete) {
>>>> +    c->io->client->finisher.queue(new C_AioComplete(c));
>>>> +  }
>>>> +
>>>> +  c->put_unlock();
>>>> +}
>>>> +
>>>>    /////////////////////// C_aio_sparse_read_Ack //////////////////////////
>>>>
>>>>    librados::IoCtxImpl::C_aio_sparse_read_Ack::C_aio_sparse_read_Ack(AioCompletionImpl
>>>> *_c,
>>>> diff --git a/src/librados/IoCtxImpl.h b/src/librados/IoCtxImpl.h
>>>> index feea0e8..55b07ee 100644
>>>> --- a/src/librados/IoCtxImpl.h
>>>> +++ b/src/librados/IoCtxImpl.h
>>>> @@ -144,6 +144,14 @@ struct librados::IoCtxImpl {
>>>>        C_aio_Ack(AioCompletionImpl *_c);
>>>>        void finish(int r);
>>>>      };
>>>> +
>>>> +  struct C_aio_stat_Ack : public Context {
>>>> +    librados::AioCompletionImpl *c;
>>>> +    time_t *pmtime;
>>>> +    utime_t mtime;
>>>> +    C_aio_stat_Ack(AioCompletionImpl *_c, time_t *pm);
>>>> +    void finish(int r);
>>>> +  };
>>>>
>>>>      struct C_aio_sparse_read_Ack : public Context {
>>>>        AioCompletionImpl *c;
>>>> @@ -177,6 +185,7 @@ struct librados::IoCtxImpl {
>>>>      int aio_remove(const object_t&oid, AioCompletionImpl *c);
>>>>      int aio_exec(const object_t&  oid, AioCompletionImpl *c, const char
>>>> *cls,
>>>>                  const char *method, bufferlist&  inbl, bufferlist *outbl);
>>>> +  int aio_stat(const object_t&  oid, AioCompletionImpl *c, uint64_t
>>>> *psize, time_t *pmtime);
>>>>
>>>>      int pool_change_auid(unsigned long long auid);
>>>>      int pool_change_auid_async(unsigned long long auid,
>>>> PoolAsyncCompletionImpl *c);
>>>> diff --git a/src/librados/librados.cc b/src/librados/librados.cc
>>>> index 274119c..af36b38 100644
>>>> --- a/src/librados/librados.cc
>>>> +++ b/src/librados/librados.cc
>>>> @@ -2167,6 +2167,16 @@ extern "C" int rados_aio_flush(rados_ioctx_t io)
>>>>      return 0;
>>>>    }
>>>>
>>>> +extern "C" int rados_aio_stat(rados_ioctx_t io, const char *o,
>>>> +                             rados_completion_t completion,
>>>> +                             uint64_t *psize, time_t *pmtime)
>>>> +{
>>>> +  librados::IoCtxImpl *ctx = (librados::IoCtxImpl *)io;
>>>> +  object_t oid(o);
>>>> +  return ctx->aio_stat(oid, (librados::AioCompletionImpl*)completion,
>>>> +                      psize, pmtime);
>>>> +}
>>>> +
>>>>    struct C_WatchCB : public librados::WatchCtx {
>>>>      rados_watchcb_t wcb;
>>>>      void *arg;
>>>> --
>>>> 1.7.10.4

