From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: A question regarding the unlink() code
Date: Mon, 29 Apr 2013 23:12:17 +0800
Message-ID: <517E8DD1.4010805@ubuntukylin.com>
References: <AMwANwD0AHhPZuIM2rKvAaq2.1.1367163784204.Hmail.liwang@ubuntukylin.com> <CABBk=J-qa5G_uWBSLLkxyHQUwsTFcymFxi2MMYMUAFy80MXgtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:49256 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab3D2PMX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:12:23 -0400
In-Reply-To: <CABBk=J-qa5G_uWBSLLkxyHQUwsTFcymFxi2MMYMUAFy80MXgtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

HI Yehuda,
     Thanks for the answer. We are planning to use the=20
CEPH_OSD_OP_DELETE to implement
fallocate/hole punching, the details are described in the blueprint=20
(wiki.ceph.com). Your comments/suggestions
are appreciated.

Regards,
Li Wang

On 04/29/2013 10:23 PM, Yehuda Sadeh wrote:
> On Sun, Apr 28, 2013 at 8:43 AM, =E6=B1=AA=E9=BB=8E <liwang@ubuntukyl=
in.com> wrote:
>> Hi Yehuda, We have a code question to consult. For unlink() system c=
all to delete a file, does the Ceph kernel client go through ceph_unlin=
k()? If so, it seems from the code tht client only communicate with MDS=
 for metadata operation, client seems not contact with OSD to delete th=
e object. So, is that MDS takeing the responsibility of deleting file d=
ata? And, we find the definition of CEPH_OSD_OP_DELETE (include\linux\c=
eph\rados.h), however, it seems it never actually used in the kernel cl=
ient code, is it left for future? Thanks for your time. Regards, Li Wan=
g
>>
> Lets keep this discussion on the mailing list so everyone can benefit
> from the discussion, cc'ing it here.
>
> As for your questions, the MDS is responsible for removing the
> objects. The kernel fs client code has probably no need for that
> operation.
>
> Yehuda
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
