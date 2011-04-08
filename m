From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just librados
Date: Fri, 8 Apr 2011 17:14:52 +0100
Message-ID: <BANLkTi=-th8edQf7gaciMAqM3652KPffnw@mail.gmail.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
	<20110408084334.GA28360@stefanha-thinkpad.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20110408084334.GA28360@stefanha-thinkpad.localdomain>
Sender: kvm-owner@vger.kernel.org
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>
List-Id: ceph-devel.vger.kernel.org

On Fri, Apr 8, 2011 at 9:43 AM, Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> On Mon, Mar 28, 2011 at 04:15:57PM -0700, Josh Durgin wrote:
>> librbd stacks on top of librados to provide access
>> to rbd images.
>>
>> Using librbd simplifies the qemu code, and allows
>> qemu to use new versions of the rbd format
>> with few (if any) changes.
>>
>> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
>> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
>> ---
>> =A0block/rbd.c =A0 =A0 =A0 | =A0785 +++++++++++++++-----------------=
---------------------
>> =A0block/rbd_types.h | =A0 71 -----
>> =A0configure =A0 =A0 =A0 =A0 | =A0 33 +--
>> =A03 files changed, 221 insertions(+), 668 deletions(-)
>> =A0delete mode 100644 block/rbd_types.h
>
> Hi Josh,
> I have applied your patches onto qemu.git/master and am running
> ceph.git/master.
>
> Unfortunately qemu-iotests fails for me.

I forgot to mention that qemu-iotests lives at:

git://git.kernel.org/pub/scm/linux/kernel/git/hch/qemu-iotests.git

Stefan
