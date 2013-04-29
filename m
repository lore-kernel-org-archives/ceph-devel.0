From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: A question regarding the unlink() code
Date: Mon, 29 Apr 2013 07:23:18 -0700
Message-ID: <CABBk=J-qa5G_uWBSLLkxyHQUwsTFcymFxi2MMYMUAFy80MXgtg@mail.gmail.com>
References: <AMwANwD0AHhPZuIM2rKvAaq2.1.1367163784204.Hmail.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:58762 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837Ab3D2OXT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 10:23:19 -0400
Received: by mail-vb0-f42.google.com with SMTP id w15so1813848vbf.15
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 07:23:18 -0700 (PDT)
In-Reply-To: <AMwANwD0AHhPZuIM2rKvAaq2.1.1367163784204.Hmail.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5rGq6buO?= <liwang@ubuntukylin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Apr 28, 2013 at 8:43 AM, =E6=B1=AA=E9=BB=8E <liwang@ubuntukylin=
=2Ecom> wrote:
> Hi Yehuda, We have a code question to consult. For unlink() system ca=
ll to delete a file, does the Ceph kernel client go through ceph_unlink=
()? If so, it seems from the code tht client only communicate with MDS =
for metadata operation, client seems not contact with OSD to delete the=
 object. So, is that MDS takeing the responsibility of deleting file da=
ta? And, we find the definition of CEPH_OSD_OP_DELETE (include\linux\ce=
ph\rados.h), however, it seems it never actually used in the kernel cli=
ent code, is it left for future? Thanks for your time. Regards, Li Wang
>

Lets keep this discussion on the mailing list so everyone can benefit
from the discussion, cc'ing it here.

As for your questions, the MDS is responsible for removing the
objects. The kernel fs client code has probably no need for that
operation.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
