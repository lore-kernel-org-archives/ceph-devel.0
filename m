From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: FileStore performance: coalescing operations
Date: Thu, 26 Feb 2015 15:28:07 +0100
Message-ID: <20150226152807.5b71a93c@doppio>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/QrQxbL0Rww6oG8iak.iXdR/"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:64131 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbbBZO2M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 09:28:12 -0500
Received: from itxmail.itxperts.de (qgate_dmz.itxperts.de [192.168.160.1])
	by mail.itxperts.de (8.14.0/8.14.0) with ESMTP id t1QESAUd028173
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 15:28:10 +0100
Received: from doppio (doppio.itxperts.de [192.168.140.7])
	by itxmail.itxperts.de (Postfix) with ESMTP id 9F80313F02
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 15:19:52 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

--MP_/QrQxbL0Rww6oG8iak.iXdR/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

during the performance weely meeting, I had mentioned
my experiences concerning the transaction structure
for write requests at the level of the FileStore.
Such a transaction not only contains the OP_WRITE
operation to the object in the file system, but also
a series of OP_OMAP_SETKEYS and OP_SETATTR operations.

Find attached a README and source code patch, which
describe a prototype for coalescing the OP_OMAP_SETKEYS
operations and the performance impact f this change.

Regards

Andreas Bluemle

-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm

--MP_/QrQxbL0Rww6oG8iak.iXdR/
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=ceph-master.file-store-omap_setkeys-colaescing.patch

diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index f6c3bb8..29382b2 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -2260,10 +2260,24 @@ int FileStore::_check_replay_guard(int fd, const SequencerPosition& spos)
   }
 }
 
