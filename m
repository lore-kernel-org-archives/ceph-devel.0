From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: ISA erasure code plugin and cache
Date: Mon, 4 Aug 2014 12:15:38 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch>
References: <53DF750B.6080107@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:31838 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbaHDMPk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 08:15:40 -0400
In-Reply-To: <53DF750B.6080107@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20

the background relevant to your comments have (unfortunately) never bee=
n answered on the mailing list.=20

The cache is written in a way, that it is useful for a fixed (k,m) comb=
ination and thread-safe.

So, if there is one instance of the plugin per pool, it is the right im=
plementation. If there is (as you write) one instance for each PG in an=
y pool, it is sort of 'stupid' because the same encoding table is store=
d for each PG seperatly.

So if the final statement is to create one plugin instance per PG, I wi=
ll change it accordingly and shared encoding & decoding tables for a fi=
xed (k,m), if not it can stay.=20

Just need to know that ... this boils down to the fact, that encoding &=
 decoding should not be considered 'stateless'.

Cheers Andreas.


________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 04 August 2014 13:56
To: Andreas Joachim Peters
Cc: Ma, Jianpeng; Ceph Development
Subject: ISA erasure code plugin and cache

Hi,

Here is how I understand the current code:

When an OSD is missing, recovery is required and the primary OSD will c=
ollect the available chunks to do so. It will then call the decode meth=
od via ECUtil::decode which is a small wrapper around the corresponding=
 ErasureCodeInterface::decode method.

   https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L361

The ISA plugin will then use the isa_decode method to perform the work

   https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCodeIsa.cc#L212

and will be repeatedly called until all objects in the PGs that were re=
lying on the missing OSD are recovered. To avoid computing the decoding=
 table for each object, it is stored in a LRU cache

   https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCodeIsa.cc#L480

and copied in the stack if already there:

   https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCodeIsa.cc#L433

Each PG has a separate instance of ErasureCodeIsa, obtained when it is =
created:

   https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L292

It means that data members of each ErasureCodeIsa are copied as many ti=
mes as there are PGs. If an OSD handles participates in 200 PG that bel=
ong to an erasure coded pool configured to use ErasureCodeIsa, the data=
 members will be duplicated 200 times.

It is good practice to make it so that the encode/decode methods of Era=
sureCodeIsa are thread safe. In the jerasure plugin these methods have =
no side effect on the object. In the isa plugin the LRU cache storing t=
he decode tables is modified by the decode method and guarded by a mute=
x:

   get https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Er=
asureCodeIsa.cc#L281
   put https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Er=
asureCodeIsa.cc#L310

Please correct me if I'm mistaken ;-) I've not reviewed the code yet an=
d try to find problems, I just wanted to make sure I get the intention =
before doing so.

Cheers
--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
