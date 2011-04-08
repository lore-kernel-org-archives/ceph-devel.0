From: Yoshiaki Tamura <tamura.yoshiaki@gmail.com>
Subject: Re: [PATCH v2 2/2] rbd: allow configuration of rados from the rbd filename
Date: Fri, 8 Apr 2011 10:07:10 +0900
Message-ID: <BANLkTimqJdCRnevPHCG79ZJ=FMi9Fi9XHQ@mail.gmail.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
	<99252a76de350c8123eebfe4fc01fc6a1c9b2383.1301354138.git.josh.durgin@dreamhost.com>
	<BANLkTinZa+_FfZcyO54QE9W37PB___+m1g@mail.gmail.com>
	<20110407084707.GA21871@stefanha-thinkpad.localdomain>
	<BANLkTin=YxkHTz6Z-sQ00gyhHxghRXZQpg@mail.gmail.com>
	<BANLkTingpiVSTt6DpSwP-6hydGWDx8E=ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <BANLkTingpiVSTt6DpSwP-6hydGWDx8E=ag@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Josh Durgin <josh.durgin@dreamhost.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

2011/4/8 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Thu, Apr 7, 2011 at 2:54 AM, Yoshiaki Tamura
> <tamura.yoshiaki@gmail.com> wrote:
>> 2011/4/7 Stefan Hajnoczi <stefanha@gmail.com>:
>>> On Thu, Apr 07, 2011 at 10:14:03AM +0900, Yoshiaki Tamura wrote:
>>>> 2011/3/29 Josh Durgin <josh.durgin@dreamhost.com>:
>>>> > The new format is rbd:pool/image[@snapshot][:option1=3Dvalue1[:o=
ption2=3Dvalue2...]]
>>>> > Each option is used to configure rados, and may be any Ceph opti=
on, or "conf".
>>>> > The "conf" option specifies a Ceph configuration file to read.
>>>> >
>>>> > This allows rbd volumes from more than one Ceph cluster to be us=
ed by
>>>> > specifying different monitor addresses, as well as having differ=
ent
>>>> > logging levels or locations for different volumes.
>>>> >
>>>> > Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
>>>> > ---
>>>> > =A0block/rbd.c | =A0119 ++++++++++++++++++++++++++++++++++++++++=
++++++++++--------
>>>> > =A01 files changed, 102 insertions(+), 17 deletions(-)
>>>> >
>>>> > diff --git a/block/rbd.c b/block/rbd.c
>>>> > index cb76dd3..bc3323d 100644
>>>> > --- a/block/rbd.c
>>>> > +++ b/block/rbd.c
>>>> > @@ -22,13 +22,17 @@
>>>> > =A0/*
>>>> > =A0* When specifying the image filename use:
>>>> > =A0*
>>>> > - * rbd:poolname/devicename
>>>> > + * rbd:poolname/devicename[@snapshotname][:option1=3Dvalue1[:op=
tion2=3Dvalue2...]]
>>>>
>>>> I'm not sure IIUC, but currently this @snapshotname seems to be
>>>> meaningless; it doesn't allow you to boot from a snapshot because =
it's
>>>> read only. =A0Am I misunderstanding or tested incorrectly?
>>>
>>> Read-only block devices are supported by QEMU and can be useful.
>>
>> I agree. =A0My expectation was that @snapshotname is introduced to h=
ave
>> writable snapshot.
>>
> The RADOS backend doesn't support writable snapshots. However, down
> the rbd roadmap we plan to have layering which in a sense is writable
> snapshots. The whole shift to librbd was done so that introducing suc=
h
> new functionality will be transparent and will not require much or an=
y
> changes in the qemu code.

Thanks.  It made things clear :)  I think it's a good move.

Yoshi

>
> Yehuda
>