+void FileStore::_coalesce(map<string, bufferlist> &target, map<string, bufferlist> &source)
+{
+  for (map<string, bufferlist>::iterator p = source.begin();
+       p != source.end();
+       p++) {
+    target[p->first] = p->second;
+  }
+  return;
+}
+
 unsigned FileStore::_do_transaction(
   Transaction& t, uint64_t op_seq, int trans_num,
   ThreadPool::TPHandle *handle)
 {
+  map<string, bufferlist> collected_aset;
+  coll_t collected_cid;
+  ghobject_t collected_oid;
+
   dout(10) << "_do_transaction on " << &t << dendl;
 
 #ifdef WITH_LTTNG
@@ -2282,6 +2296,22 @@ unsigned FileStore::_do_transaction(
 
     _inject_failure();
 
+    if (op->op == Transaction::OP_OMAP_SETKEYS) {
+	collected_cid = i.get_cid(op->cid);
+	collected_oid = i.get_oid(op->oid);
+	map<string, bufferlist> aset;
+	i.decode_attrset(aset);
+	_coalesce(collected_aset, aset);
+	continue;
+    } else {
+	if (collected_aset.empty() == false) {
+	  tracepoint(objectstore, omap_setkeys_enter, osr_name);
+	  r = _omap_setkeys(collected_cid, collected_oid, collected_aset, spos);
+	  tracepoint(objectstore, omap_setkeys_exit, r);
+	  collected_aset.clear();
+	}
+    }
+
     switch (op->op) {
     case Transaction::OP_NOP:
       break;
diff --git a/src/os/FileStore.h b/src/os/FileStore.h
index af1fb8d..a039731 100644
--- a/src/os/FileStore.h
+++ b/src/os/FileStore.h
@@ -449,6 +449,8 @@ public:
 
   int statfs(struct statfs *buf);
 
+  void _coalesce( map<string, bufferlist> &target, map<string, bufferlist> &source);
+
   int _do_transactions(
     list<Transaction*> &tls, uint64_t op_seq,
     ThreadPool::TPHandle *handle);

--MP_/QrQxbL0Rww6oG8iak.iXdR/
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=README.file-store-coalescing

Q29hbGVzY2luZyBPTUFQX1NFVEtFWVMgb3BlcmF0aW9ucyBpbiBhIHdyaXRlIHRyYW5zYWN0aW9u
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkRlc2NyaXB0aW9uDQotLS0tLS0tLS0tLQ0KDQpBdCB0aGUgbGV2ZWwgb2YgRmlsZVN0b3Jl
LCBldmVyeSB3cml0ZSByZXF1ZXN0IGlzIGVtYmVkZGVkIGluIGEgdHJhbnNhY3Rpb24NCndoaWNo
IGNvbnNpc3RzIG9mDQogIDYga2V5LXZhbHVlIHBhaXIgc2V0dGluZ3MgaW4gMyBPTUFQX1NFVEtF
WVMgb3BlcmF0aW9ucw0KICB0aGUgYWN0dWFsIE9QX1dSSVRFDQogIDIgc2V0dGluZ3MgaW4gdGhl
IGV4dGVuZGVkIGZpbGUgc3lzdGVtIGF0dHJpYnV0ZXMuDQoNClRoZSBtb2RpZmljYXRpb24gb2Yg
dGhlIEZpbGVTdG9yZTo6X2RvX3RyYW5zYWN0aW9uKCkgY29hbGVzY2VzIHRoZQ0KNiBrZXktdmFs
dWUgcGFpcnMgaW50byBhIHNpbmdsZSBvcGVyYXRpb24sIHdpdGggdGhlIHNpZGUgZWZmZWN0IG9m
DQpyZWR1Y2luZyB0aGUgbnVtYmVyIG9mIGtleS12YWx1ZSBwYWlycyB0byA1OiBvbmUga2V5IGFw
cGVhcnMgdHdpY2UNCmFuZCBvbmx5IHRoZSBsYXN0IHZhbHVlcyBpcyBnb2luZyB0byBiZSBzZXQu
DQoNClBlcmZvcm1hbmNlIGltcHJvdmVtZW50DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpD
bHVzdGVyIHdpdGggMyBzdG9yYWdlIG5vZGVzLCA0IG9zZCAoU0FTIGRpc2ssIFNTRCBqb3VybmFs
KSBwZXIgbm9kZSwNCnNlcGFyYXRlIGNsaWVudCBub2RlIHdpdGggcmJkIHVzaW5nIHRoZSBrZXJu
ZWwgY2xpZW50cywNCnRlc3QgbG9hZCBnZW5lcmF0ZWQgYnkgZmlvLCByYW5kb24gd3JpdGUsIDRL
IGJsb2NrIHNpemUsIGlvZGVwdGggMTYuDQoNCmNsaWVudCBpbXByb3ZlbWVudDogYXBwcm94LiA1
ICUgKDEyODkwIGlvcHMgdnMuIDEzMzY5IGlvcHMpDQpzdG9yYWdlIG5vZGUgaW1wcm92ZW1lbnQ6
IHJlZHVjdGlvbiBpbiBDUFUgY29uc3VwdGlvbSBvZiBjZXBoLW9zZCBkYWVtb24NCmJ5IDEwJTsg
c2VlIGZvbGx3b2luZyB0YWJsZSAoZGVyaXZlZCBmcm9tIC9wcm9jLzxwaWQ+L3NjaGVkc3RhdDoN
Cg0KDQpjZXBoLW9zZCBwcm9jZXNzIGFuZCAgICAgICAgICAgICBDUFUgdXNhZ2UgICAgICAgICB8
IENQVSB1c2FnZQ0KdGhyZWFkIGNsYXNzZXMgICAgICAgICAgICAgICAgICAgdjAuOTEgdW5tb2Rp
ZmllZCAgfCB2MC45MSB3aXRoIGNvYWxlc2NpbmcNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQp0b3RhbCBj
cHUgdXNhZ2U6ICAgICAgICAgICAgICAgICA0My4xNyBDUFUtc2Vjb25kcyB8IDM5LjMzIENQVS1z
ZWNvbmRzDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8DQpUaHJlYWRQb29sOjpXb3JrVGhyZWFkOjplbnRyeSgpOiAxNS41NiAgIDM2LjA0JSAgICB8
IDEyLjQ1ICAgMzEuNjYlDQpTaGFyZGVkVGhyZWFkUG9vbDo6d29ya2VyczogICAgICAgOC4wNyAg
IDE4LjcwJSAgICB8ICA3Ljk0ICAgMjAuMTglDQpQaXBlOjpSZWFkZXI6OiAgICAgICAgICAgICAg
ICAgICAgNS44MSAgIDEzLjQ1JSAgICB8ICA1LjkyICAgMTUuMDQlDQpQaXBlOjpXcml0ZXI6OmVu
dHJ5KCk6ICAgICAgICAgICAgNC41OSAgIDEwLjYzJSAgICB8ICA0LjczICAgMTIuMDIlDQpGaWxl
Sm91cm5hbDo6V3JpdGVyOjogICAgICAgICAgICAgMi40MSAgICA1LjU3JSAgICB8ICAyLjQ1ICAg
IDYuMjIlDQpGaW5pc2hlcjo6ZmluaXNoZXJfdGhyZWFkOiAgICAgICAgMi44NiAgICA2LjYzJSAg
ICB8ICAxLjAzICAgIDIuNjElDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8DQpXQlRocm90dGxlOjplbnRyeTogICAgICAgICAgICAgICAgbi9hICAg
ICBuL2EgICAgICB8ICAwLjgxICAgMi4wNiUNCg0KSW50ZXJlc3Rpbmc6IHdpdGggY29hbGVzY2lu
ZyBhY3RpdmUsIHRoZSBXQnRocm90dGxlIHNob3dzIHVwIGluIENQVSB1c2FnZS4NCkluIHRoZSBk
ZWZhdWx0IGNhc2UsIHRoaXMgd2FzIGFsbW9zdCBpbnZpc2libGUuDQoNCg0KU291cmNlL1BhdGNo
DQotLS0tLS0tLS0tLS0NCmh0dHBzOi8vd3d3LmdpdGh1Yi5jb20vYW5kcmVhcy1ibHVlbWxlL2Nl
cGgNCiAgIGNvbW1pdCBmMzNjNDgzNThmNzYyY2JlYjVkMzA3MjRlZmFjZjc4ZmY1NDM4ZTllDQoN
CnBhdGNoZXM6DQogICByZWxhdGl2ZSB0byBwdWxsIHJlcXVlc3QgYXQgaHR0cHM6Ly93d3cuZ2l0
aHViLmNvbS9hbmRyZWFzLWJsdWVtbGUvY2VwaA0KICAgICBjZXBoLWFuZHJlYXMtYmx1ZW1sZS5m
aWxlLXN0b3JlLW9tYXBfc2V0a2V5cy1jb2xhZXNjaW5nLnBhdGNoDQoNCiAgIHJlbGF0aXZlIHRv
IGNlcGggbWFzdGVyIGF0IGF0IGh0dHBzOi8vd3d3LmdpdGh1Yi5jb20NCiAgICAgKGNvbW1pdCBh
N2E3MGNhYmUyNWZkZmUzMzIyYzc4NGY2Nzk3MjMxZDE0ZTExMmMyKQ0KICAgICBjZXBoLW1hc3Rl
ci5maWxlLXN0b3JlLW9tYXBfc2V0a2V5cy1jb2xhZXNjaW5nLnBhdGNoDQoNCg==

--MP_/QrQxbL0Rww6oG8iak.iXdR/--
