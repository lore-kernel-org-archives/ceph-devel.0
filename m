From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Error in ceph rbd
 mirroring(rbd::mirror::InstanceWatcher: C_NotifyInstanceRequestfinish:
 resending after timeout)
Date: Fri, 26 Jul 2019 09:58:59 -0400
Message-ID: <CA+aFP1BwL73Drgz+9Tezw6TwuUug-ibR+nw_5N3cEKdvj1SPQQ@mail.gmail.com>
References: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA@mail.gmail.com>
 <20190726093147.GA31242@gmail.com>
 <CAEbG6hFgvWFMgaYHRRtZdth-OkJ7ib4vWxf__b7QvGPd1rF6Qg@mail.gmail.com>
 <20190726132546.GA6825@gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20190726132546.GA6825-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jul 26, 2019 at 9:26 AM Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Fri, Jul 26, 2019 at 04:40:35PM +0530, Ajitha Robert wrote:
> > Thank you for the clarification.
> >
> > But i was trying with openstack-cinder.. when i load some data into the
> > volume around 50gb, the image sync will stop by 5 % or something within
> > 15%...  What could be the reason?
>
> I suppose you see image sync stop in mirror status output? Could you
> please provide an example? And I suppose you don't see any other
> messages in rbd-mirror log apart from what you have already posted?
> Depending on configuration rbd-mirror might log in several logs. Could
> you please try to find all its logs? `lsof |grep 'rbd-mirror.*log'`
> may be useful for this.
>
> BTW, what rbd-mirror version are you running?

From the previous thread a few days ago (not sure why a new thread was
started on this same topic), to me it sounded like one or more OSDs
isn't reachable from the secondary site:

> > Scenario 2:
> > but when i create a 50gb volume with another glance image. Volume  get created. and in the backend i could see the rbd images both in primary and secondary
> >
> > From rbd mirror image status i found secondary cluster starts copying , and syncing was struck at around 14 %... It will be in 14 % .. no progress at all. should I set any parameters for this like timeout??
> >
> > I manually checked rbd --cluster primary object-map check <object-name>..  No results came for the objects and the command was in hanging.. Thats why got worried on the failed to map object key log. I couldnt even rebuild the object map.

> It sounds like one or more of your primary OSDs are not reachable from
> the secondary site. If you run w/ "debug rbd-mirror = 20" and "debug
> rbd = 20", you should be able to see the last object it attempted to
> copy. From that, you could use "ceph osd map" to figure out the
> primary OSD for that object.



> --
> Mykola Golub
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



--
Jason
