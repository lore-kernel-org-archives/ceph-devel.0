From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v8)
Date: Mon, 6 Dec 2010 11:22:55 -0800
Message-ID: <AANLkTinoqncm8ZOF=iZ33br1x70Bz4M8Px7WLyuGgJOW@mail.gmail.com>
References: <20101117214223.GA31321@sir.home>
	<4CFCDBB1.5000800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <4CFCDBB1.5000800@redhat.com>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Kevin Wolf <kwolf@redhat.com>
Cc: ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Dec 6, 2010 at 4:48 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>
>
> What's the easiest way to try it out? I tried to use vstart.sh and copy
> the generated ceph.conf to /etc/ceph/ceph.conf so that qemu-img etc.
> find the monitor address. However, that leads to a hang when I try "rbd
> list" or "./qemu-img create -f rbd rbd:data/test.img 4G", so I seem to
> be missing something.

What ceph version are you running? Is your system up? What's the 'ceph
-s' output?

>
> The only thing I have achieved until now with my attempts of trying it
> out (and trying wrong things, of course) is that I stumbled over the the
> following segfault in librados:
>
> Program received signal SIGSEGV, Segmentation fault.
> Objecter::shutdown (this=3D0x0) at osdc/Objecter.cc:59
> 59 =A0 =A0 =A0 =A0assert(client_lock.is_locked()); =A0// otherwise event
> cancellation is unsafe
> (gdb) bt
> #0 =A0Objecter::shutdown (this=3D0x0) at osdc/Objecter.cc:59
> #1 =A00x00007ffff7ca5ce4 in RadosClient::shutdown (this=3D0xa58a90) at
> librados.cc:392
> #2 =A00x00007ffff7ca8ccc in rados_deinitialize () at librados.cc:1770
> #3 =A00x000000000043150c in rbd_create (filename=3D<value optimized out>,
> options=3D<value optimized out>) at block/rbd.c:304
> #4 =A00x0000000000405f10 in img_create (argc=3D5, argv=3D0x7fffffffde80) =
at
> qemu-img.c:409
> #5 =A00x0000003c9f01eb1d in __libc_start_main () from /lib64/libc.so.6
> #6 =A00x0000000000403999 in _start ()
>

This was a bug in the librados C interface. Basically it ignored
errors when doing initialization and later on when trying to clean up
stuff after failing to do some operation (since it failed to init) it
crashed. I pushed a fix for that to the ceph rc branch (and also to
the unstable branch).

The question is still why it failed to initialize in the first place.
Were there any other messages printed? It could be that it still
couldn't find the monitors, or that it failed to authenticate for some
reason (if cephx was being used). you can try turning on several ceph
modules logs by adding the following to your ceph.conf in the global
section:

    debug ms =3D 1
    debug rados =3D 20
    debug monc =3D 10
    debug objecter =3D 10

If everything seems ok and it still doesn't work you can try to run
the rbd utility:

  $ ./rbd create test.img --size=3D4096 -p data

and you can add '--debug-ms=3D1 --debug-rados=3D20 --debug-...' to the
comman line too.

Let us know if you still have any problems.

Thanks,
Yehuda


Thanks,
Yehuda
