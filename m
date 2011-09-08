From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/2] improve qemu-img conversion performance
Date: Thu, 8 Sep 2011 09:36:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109080933150.9266@cobra.newdream.net>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
	<4E68CD7E.2050704@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <4E68CD7E.2050704@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Kevin Wolf <kwolf@redhat.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, yehudasa@gmail.com, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 8 Sep 2011, Kevin Wolf wrote:
> Am 08.09.2011 01:06, schrieb Yehuda Sadeh:
> > The following set of patches improve the qemu-img conversion process
> > performance. When using a higher latency backend, small writes have a
> > severe impact on the time it takes to do image conversion. 
> > We switch to using async writes, and we avoid splitting writes due to
> > holes when the holes are small enough.
> > 
> > Yehuda Sadeh (2):
> >   qemu-img: async write to block device when converting image
> >   qemu-img: don't skip writing small holes
> > 
> >  qemu-img.c |   34 +++++++++++++++++++++++++++-------
> >  1 files changed, 27 insertions(+), 7 deletions(-)
> > 
> 
> This doesn't seem to be against git master or the block tree. Please rebase.
> 
> I think that commit a22f123c may obsolete your patch 2/2.

With git.kernel.org down, where should I be looking for the latest 
upstream?

Thanks!
sage
