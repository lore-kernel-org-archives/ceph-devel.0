From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 09 Jan 2015 06:30:48 -0800
Message-ID: <54afe6184d25_40e4fa5334803de@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:53545 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbAIOas (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 09:30:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1262114:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MOSDRepOp.h: 107 in MOSDRepOp::MOSDRepOp()()

** CID 1262115:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MOSDRepOpReply.h: 97 in MOSDRepOpReply::MOSDRepOpReply()()


________________________________________________________________________________________________________
*** CID 1262114:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MOSDRepOp.h: 107 in MOSDRepOp::MOSDRepOp()()
101         ::encode(from, payload);
102         ::encode(updated_hit_set_history, payload);
103         ::encode(pg_trim_rollback_to, payload);
104       }
105     
106       MOSDRepOp()
>>>     CID 1262114:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "acks_wanted" is not initialized in this constructor nor in any functions that it calls.
107         : Message(MSG_OSD_REPOP, HEAD_VERSION, COMPAT_VERSION) { }
108       MOSDRepOp(osd_reqid_t r, pg_shard_t from,
109     	    spg_t p, const hobject_t& po, int aw,
110     	    epoch_t mape, ceph_tid_t rtid, eversion_t v)
111         : Message(MSG_OSD_REPOP, HEAD_VERSION, COMPAT_VERSION),
112           map_epoch(mape),

________________________________________________________________________________________________________
*** CID 1262115:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MOSDRepOpReply.h: 97 in MOSDRepOpReply::MOSDRepOpReply()()
91         from(from),
92         pgid(req->pgid.pgid, req->from.shard),
93         ack_type(at),
94         result(result_) {
95         set_tid(req->get_tid());
96       }
>>>     CID 1262115:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "result" is not initialized in this constructor nor in any functions that it calls.
97       MOSDRepOpReply() : Message(MSG_OSD_REPOPREPLY) {}
98     private:
99       ~MOSDRepOpReply() {}
100     
101     public:
102       const char *get_type_name() const { return "osd_repop_reply"; }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

