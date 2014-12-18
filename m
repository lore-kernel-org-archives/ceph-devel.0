From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 18 Dec 2014 06:19:52 -0800
Message-ID: <5492e2883e026_2d7f3833302883@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:56458 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaLROTx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Dec 2014 09:19:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

5 new defect(s) introduced to ceph found with Coverity Scan.
4 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 5 of 5 defect(s)


** CID 1258786:  Unchecked dynamic_cast  (FORWARD_NULL)
/osd/ECBackend.cc: 839 in ECBackend::handle_sub_write(pg_shard_t, std::tr1::shared_ptr<OpRequest>, ECSubWrite &, Context *)()

** CID 1258787:  Resource leak  (RESOURCE_LEAK)
/osd/OSD.cc: 6118 in OSD::handle_osd_map(MOSDMap *)()

** CID 1258789:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MClientCaps.h: 132 in MClientCaps::MClientCaps(int, inodeno_t, inodeno_t, unsigned long, int, unsigned int)()

** CID 1258790:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MClientCaps.h: 118 in MClientCaps::MClientCaps(int, inodeno_t, inodeno_t, unsigned long, long, int, int, int, int, unsigned int)()

** CID 1258788:  Uninitialized scalar field  (UNINIT_CTOR)
/librados/IoCtxImpl.cc: 44 in librados::IoCtxImpl::IoCtxImpl(librados::RadosClient *, Objecter *, int, const char *, snapid_t)()


________________________________________________________________________________________________________
*** CID 1258786:  Unchecked dynamic_cast  (FORWARD_NULL)
/osd/ECBackend.cc: 839 in ECBackend::handle_sub_write(pg_shard_t, std::tr1::shared_ptr<OpRequest>, ECSubWrite &, Context *)()
833         op.updated_hit_set_history,
834         op.trim_to,
835         op.trim_rollback_to,
836         !(op.t.empty()),
837         localt);
838     
>>>     CID 1258786:  Unchecked dynamic_cast  (FORWARD_NULL)
>>>     Dynamic cast to pointer "dynamic_cast <ReplicatedPG *>(this->get_parent())" can return "NULL".
839       if (!(dynamic_cast<ReplicatedPG *>(get_parent())->is_undersized()) &&
840           get_parent()->whoami_shard().shard >= ec_impl->get_data_chunk_count())
841         op.t.set_fadvise_flag(CEPH_OSD_OP_FLAG_FADVISE_DONTNEED);
842     
843       localt->append(op.t);
844       if (on_local_applied_sync) {

________________________________________________________________________________________________________
*** CID 1258787:  Resource leak  (RESOURCE_LEAK)
/osd/OSD.cc: 6118 in OSD::handle_osd_map(MOSDMap *)()
6112     		<< dendl;
6113     	clog->warn() << "failed to encode map e" << e << " with expected crc\n";
6114     	MMonGetOSDMap *req = new MMonGetOSDMap;
6115     	req->request_full(e, last);
6116     	monc->send_mon_message(req);
6117     	last = e - 1;
>>>     CID 1258787:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "o" going out of scope leaks the storage it points to.
6118     	break;
6119           }
6120     
6121     
6122           hobject_t fulloid = get_osdmap_pobject_name(e);
6123           t.write(META_COLL, fulloid, 0, fbl.length(), fbl);

________________________________________________________________________________________________________
*** CID 1258789:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MClientCaps.h: 132 in MClientCaps::MClientCaps(int, inodeno_t, inodeno_t, unsigned long, int, unsigned int)()
126         head.ino = ino;
127         head.realm = realm;
128         head.cap_id = id;
129         head.migrate_seq = mseq;
130         peer.cap_id = 0;
131         inline_version = 0;
>>>     CID 1258789:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member field "peer.flags" is not initialized in this constructor nor in any functions that it calls.
132       }
133     private:
134       ~MClientCaps() {}
135     
136     public:
137       const char *get_type_name() const { return "Cfcap";}

________________________________________________________________________________________________________
*** CID 1258790:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MClientCaps.h: 118 in MClientCaps::MClientCaps(int, inodeno_t, inodeno_t, unsigned long, long, int, int, int, int, unsigned int)()
112         head.caps = caps;
113         head.wanted = wanted;
114         head.dirty = dirty;
115         head.migrate_seq = mseq;
116         peer.cap_id = 0;
117         inline_version = 0;
>>>     CID 1258790:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member field "peer.flags" is not initialized in this constructor nor in any functions that it calls.
118       }
119       MClientCaps(int op,
120     	      inodeno_t ino, inodeno_t realm,
121     	      uint64_t id, int mseq, epoch_t oeb)
122         : Message(CEPH_MSG_CLIENT_CAPS, HEAD_VERSION, COMPAT_VERSION),
123           osd_epoch_barrier(oeb){

________________________________________________________________________________________________________
*** CID 1258788:  Uninitialized scalar field  (UNINIT_CTOR)
/librados/IoCtxImpl.cc: 44 in librados::IoCtxImpl::IoCtxImpl(librados::RadosClient *, Objecter *, int, const char *, snapid_t)()
38       : ref_cnt(0), client(c), poolid(poolid), pool_name(pool_name), snap_seq(s),
39         assert_ver(0), notify_timeout(c->cct->_conf->client_notify_timeout),
40         oloc(poolid),
41         aio_write_list_lock("librados::IoCtxImpl::aio_write_list_lock"),
42         aio_write_seq(0), objecter(objecter)
43     {
>>>     CID 1258788:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "last_objver" is not initialized in this constructor nor in any functions that it calls.
44     }
45     
46     void librados::IoCtxImpl::set_snap_read(snapid_t s)
47     {
48       if (!s)
49         s = CEPH_NOSNAP;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

