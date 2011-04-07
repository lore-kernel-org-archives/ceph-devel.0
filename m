From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 2/2] rbd: allow configuration of rados from the rbd
 filename
Date: Thu, 7 Apr 2011 09:47:07 +0100
Message-ID: <20110407084707.GA21871@stefanha-thinkpad.localdomain>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
 <99252a76de350c8123eebfe4fc01fc6a1c9b2383.1301354138.git.josh.durgin@dreamhost.com>
 <BANLkTinZa+_FfZcyO54QE9W37PB___+m1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTinZa+_FfZcyO54QE9W37PB___+m1g@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Yoshiaki Tamura <tamura.yoshiaki@gmail.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 07, 2011 at 10:14:03AM +0900, Yoshiaki Tamura wrote:
> 2011/3/29 Josh Durgin <josh.durgin@dreamhost.com>:
> > The new format is rbd:pool/image[@snapshot][:option1=3Dvalue1[:opti=
on2=3Dvalue2...]]
> > Each option is used to configure rados, and may be any Ceph option,=
 or "conf".
> > The "conf" option specifies a Ceph configuration file to read.
> >
> > This allows rbd volumes from more than one Ceph cluster to be used =
by
> > specifying different monitor addresses, as well as having different
> > logging levels or locations for different volumes.
> >
> > Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> > ---
> > =A0block/rbd.c | =A0119 +++++++++++++++++++++++++++++++++++++++++++=
+++++++--------
> > =A01 files changed, 102 insertions(+), 17 deletions(-)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index cb76dd3..bc3323d 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -22,13 +22,17 @@
> > =A0/*
> > =A0* When specifying the image filename use:
> > =A0*
> > - * rbd:poolname/devicename
> > + * rbd:poolname/devicename[@snapshotname][:option1=3Dvalue1[:optio=
n2=3Dvalue2...]]
>=20
> I'm not sure IIUC, but currently this @snapshotname seems to be
> meaningless; it doesn't allow you to boot from a snapshot because it'=
s
> read only.  Am I misunderstanding or tested incorrectly?

Read-only block devices are supported by QEMU and can be useful.

Stefan
