From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Mon, 22 Aug 2016 07:33:28 +0000
Message-ID: <BL2PR02MB2115FFBBBF5A04D62910A239F4E80@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608102121090.17770@piezo.us.to>
 <BL2PR02MB2115CDD714FC3883028291F8F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608111629170.17762@piezo.us.to>
 <7dc67e25-4e1c-09a1-8667-ee47572b9290@redhat.com>
 <alpine.DEB.2.11.1608111635230.17762@piezo.us.to>
 <BL2PR02MB2115D3D79C6194FD81E598F3F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608112226280.17762@piezo.us.to>
 <BL2PR02MB2115BB77EA5BA38BCF48E52DF4110@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608151952230.14754@piezo.us.to>
 <BL2PR02MB21150BE782012D52DBB8FF26F4130@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:28324
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754656AbcHVHdd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 03:33:33 -0400
In-Reply-To: <BL2PR02MB21150BE782012D52DBB8FF26F4130@BL2PR02MB2115.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
Got the following asserts on two different path with the latest master.

1.
os/bluestore/BlueFS.cc: 1377: FAILED assert(h->file->fnode.ino !=3D 1)

 ceph version 11.0.0-1688-g6f48ee6 (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea=
4)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0=
x80) [0x55f0d46f9cd0]
 2: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, unsigned long=
)+0x1bed) [0x55f0d43cb34d]
 3: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xa7) [0x55f0d43cb467]
 4: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&, unsigned lo=
ng, unsigned long)+0x3b2) [0x55f0d43ccf12]
 5: (BlueFS::_fsync(BlueFS::FileWriter*, std::unique_lock<std::mutex>&)+0x3=
5b) [0x55f0d43ce2fb]
 6: (BlueRocksWritableFile::Sync()+0x62) [0x55f0d43e5c32]
 7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x2d1) [0x55f0d456f4f1=
]
 8: (rocksdb::WritableFileWriter::Sync(bool)+0xf0) [0x55f0d45709a0]
 9: (rocksdb::CompactionJob::FinishCompactionOutputFile(rocksdb::Status con=
st&, rocksdb::CompactionJob::SubcompactionState*)+0x4e6) [0x55f0d45b2506]
 10: (rocksdb::CompactionJob::ProcessKeyValueCompaction(rocksdb::Compaction=
Job::SubcompactionState*)+0x14ea) [0x55f0d45b4cca]
 11: (rocksdb::CompactionJob::Run()+0x479) [0x55f0d45b5c49]
 12: (rocksdb::DBImpl::BackgroundCompaction(bool*, rocksdb::JobContext*, ro=
cksdb::LogBuffer*, void*)+0x9c0) [0x55f0d44a4610]
 13: (rocksdb::DBImpl::BackgroundCallCompaction(void*)+0xbf) [0x55f0d44b147=
f]
 14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1d9) [0x55f0d4568079]
 15: (()+0x98f113) [0x55f0d4568113]
 16: (()+0x76fa) [0x7f06101576fa]
 17: (clone()+0x6d) [0x7f060dfb7b5d]


2.

5700 time 2016-08-21 23:15:50.962450
os/bluestore/BlueFS.cc: 1377: FAILED assert(h->file->fnode.ino !=3D 1)

 ceph version 11.0.0-1688-g6f48ee6 (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea=
4)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0=
x80) [0x55d9959bfcd0]
 2: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long, unsigned long=
)+0x1bed) [0x55d99569134d]
 3: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xa7) [0x55d995691467]
 4: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&, unsigned lo=
ng, unsigned long)+0x3b2) [0x55d995692f12]
 5: (BlueFS::sync_metadata()+0x1c3) [0x55d995697c33]
 6: (BlueRocksDirectory::Fsync()+0xd) [0x55d9956ab98d]
 7: (rocksdb::DBImpl::WriteImpl(rocksdb::WriteOptions const&, rocksdb::Writ=
eBatch*, rocksdb::WriteCallback*, unsigned long*, unsigned long, bool)+0x13=
fa) [0x55d995778c2a]
 8: (rocksdb::DBImpl::Write(rocksdb::WriteOptions const&, rocksdb::WriteBat=
ch*)+0x2a) [0x55d9957797aa]
 9: (RocksDBStore::submit_transaction_sync(std::shared_ptr<KeyValueDB::Tran=
sactionImpl>)+0x6b) [0x55d99573cb5b]
 10: (BlueStore::_kv_sync_thread()+0x1745) [0x55d995589e65]
 11: (BlueStore::KVSyncThread::entry()+0xd) [0x55d9955b754d]
 12: (Thread::entry_wrapper()+0x75) [0x55d99599f5e5]
 13: (()+0x76fa) [0x7f8a0bdde6fa]
 14: (clone()+0x6d) [0x7f8a09c3eb5d]


