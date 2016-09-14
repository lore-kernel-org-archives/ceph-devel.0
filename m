From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Best latest commit to run bluestore
Date: Wed, 14 Sep 2016 19:13:34 +0000
Message-ID: <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0077.outbound.protection.outlook.com ([104.47.36.77]:63070
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756189AbcINTNh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 15:13:37 -0400
In-Reply-To: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>

Hi Nitin,
Try with latest master along with the latest rocksdb pull (now should be co=
ming via submodule automatically) , so far it is looking good.

Thanks & Regards
Somnath

-----Original Message-----
From: Kamble, Nitin A [mailto:Nitin.Kamble@Teradata.com]
Sent: Wednesday, September 14, 2016 12:11 PM
To: Ceph Development
Cc: Somnath Roy; Sage Weil
Subject: Best latest commit to run bluestore

Hi Sage, Somnath,

I would like to see how the current bluestore implementation performs with =
some workload.
I am following the ceph-devel mailing list, so I am aware there is the memo=
ry leak issue in the bluestore code now.

I also notice that, Somnath has used the master branch recently to generate=
 some benchmark numbers to generate pretty graphs. I do not worry about the=
 loosing the data on the cluster at this point, this is not a production se=
tup, just a experimentation to evaluate current bluestore performance vs fi=
lestore.

I am planning to build the ceph packages from the the latest ceph master br=
anch to do some workload testing on KRBD images backed up by Bluestore. I u=
nderstand that the master branch is work in progress, can break things,... =
etc. :)
  Can you guys suggest me the best and the latest master commit which I sho=
uld be able use to stress bluestore via krbd for 20+ hours?
   If nothing comes up to mind, then I can pick the commit Somnath used to =
generate the pretty graphs.

Thanks in advance for your help.
Nitin


PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
