From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Pyramid erasure codes and replica hinted recovery
Date: Mon, 13 Jan 2014 11:15:22 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6B06BC@PLOXCHG03.cern.ch>
References: <CAHxYaFMa_peMz8StZpJ=if0W4LmHBDO71vNnYnmgcNMab0-3aQ@mail.gmail.com>
	<52D1F060.8050108@dachary.org>
	<CAHxYaFOg6N2ZP1=OuOWajXUqMFtGsq0u94DG=Ub8NcAaqFtj+g@mail.gmail.com>
	<52D2EEF8.8020009@dachary.org>
 <CAHxYaFOzaeeRPv+N0mU_uWODUOvQnAe2kAn8rkuuSchFigkBAQ@mail.gmail.com>,<52D3A617.9010409@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:9252 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbaAMLP1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jan 2014 06:15:27 -0500
In-Reply-To: <52D3A617.9010409@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Kyle Bader <kyle@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,=20
few points from my side:

In the case of three data centers to protect against 1 out of 3 failing=
 data centers one has to fulfill 2M=3DK e.g.  (12,6)

K=3D12 M=3D6

kkkkmm kkkkmm kkkkmm

Then one can add three local parities to optimize data center local fai=
lures

kkkkmml kkkkmml kkkkmml

(12:6:(6:1)) =3D> 175% space overhead

(6:3:(6:1)) =3D> 200% space overhead

(18:9:(6:1)) =3D> 166% space overhead

=2E.. so if you boost K it converges to 150% space overhead but if K/3 =
is too big the traffic overhead for reconstruction is getting high. Sin=
ce we have a systematic code it is important with respect to CPU requir=
ements to distinguish K,M stripes on the global level e.g. for 3 data c=
enters K and M should be divisible by 3 e.g. (8:4) is not.=20

In the current BPC implementation the global RS stripes are not include=
d into the parity computation, however if M is high they should be incl=
uded to optimize the traffic. We should have an option to specify this =
or to select automatically the best strategy. For (6:3:(3:1)) the traff=
ic is the same if global stripes are included in local parity, for (8:4=
:(4:1)) it is better not to include global stripes, for (12:6:(6:1))) i=
t is better to include them.

In the current implementation we can only use simple parity as local pa=
rity (k:1) , it is not possible to use something like RS(4:2) as local =
parity. In my opinion there is no need to add this feature since the pr=
obability having a double disk failure within the repair period of a si=
ngle disk failure is extremely low and if it happens it is acceptable t=
o use global reconstruction instead of adding more space requirements f=
or additional local stripes.

I am not 100% sure but from your conversation I understand that recover=
y is done on a primary OSD which is quite unfortunate with respect to l=
ocal parities. The volume is reduced but locality is not given anymore =
=2E..=20

Cheers Andreas.
________________________________________
=46rom: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.=
org] on behalf of Loic Dachary [loic@dachary.org]
Sent: 13 January 2014 09:38
To: Kyle Bader
Cc: ceph-devel@vger.kernel.org
Subject: Re: Pyramid erasure codes and replica hinted recovery

On 13/01/2014 03:35, Kyle Bader wrote:
>> How is it different from what is described above? There must be some=
thing I fail to understand.
>
> No misunderstanding on your part, on second look that does achieve th=
e
> desired placement. Could you please help walk me through the followin=
g
> scenarios:
>
> Can data or local parity chunks that have been lost (erasures) be
> recovered locally, with no inter-dc backfill traffic?

If the primary happens to be located in the same data enter as the lost=
 chunk and the layout is as described previously, then it will be recov=
ered without the need for inter-dc traffic. If the primary is not in th=
e same datacenter, it may be possible to move it to the datacenter wher=
e the lost chunk is located. When the primary OSD is lost, another must=
 be chosen. It would be nice to change the primary not only when it is =
lost but also when doing so helps recovery.

> Global parity chunks that are lost require reading....6x data or
> global parity chunks (effectively 1x the original write)?

=46rom the point of view of recovery, global parity chunks are treated =
in the same way as data chunks. If you have RS(6,3,3), you will need to=
 read 6 chunks out of 9 ( 6 data chunks + 3 global parity chunks ) to b=
e able to recover from the loss of 2 or 3 chunks ( data or parity, it d=
oes not matter ). In other words, to recover from the loss of more chun=
ks than local parity allows, you need to read 1x the original write.

> Would placement groups containing a data or local parity chunk that
> have been remapped backfill from the local chunk (member of previous
> acting set)?

David is working on multiple backfill at the moment https://github.com/=
ceph/ceph/pull/931 and will have a definitive answer. The data flows fr=
om the primary OSD to the OSDs supporting the other chunks there is no =
peer-to-peer communication between the OSDs participating in a placemen=
t group.

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
