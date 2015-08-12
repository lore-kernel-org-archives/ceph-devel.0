From: Matt Weil <mweil@genome.wustl.edu>
Subject: Re: create OSD on IBM's GPFS file system
Date: Wed, 12 Aug 2015 10:22:19 -0500
Message-ID: <55CB64AB.9050208@genome.wustl.edu>
References: <55CB5763.6090007@genome.wustl.edu>
 <6F3FA899187F0043BA1827A69DA2F7CC022789B5@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:43591 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753816AbbHLPWR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Aug 2015 11:22:17 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC022789B5@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 8/12/15 10:04 AM, Chen, Xiaoxi wrote:
> That require some kind of driver in Ceph(see XFSFileStoreBackend.cc/h=
 and BTRFSFileStoreBackend.cc/h), you need to implement a GPFSFileStore=
Backend in Ceph.
>
> But Why you want OSD on top of GPFS?

I understand it seems redundant.

>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Matt Weil
>> Sent: Wednesday, August 12, 2015 10:26 PM
>> To: Ceph Development
>> Subject: create OSD on IBM's GPFS file system
>>
>> Hello all,
>>
>> Is this possible?
>>
>> ____
>> This email message is a private communication. The information trans=
mitted,
>> including attachments, is intended only for the person or entity to =
which it is
>> addressed and may contain confidential, privileged, and/or proprieta=
ry
>> material. Any review, duplication, retransmission, distribution, or =
other use of,
>> or taking of any action in reliance upon, this information by person=
s or entities
>> other than the intended recipient is unauthorized by the sender and =
is
>> prohibited. If you have received this message in error, please conta=
ct the
>> sender immediately by return email and delete the original message f=
rom all
>> computer systems. Thank you.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the body
>> of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D


____
This email message is a private communication. The information transmit=
ted, including attachments, is intended only for the person or entity t=
o which it is addressed and may contain confidential, privileged, and/o=
r proprietary material. Any review, duplication, retransmission, distri=
bution, or other use of, or taking of any action in reliance upon, this=
 information by persons or entities other than the intended recipient i=
s unauthorized by the sender and is prohibited. If you have received th=
is message in error, please contact the sender immediately by return em=
ail and delete the original message from all computer systems. Thank yo=
u.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
