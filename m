From: Haomai Wang <haomaiwang@gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IE5ld1N0b3JlIHBlcmZvcm1hbmNlIGFuYWx5c2lz?=
Date: Tue, 21 Apr 2015 16:51:56 +0800
Message-ID: <CACJqLybRGUEXqoME_fQpNHtbYG73En2AnhgMsZ+WEN+EYP3xqw@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC021D081C@shsmsx102.ccr.corp.intel.com>
	<alpine.DEB.2.00.1504200826500.18547@cobra.newdream.net>
	<oqwenulom2umn8f37cg5gvgh.1429545030301@email.android.com>
	<alpine.DEB.2.00.1504200945000.18547@cobra.newdream.net>
	<6F3FA899187F0043BA1827A69DA2F7CC021D1018@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35045 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbbDUIv5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Apr 2015 04:51:57 -0400
Received: by pabtp1 with SMTP id tp1so234815695pab.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2015 01:51:57 -0700 (PDT)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC021D1018@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Sage Weil <sweil@redhat.com>, Mark Nelson <mnelson@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "Duan, Jiangang" <jiangang.duan@intel.com>, "Zhang, Jian" <jian.zhang@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Apr 21, 2015 at 2:43 PM, Chen, Xiaoxi <xiaoxi.chen@intel.com> w=
rote:
> Hi Sage,
>         Well, that's
>                 submit_transaction -- submit a transaction , whether =
block waiting for fdatasync depends on rocksdb-disable-sync.
>                 submit_transaction_sync -- queue transaction and wait=
 until it is stable on disk.
>         So if we default rocksdb-disable-sync to false, the two API a=
re same. I haven't look at the LevelDB but I suspect it's similar.

Eh, I don't think it's the same. By default WriteOption.disableWAL is
false in our ceph side, and submit_transaction will use
WriteOption.sync=3Dfalse and submit_transaction_sync will use
WriteOption.sync=3Dtrue.

If sync=3D=3Dfase, rocksdb won't sync log file, otherwise it will call
fsync/fdatasync to flush log file.

Plz correct me if not. :-)

>
>         I just re-read the Newstore code, seems the workflow is not a=
s that we want. We issue a bunch of submit_transaction and in the _kv_s=
ync_thread we try to have a checkpoint that ensure previous transaction=
 are persistent, by using submit_transcation_sync to submit an empty tr=
ansaction.  But actually
>         1. the submit_transaction is already a synchronized call so t=
he empty transcation in _kv_sync_thread is kind of waste.
>         2. An sync transaction cannot ensure the previous transaction=
 is also synced. The API doesn't guarantee this, and from implementatio=
n, this two transactions may goes to different WAL files.
>
>         Yes, if we want, we can have a Queue and Thread that collecti=
ng the transactions and merge them to a big transaction , some ::fdatas=
ync will be saved here. But this approach looks complex.
>
>         Some optimizations in my mind are:
>         1. Batch the cleanup operations in _apply_wal_transaction, we=
 don=E2=80=99t need to synchronized remove the WAL item, we can just pu=
t them into kv_sync_thread_Q and let kv_sync_thread to form a batch tra=
nsaction that deleted a bunch of key.
>         2. We don't need the empty transaction in kv_sync_thread, we =
could call the _txc_kv_finish_kv directly from _txc_submit_kv,  since t=
he KV is synchronized.
>                 3.  Then we can rename _kv_sync_thread to _kv_cleanup=
_thread to better descript its work.
>
>         How do you think
>
>                                                                      =
                                                   Xiaoxi
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Tuesday, April 21, 2015 12:48 AM
> To: Chen, Xiaoxi
> Cc: Mark Nelson; Somnath Roy; Duan, Jiangang; Zhang, Jian; ceph-devel
> Subject: Re: =E5=9B=9E=E5=A4=8D: Re: NewStore performance analysis
>
> On Mon, 20 Apr 2015, Chen, Xiaoxi wrote:
>> > > An easy way to measure might be comment out
>> > > db->submit_transaction(txc->t); in NewStore::_txc_submit_kv, to
>> > > db->see if
>> > > we can get more QD in fragment part without issuing the DB.
>> >
>> > I'm not sure I totally understand the interface.. my assumption is
>> > that queue_transaction will give rocksdb the txn to commit wheneve=
r
>> > it finds it convenient (no idea what policy is used there) and
>> > queue_transaction_sync will trigger a commit now.  If we did have
>> > multiple threads doing queue_trandsaction_sync (by, say, calling i=
t
>> > directly in _txc_submit_kv) would qa go up?
>> >
>> I think you might miss something, currently the two interface are
>> exactly the SAME unless you set rocksdb-disable-sync=3Dtrue(which is
>> false by default).
>>
>> When commit, rocksdb will write the content to both memtable(write
>> buffer) and WAL. if the transaction doesnt go with sync, it will als=
o
>> commit now,but the write to WAL will NOT be sync(by calling fdatasyn=
c).
>> That means we may lose data if power failure/kernel panic. This is w=
hy
>> i changed the default rocksdb-disable-sync from true to false in
>> previous patch.
>
> Yeah, I'm confused.  :)
>
> So now 'rocksdb disable sync =3D false', which seems to be obviously =
what we want for newstore.  It's different for filestore, which is doin=
g a syncfs checkpoint.  Perhaps we should have newstore set that explic=
itly instead of passing through a config option.
>
> In any case, though, I'm confused by
>
>> if the transaction doesnt go with sync, it will also commit now,but
>> the write to WAL will NOT be sync(by calling fdatasync).
>
> What does it mean to 'commit' but not call fdatasync?  What does comm=
it mean in this case?
>
> And, and I correct in understanding that we have
>
>  queue_transaction -- queue a transaction but don't block waiting for=
 fdatasync  queue_transaction_sync -- queue transaction and wait until =
it is stable on disk
>
> to work with?
>
> Thanks!
> sage



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
