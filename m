From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Question on Ceph LRC design
Date: Mon, 17 Nov 2014 10:07:11 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE81D81C@CERNXCHG44.cern.ch>
References: <06681238D8946F44A60AA400760A1CBF01E28FBD@SHSMSX104.ccr.corp.intel.com>
 <06681238D8946F44A60AA400760A1CBF01E290AB@SHSMSX104.ccr.corp.intel.com>,<54694980.2010302@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:25262 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbaKQKMd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 05:12:33 -0500
In-Reply-To: <54694980.2010302@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

if you want to compute local parities within a plug-in library by addin=
g rows to the encoding matrix, you can still do that. If you can do LRC=
 inside the plug-in more efficienty, one should do it in the plug-in an=
d skip the LRC layer. I have a patch to the ISA plug-in which can do LR=
C like HDFS Xorbas encoding, but i didn't manage to express that in Loi=
c's generic LRC layer  ... I think it is hard to formulate a generic fr=
amework to define LRC as a layer on top and doing the encoding/decoding=
 only in the lowest layer.  Same problem for the shingled EC, which you=
 cannot express in the simple LRC way ...

I see the current LRC layering as a generic tool to use in multi-datace=
nter setups honouring the locality of chunks because some  of the LRC o=
ptimization codes break locality by cross-talk between locations, they =
reduce the traffic but do not restrict traffic within data centers.

Cheers Andreas.
________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 17 November 2014 02:04
To: Zhou, Yuan; Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: Question on Ceph LRC design

Hi,

I believe Andreas has a more elaborate answer on this topic. The curren=
t implementation is not as good as what is described in the paper you m=
ention, this is correct. My incentive for chosing this path is that I w=
as able to understand it, mainly. It is not much more than stacking lay=
ers of erasure coded chunks on top of each other ;-)

Now that we have this plugin, it would be nice to have another implemen=
tation that uses less space and possible even less network when reconst=
ructing. During the OpenStack summit we discussed this with Kevin Green=
an and there are promising directions. It would help a lot to have a sa=
mple code to study so that it can be adapted to what we have currently =
in Ceph. Do you know of such an implementation of LRC or other similar =
code designed to reduce the network bandwidth during reconstruction ?

Cheers

On 17/11/2014 01:52, Zhou, Yuan wrote:
> Hi Loic/Anderas,
>
>
>
> I was trying to understand the LRC design in Ceph EC. Per my understa=
nding, it seems Ceph was using a slightly different design with the Mic=
rosoft LRC: the local parities were calculated with the global parities=
 included. Is there any special consideration on this change?
>
> I was asking because in a typical MS LRC design the global and local =
parities could be calculated at the same time actually(I mean inside th=
e Erasure Code library). But with this new design, we lost this potenti=
al optimization.
>
>
>
> Thanks, -Yuan
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
