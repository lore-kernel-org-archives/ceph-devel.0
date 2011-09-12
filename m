From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 0/2] improve qemu-img conversion performance
Date: Sun, 11 Sep 2011 20:17:02 -0700
Message-ID: <CAC-hyiHKmD9_z69XxRUE_3iZ--Vnb+q2B8kwQ985PHZP_2_jZA@mail.gmail.com>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
	<4E68CD7E.2050704@redhat.com>
	<Pine.LNX.4.64.1109080933150.9266@cobra.newdream.net>
	<4E69CBDB.1000401@redhat.com>
	<Pine.LNX.4.64.1109112004390.25151@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <Pine.LNX.4.64.1109112004390.25151@cobra.newdream.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Sage Weil <sage@newdream.net>
Cc: Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On Sun, Sep 11, 2011 at 8:14 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 9 Sep 2011, Kevin Wolf wrote:
>> Am 08.09.2011 18:36, schrieb Sage Weil:
>> > On Thu, 8 Sep 2011, Kevin Wolf wrote:
>> >> Am 08.09.2011 01:06, schrieb Yehuda Sadeh:
>> >>> The following set of patches improve the qemu-img conversion process
>> >>> performance. When using a higher latency backend, small writes have =
a
>> >>> severe impact on the time it takes to do image conversion.
>> >>> We switch to using async writes, and we avoid splitting writes due t=
o
>> >>> holes when the holes are small enough.
>> >>>
>> >>> Yehuda Sadeh (2):
>> >>> =A0 qemu-img: async write to block device when converting image
>> >>> =A0 qemu-img: don't skip writing small holes
>> >>>
>> >>> =A0qemu-img.c | =A0 34 +++++++++++++++++++++++++++-------
>> >>> =A01 files changed, 27 insertions(+), 7 deletions(-)
>> >>>
>> >>
>> >> This doesn't seem to be against git master or the block tree. Please =
rebase.
>> >>
>> >> I think that commit a22f123c may obsolete your patch 2/2.
>> >
>> > With git.kernel.org down, where should I be looking for the latest
>> > upstream?
>>
>> qemu has never been on kernel.org. The interesting repositories for you =
are:
>>
>> * Upstream: git://git.qemu.org/qemu.git master
>> * Block development branch: git://repo.or.cz/qemu/kevin.git block
>
> Oh right. =A0I've been working from qemu-kvm.git.
>
> I've done some (still minimal) testing, and it looks like the combination
> of a22f123c and the new writeback/flush stuff in librbd gets the same
> result as doing async io explicitly from qemu-img.c. =A0Want to take a lo=
ok,
> Yehuda? =A0It still defaults to off, so you'll need to add
> rbd_writeback_window=3D8000000 or similar to the rbd device string.
>

I'll take a look. I do have a rebased version for the qemu-img async
patch, and I think qemu can benefit from that anyway.

Yehuda
