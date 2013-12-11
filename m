From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Buffer alignment
Date: Wed, 11 Dec 2013 09:50:18 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6A9C35@PLOXCHG03.cern.ch>
References: <52A6D1B4.1010503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:39205 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab3LKJuU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 04:50:20 -0500
In-Reply-To: <52A6D1B4.1010503@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20
if you pull the BPC extension this requires 128-bit aligned memory adre=
sses, maybe to prepare for future extensions they should be even 512-bi=
t aligned. I can add an assertion if I see unaligned addresses.

Cheers Andreas.

________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 10 December 2013 09:32
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Buffer alignment

Hi Andreas,

In Ceph, buffers can be aligned if required using buffer::create_page_a=
ligned

https://github.com/ceph/ceph/blob/master/src/common/buffer.cc#L519
https://github.com/ceph/ceph/blob/master/src/common/buffer.cc#L230

and although the Jerasure plugin has alignment requirements

https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJeras=
ure/ErasureCodeJerasure.cc#L79

it did not occur to me that aligning the buffers used to stored the enc=
oded

https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJeras=
ure/ErasureCodeJerasure.cc#L87

result would be needed. For decoding the caller is responsible for allo=
cating the buffers. For encoding it also is, except for the padding.

Do you think the API should recommend something regarding alignment ?

https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface.h=
#L20

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
