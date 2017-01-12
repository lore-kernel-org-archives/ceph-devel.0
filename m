From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Any librados C API users out there?
Date: Thu, 12 Jan 2017 20:34:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701122034410.5745@piezo.novalocal>
References: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051@corp.ovh.com>
	<CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com>
	<alpine.DEB.2.11.1701111755260.5745@piezo.novalocal>
	<e0e85f8a-5f78-e652-9838-5aae2ef97d14@corp.ovh.com>
	<alpine.DEB.2.11.1701121344270.5745@piezo.novalocal>
	<CA+aFP1Akuxx5XndUqV=-DmMb3AqwOaK+O9VESKUjpm7Goy5Hvg@mail.gmail.com>
	<CAJ4mKGb4T8r2adVZHnboQpr=0_t+FkM4y7kjvnBo0gvquyQ9rQ@mail.gmail.com>
	<alpine.DEB.2.11.1701122006270.5745@piezo.novalocal>
	<CADRKj5RZOD1MuhC08n50VCWaj+qcKEOMEWtybEVcmHP3DSz+Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADRKj5RZOD1MuhC08n50VCWaj+qcKEOMEWtybEVcmHP3DSz+Tg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Yehuda Sadeh-Weinraub <ysadehwe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 12 Jan 2017, Yehuda Sadeh-Weinraub wrote:
> On Thu, Jan 12, 2017 at 12:08 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Thu, 12 Jan 2017, Gregory Farnum wrote:
> >> On Thu, Jan 12, 2017 at 5:54 AM, Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >> > There is option (3) which is to have a new (or modified)
> >> > "buffer::create_static" take an optional callback to invoke when the
> >> > buffer::raw object is destructed. The raw pointer would be destructed
> >> > when the last buffer::ptr / buffer::list containing it is destructed,
> >> > so you know it's no longer being referenced.
> >> >
> >> > You could then have the new C API methods that wrap the C buffer in a
> >> > bufferlist and set a new flag in the librados::AioCompletion to delay
> >> > its completion until after it's both completed and the memory is
> >> > released. When the buffer is freed, the callback would unblock the
> >> > librados::AioCompltion completion callback.
> >>
> >> I much prefer an approach like this: it's zero-copy; it's not a lot of
> >> user overhead; but it requires them to explicitly pass memory off to
> >> Ceph and keep it immutable until Ceph is done (at which point they are
> >> told so explicitly).
> >
> > Yeah, this is simpler.  I still feel like we should provide a way to
> > revoke buffers, though, because otherwise it's possible for calls to block
> > semi-indefinitey if, say, an old MOSDOp is quueed for another OSD and that
> > OSD is not reading data off the socket but has not failed (e.g., due to
> > it's rx throttling).
> >
> 
> We need to provide some way to cancel requests (at least from the
> client's aspect), that would guarantee that buffers are not going to
> be used (and no completion callback is going to be called).

Yeah.  It's a bit more work but I think this is the best path.

sage