I saw this assert is newly introduced in the code.
FYI, I was running rocksdb by enabling universal style compaction during th=
is time.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel=
.org] On Behalf Of Somnath Roy
Sent: Tuesday, August 16, 2016 12:45 PM
To: Sage Weil
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

Sage,
The replay bug *is fixed* with your patch. I am able to make the OSDs (and =
cluster) up after hitting the db assertion bug.
Presently, I am trying to root cause the debug the db assertion issue.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Monday, August 15, 2016 12:54 PM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

On Sun, 14 Aug 2016, Somnath Roy wrote:
> Sage,
> I did this..
>=20
> root@emsnode5:~/ceph-master/src# git diff diff --git=20
> a/src/kv/RocksDBStore.cc b/src/kv/RocksDBStore.cc index
> 638d231..bcf0935 100644
> --- a/src/kv/RocksDBStore.cc
> +++ b/src/kv/RocksDBStore.cc
> @@ -370,6 +370,10 @@ int RocksDBStore::submit_transaction(KeyValueDB::Tra=
nsaction t)
>    utime_t lat =3D ceph_clock_now(g_ceph_context) - start;
>    logger->inc(l_rocksdb_txns);
>    logger->tinc(l_rocksdb_submit_latency, lat);
> +  if (!s.ok()) {
> +    derr << __func__ << " error: " << s.ToString()
> +        << "code =3D " << s.code() << dendl;  }
>    return s.ok() ? 0 : -1;
>  }
>=20
> @@ -385,6 +389,11 @@ int RocksDBStore::submit_transaction_sync(KeyValueDB=
::Transaction t)
>    utime_t lat =3D ceph_clock_now(g_ceph_context) - start;
>    logger->inc(l_rocksdb_txns_sync);
>    logger->tinc(l_rocksdb_submit_sync_latency, lat);
> +  if (!s.ok()) {
> +    derr << __func__ << " error: " << s.ToString()
> +        << "code =3D " << s.code() << dendl;  }
> +
>    return s.ok() ? 0 : -1;
>  }
>  int RocksDBStore::get_info_log_level(string info_log_level) @@ -442,7
> +451,8 @@ void RocksDBStore::RocksDBTransactionImpl::rmkey(const
> string &prefix,  void RocksDBStore::RocksDBTransactionImpl::rm_single_key=
(const string &prefix,
>                                                          const string
> &k)  {
> -  bat->SingleDelete(combine_strings(prefix, k));
> +  //bat->SingleDelete(combine_strings(prefix, k));
> + bat->Delete(combine_strings(prefix, k));
>  }
>=20
> But, the db crash is still happening with the following log message.
>=20
> rocksdb: submit_transaction_sync error: NotFound: code =3D 1
>=20
> It seems it is not related to rm_single_key as I am hitting this from  ht=
tps://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc#L5108 =
as well where rm_single_key is not called.
> May be I should dump the transaction and see what's in there ?

Yeah.  Unfortunately I think it isn't trivial to dump the kv transactions b=
ecause they're being constructed by rocksdb (WriteBack or something). =20
Not sure if there is a dump for that (I'm guessing not?).  You'd need to wr=
ite one, or build a kludgey lookaside map that can be dumped.
=20
> I am hitting the BlueFS replay bug I mentioned earlier and applied your p=
atch (https://github.com/ceph/ceph/pull/10686) but not helping.
> Is it because I needed to run with this patch from the beginning and not =
just during replay ?

Yeah, the bug happens before replay.. we are writing a bad entry into the b=
luefs log.

sage


>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, August 11, 2016 3:32 PM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> On Thu, 11 Aug 2016, Somnath Roy wrote:
> > Sage,
> > Regarding the db assert , I hit that again on multiple OSDs while I was=
 populating 40TB rbd images (~35TB written before crash).
> > I did the following changes in the code..
> >=20
> > @@ -370,7 +370,7 @@ int RocksDBStore::submit_transaction(KeyValueDB::Tr=
ansaction t)
> >    utime_t lat =3D ceph_clock_now(g_ceph_context) - start;
> >    logger->inc(l_rocksdb_txns);
> >    logger->tinc(l_rocksdb_submit_latency, lat);
> > -  return s.ok() ? 0 : -1;
> > +  return s.ok() ? 0 : -s.code();
> >  }
> >=20
> >  int RocksDBStore::submit_transaction_sync(KeyValueDB::Transaction
> > t) @@ -385,7 +385,7 @@ int RocksDBStore::submit_transaction_sync(KeyVal=
ueDB::Transaction t)
> >    utime_t lat =3D ceph_clock_now(g_ceph_context) - start;
> >    logger->inc(l_rocksdb_txns_sync);
> >    logger->tinc(l_rocksdb_submit_sync_latency, lat);
> > -  return s.ok() ? 0 : -1;
> > +  return s.ok() ? 0 : -s.code();
> >  }
> >  int RocksDBStore::get_info_log_level(string info_log_level)  { diff=20
> > --git a/src/os/bluestore/BlueStore.cc=20
> > b/src/os/bluestore/BlueStore.cc index fe7f743..3f4ecd5 100644
> > --- a/src/os/bluestore/BlueStore.cc
> > +++ b/src/os/bluestore/BlueStore.cc
> > @@ -4989,6 +4989,9 @@ void BlueStore::_kv_sync_thread()
> >              ++it) {
> >           _txc_finalize_kv((*it), (*it)->t);
> >           int r =3D db->submit_transaction((*it)->t);
> > +          if (r < 0 ) {
> > +            dout(0) << "submit_transaction returned =3D " << r << dend=
l;
> > +          }
> >           assert(r =3D=3D 0);
> >         }
> >        }
> > @@ -5026,6 +5029,10 @@ void BlueStore::_kv_sync_thread()
> >         t->rm_single_key(PREFIX_WAL, key);
> >        }
> >        int r =3D db->submit_transaction_sync(t);
> > +      if (r < 0 ) {
> > +        dout(0) << "submit_transaction_sync returned =3D " << r << den=
dl;
> > +      }
> > +
> >        assert(r =3D=3D 0);
> >=20
> >=20
> > This is printing -1 in the log before asset. So, the corresponding code=
 from the rocksdb side is "kNotFound".
