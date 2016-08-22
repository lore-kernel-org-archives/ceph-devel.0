From: Varada Kari <Varada.Kari@sandisk.com>
Subject: csum_order/csum_length encoding per blob
Date: Mon, 22 Aug 2016 13:49:06 +0000
Message-ID: <BLUPR0201MB19082E9CDF05E78B27233850E2E80@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0087.outbound.protection.outlook.com ([104.47.42.87]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755337AbcHVNtJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 09:49:09 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage/Igor,

Right now the csum_order and csum_length are per blob. Can we make them per=
 onode? Is there any specific reason to make them per blob?
I understand we can choose a different type of checksum for the entire stor=
e after using the store with one type of csum type. But is it a frequent op=
eration?
If we can place csum_* per onode, we can detach them from blob, we can redu=
ce the serializable onode size this way.
Or we can place the csum property as a pool property?

Thanks,
Varada

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
