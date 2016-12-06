From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore with ZS
Date: Tue, 6 Dec 2016 08:33:38 +0000
Message-ID: <BY2PR02MB39644AE8ABB2551CC39A46AF4820@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:36320
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752135AbcLFItW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Dec 2016 03:49:22 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Mark,
Please find the Bluestore + ZS integrated code synced with today's master i=
n the following location.

https://github.com/somnathr/ceph/tree/wip-bluestore-zs

As discussed in the standup , this is with single kv_sync_thread.
I am still cleaning up multi kv_sync_thread  version and will send out a pu=
ll request for Sage to review hopefully by tomorrow.

Here is the steps you need to follow to use this.

1.  ./do_cmake.sh -DWITH_ZS=3D1

2. make and make install

3. In the ceph.conf , use the following option.

enable experimental unrecoverable data corrupting features =3D bluestore zs=
 rocksdb
bluestore_sync_submit_transaction =3D false
bluestore_kvbackend=3Dzs

With smaller volumes you will be seeing rocks outperforming ZS , but, for b=
igger volumes ZS is catching up fast.
The code (shim layer and thus BlueStore)  is no way optimally using ZS yet =
and we are in process of optimizing it further (with multi kv_sync, more ba=
tching etc. etc.).
Will keep community posted on this.

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