> > It is not related to space as I hit this same issue irrespective of db =
partition size is 100G or 300G.
> > It seems some kind of corruption within Bluestore ?
> > Let me now the next step.
>=20
> Can you add this too?
>=20
> diff --git a/src/kv/RocksDBStore.cc b/src/kv/RocksDBStore.cc index
> 638d231..b5467f7 100644
> --- a/src/kv/RocksDBStore.cc
> +++ b/src/kv/RocksDBStore.cc
> @@ -370,6 +370,9 @@ int
> RocksDBStore::submit_transaction(KeyValueDB::Transaction t)
>    utime_t lat =3D ceph_clock_now(g_ceph_context) - start;
>    logger->inc(l_rocksdb_txns);
>    logger->tinc(l_rocksdb_submit_latency, lat);
> +  if (!s.ok()) {
> +    derr << __func__ << " error: " << s.ToString() << dendl;  }
>    return s.ok() ? 0 : -1;
>  }
> =20
> It's not obvious to me how we would get NotFound when doing a Write into =
the kv store.
>=20
> Thanks!
> sage
>=20
> >=20
> > Thanks & Regards
> > Somnath
> >=20
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Thursday, August 11, 2016 9:36 AM
> > To: Mark Nelson
> > Cc: Somnath Roy; ceph-devel
> > Subject: Re: Bluestore assert
> >=20
> > On Thu, 11 Aug 2016, Mark Nelson wrote:
> > > Sorry if I missed this during discussion, but why are these being=20
> > > called if the file is deleted?
> >=20
> > I'm not sure... rocksdb is the one consuming the interface.  Looking th=
rough the code, though, this is the only way I can see that we could log an=
 op_file_update *after* an op_file_remove.
> >=20
> > sage
> >=20
> > >
> > > Mark
> > >
> > > On 08/11/2016 11:29 AM, Sage Weil wrote:
> > > > On Thu, 11 Aug 2016, Somnath Roy wrote:
> > > > > Sage,
> > > > > Please find the full log for the BlueFS replay bug in the=20
> > > > > following location.
> > > > >
> > > > > https://github.com/somnathr/ceph/blob/master/ceph-osd.1.log.zi
> > > > > p
> > > > >
> > > > > For the db transaction one , I have added code to dump the=20
> > > > > rocksdb error code before the assert as you suggested and waiting=
 to reproduce.
> > > >
> > > > I'm pretty sure this is the root cause:
> > > >
> > > > https://github.com/ceph/ceph/pull/10686
> > > >
> > > > sage
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe=20
> > > > ceph-devel" in the body of a message to=20
> > > > majordomo@vger.kernel.org More majordomo info at=20
> > > > http://vger.kernel.org/majordomo-info.html
> > > >
> > >
> > >
> > PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that you have received this message in error and that any review, d=
issemination, distribution, or copying of this message is strictly prohibit=
ed. If you have received this communication in error, please notify the sen=
der by telephone or e-mail (as shown above) immediately and destroy any and=
 all copies of this message in your possession (whether hard copies or elec=
tronically stored copies).
> >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in th=
e body of a message to majordomo@vger.kernel.org More majordomo info at  ht=
tp://vger.kernel.org/majordomo-info.html
