From: Sage Weil <sweil@redhat.com>
Subject: RE: Bluestore assert
Date: Thu, 11 Aug 2016 22:32:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608112226280.17762@piezo.us.to>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608102121090.17770@piezo.us.to> <BL2PR02MB2115CDD714FC3883028291F8F41E0@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608111629170.17762@piezo.us.to>
 <7dc67e25-4e1c-09a1-8667-ee47572b9290@redhat.com> <alpine.DEB.2.11.1608111635230.17762@piezo.us.to> <BL2PR02MB2115D3D79C6194FD81E598F3F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbcHKWcG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 18:32:06 -0400
In-Reply-To: <BL2PR02MB2115D3D79C6194FD81E598F3F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 11 Aug 2016, Somnath Roy wrote:
> Sage,
> Regarding the db assert , I hit that again on multiple OSDs while I was populating 40TB rbd images (~35TB written before crash).
> I did the following changes in the code..
> 
> @@ -370,7 +370,7 @@ int RocksDBStore::submit_transaction(KeyValueDB::Transaction t)
>    utime_t lat = ceph_clock_now(g_ceph_context) - start;
>    logger->inc(l_rocksdb_txns);
>    logger->tinc(l_rocksdb_submit_latency, lat);
> -  return s.ok() ? 0 : -1;
> +  return s.ok() ? 0 : -s.code();
>  }
> 
>  int RocksDBStore::submit_transaction_sync(KeyValueDB::Transaction t)
> @@ -385,7 +385,7 @@ int RocksDBStore::submit_transaction_sync(KeyValueDB::Transaction t)
>    utime_t lat = ceph_clock_now(g_ceph_context) - start;
>    logger->inc(l_rocksdb_txns_sync);
>    logger->tinc(l_rocksdb_submit_sync_latency, lat);
> -  return s.ok() ? 0 : -1;
> +  return s.ok() ? 0 : -s.code();
>  }
>  int RocksDBStore::get_info_log_level(string info_log_level)
>  {
> diff --git a/src/os/bluestore/BlueStore.cc b/src/os/bluestore/BlueStore.cc
> index fe7f743..3f4ecd5 100644
> --- a/src/os/bluestore/BlueStore.cc
> +++ b/src/os/bluestore/BlueStore.cc
> @@ -4989,6 +4989,9 @@ void BlueStore::_kv_sync_thread()
>              ++it) {
>           _txc_finalize_kv((*it), (*it)->t);
>           int r = db->submit_transaction((*it)->t);
> +          if (r < 0 ) {
> +            dout(0) << "submit_transaction returned = " << r << dendl;
> +          }
>           assert(r == 0);
>         }
>        }
> @@ -5026,6 +5029,10 @@ void BlueStore::_kv_sync_thread()
>         t->rm_single_key(PREFIX_WAL, key);
>        }
>        int r = db->submit_transaction_sync(t);
> +      if (r < 0 ) {
> +        dout(0) << "submit_transaction_sync returned = " << r << dendl;
> +      }
> +
>        assert(r == 0);
> 
> 
> This is printing -1 in the log before asset. So, the corresponding code from the rocksdb side is "kNotFound".
> It is not related to space as I hit this same issue irrespective of db partition size is 100G or 300G.
> It seems some kind of corruption within Bluestore ?
> Let me now the next step.

Can you add this too?

diff --git a/src/kv/RocksDBStore.cc b/src/kv/RocksDBStore.cc
index 638d231..b5467f7 100644
--- a/src/kv/RocksDBStore.cc
+++ b/src/kv/RocksDBStore.cc
@@ -370,6 +370,9 @@ int 
RocksDBStore::submit_transaction(KeyValueDB::Transaction t)
   utime_t lat = ceph_clock_now(g_ceph_context) - start;
   logger->inc(l_rocksdb_txns);
   logger->tinc(l_rocksdb_submit_latency, lat);
+  if (!s.ok()) {
+    derr << __func__ << " error: " << s.ToString() << dendl;
+  }
   return s.ok() ? 0 : -1;
 }
 
It's not obvious to me how we would get NotFound when doing a Write 
into the kv store.

Thanks!
sage

> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, August 11, 2016 9:36 AM
> To: Mark Nelson
> Cc: Somnath Roy; ceph-devel
> Subject: Re: Bluestore assert
> 
> On Thu, 11 Aug 2016, Mark Nelson wrote:
> > Sorry if I missed this during discussion, but why are these being
> > called if the file is deleted?
> 
> I'm not sure... rocksdb is the one consuming the interface.  Looking through the code, though, this is the only way I can see that we could log an op_file_update *after* an op_file_remove.
> 
> sage
> 
> >
> > Mark
> >
> > On 08/11/2016 11:29 AM, Sage Weil wrote:
> > > On Thu, 11 Aug 2016, Somnath Roy wrote:
> > > > Sage,
> > > > Please find the full log for the BlueFS replay bug in the
> > > > following location.
> > > >
> > > > https://github.com/somnathr/ceph/blob/master/ceph-osd.1.log.zip
> > > >
> > > > For the db transaction one , I have added code to dump the rocksdb
> > > > error code before the assert as you suggested and waiting to reproduce.
> > >
> > > I'm pretty sure this is the root cause:
> > >
> > > https://github.com/ceph/ceph/pull/10686
> > >
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> >
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
