From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Enabling bluestore_sync_transaction
Date: Wed, 19 Oct 2016 01:08:51 +0000
Message-ID: <BY2PR02MB3969DEA02369E4890E09208F4D20@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:9792
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753216AbcJSBIx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Oct 2016 21:08:53 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
I was trying to benchmark bluestore by enabling bluestore_sync_transaction =
and it seems the db method in the below code is called wrongly ?
If we enable bluestore_sync_submit_transaction , shouldn't we be doing db->=
 submit_transaction_sync() and if we enable only bluestore_sync_transaction=
 shouldn't we be doing db->submit_transaction() ?



      if (!g_conf->bluestore_sync_transaction) {
if (g_conf->bluestore_sync_submit_transaction) {
  _txc_finalize_kv(txc, txc->t);
  int r =3D db->submit_transaction(txc->t);
  assert(r =3D=3D 0);
}
      } else {
_txc_finalize_kv(txc, txc->t);
int r =3D db->submit_transaction_sync(txc->t);
assert(r =3D=3D 0);
      }

We are anyway calling one submit_transaction_sync from _kv_sync_thread().

Now, if I do that (for bluestore_sync_transaction =3D true) , I am seeing ~=
10% performance improvement with min_alloc_size =3D 16K and seeing much low=
er cpu usage with _kv_sync_thread.
This is also telling us that even if we are not utilizing 100% cpu core for=
 _kv_sync_thread , more work you do from this thread will degrade performan=
ce.
IMO, bluestore_sync_transaction should be default true if you agree that we=
 should be replacing the *_sync call.

Thanks & Regards
Somnath



PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
