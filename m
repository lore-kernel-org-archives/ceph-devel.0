From: Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Mon, 21 Oct 2013 13:48:51 -0400
Message-ID: <20131021174850.GA29416@redhat.com>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
	<alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
	<20131017151828.GB28859@redhat.com>
	<CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
	<alpine.DEB.2.00.1310181657151.19763@cobra.newdream.net>
	<CAE63xUO4ZrzObMFeQ=FXGFnqpwWsjCiiDr2_VhOt91h=djofYw@mail.gmail.com>
	<alpine.DEB.2.00.1310202051240.29488@cobra.newdream.net>
	<20131021141147.GA30189@infradead.org>
	<20131021150129.GA28099@redhat.com>
	<alpine.DEB.2.00.1310210853140.29488@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1310210853140.29488-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-lvm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 21 2013 at 12:02pm -0400,
Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Mon, 21 Oct 2013, Mike Snitzer wrote:
> > On Mon, Oct 21 2013 at 10:11am -0400,
> > Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> > 
> > > On Sun, Oct 20, 2013 at 08:58:58PM -0700, Sage Weil wrote:
> > > > It looks like without LVM we're getting 128KB requests (which IIRC is 
> > > > typical), but with LVM it's only 4KB.  Unfortunately my memory is a bit 
> > > > fuzzy here, but I seem to recall a property on the request_queue or device 
> > > > that affected this.  RBD is currently doing
> > > 
> > > Unfortunately most device mapper modules still split all I/O into 4k
> > > chunks before handling them.  They rely on the elevator to merge them
> > > back together down the line, which isn't overly efficient but should at
> > > least provide larger segments for the common cases.
> > 
> > It isn't DM that splits the IO into 4K chunks; it is the VM subsystem
> > no?  Unless care is taken to assemble larger bios (higher up the IO
> > stack, e.g. in XFS), all buffered IO will come to bio-based DM targets
> > in $PAGE_SIZE granularity.
> > 
> > I would expect direct IO to before better here because it will make use
> > of bio_add_page to build up larger IOs.
> 
> I do know that we regularly see 128 KB requests when we put XFS (or 
> whatever else) directly on top of /dev/rbd*.

Should be pretty straight-forward to identify any limits that are
different by walking sysfs/queue, e.g.:

grep -r . /sys/block/rdbXXX/queue
vs
grep -r . /sys/block/dm-X/queue

Could be there is an unexpected difference.  For instance, there was
this fix recently: http://patchwork.usersys.redhat.com/patch/69661/

> > Taking a step back, the rbd driver is exposing both the minimum_io_size
> > and optimal_io_size as 4M.  This symmetry will cause XFS to _not_ detect
> > the exposed limits as striping.  Therefore, AFAIK, XFS won't take steps
> > to respect the limits when it assembles its bios (via bio_add_page).
> > 
> > Sage, any reason why you don't use traditional raid geomtry based IO
> > limits?, e.g.:
> > 
> > minimum_io_size = raid chunk size
> > optimal_io_size = raid chunk size * N stripes (aka full stripe)
> 
> We are... by default we stripe 4M chunks across 4M objects.  You're 
> suggesting it would actually help to advertise a smaller minimim_io_size 
> (say, 1MB)?  This could easily be made tunable.

You're striping 4MB chunks across 4 million stripes?

So the full stripe size in bytes is 17592186044416 (or 16TB)?  Yeah
cannot see how XFS could make use of that ;)
