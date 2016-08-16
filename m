From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Tue, 16 Aug 2016 19:45:01 +0000
Message-ID: <BL2PR02MB21150BE782012D52DBB8FF26F4130@BL2PR02MB2115.namprd02.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:41818
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751651AbcHPTpG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Aug 2016 15:45:06 -0400
In-Reply-To: <alpine.DEB.2.11.1608151952230.14754@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
The replay bug *is fixed* with your patch. I am able to make the OSDs (and =
cluster) up after hitting the db assertion bug.
Presently, I am trying to root cause the debug the db assertion issue.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]=20
Sent: Monday, August 15, 2016 12:54 PM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

On Sun, 14 Aug 2016, Somnath Roy wrote:
> Sage,
> I did this..
>=20
> root@emsnode5:~/ceph-master/src# git diff diff --git=20
> a/src/kv/RocksDBStore.cc b/src/kv/RocksDBStore.cc index=20
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
>  int RocksDBStore::get_info_log_level(string info_log_level) @@ -442,7=20
> +451,8 @@ void RocksDBStore::RocksDBTransactionImpl::rmkey(const=20
> string &prefix,  void RocksDBStore::RocksDBTransactionImpl::rm_single_key=
(const string &prefix,
>                                                          const string=20
> &k)  {
> -  bat->SingleDelete(combine_strings(prefix, k));
> +  //bat->SingleDelete(combine_strings(prefix, k)); =20
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
> >  int RocksDBStore::submit_transaction_sync(KeyValueDB::Transaction=20
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
> diff --git a/src/kv/RocksDBStore.cc b/src/kv/RocksDBStore.cc index=20
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
> > > > majordomo@vger.kernel.org More majordomo info at =20
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
