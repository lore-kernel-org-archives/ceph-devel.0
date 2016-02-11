From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: cls_rbd ops on rbd_id.$name objects in EC pool
Date: Thu, 11 Feb 2016 14:04:03 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602111403010.28396@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com>
	<1582262647.20033136.1454687586287.JavaMail.zimbra@redhat.com>
	<CAN=+7FXJ6je1WpYpO-ozqo-ZKnBcRhv3hpaiH+GNku9YyK49Kg@mail.gmail.com>
	<alpine.DEB.2.11.1602051340490.28396@cpach.fuggernut.com>
	<0bc701d1604f$8f21e0a0$ad65a1e0$@fisk.me.uk>
	<5848cd48.9Ro.9Gf.h0.1onaHAyHUe@mailjet.com>
	<271250224.21879902.1455215992099.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <271250224.21879902.1455215992099.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jason Dillaman <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

I'm trying to reproduce this.

Jason, I found your commit marks certain cls ops and requiring promotion, 
but that doesn't include rbd... and I'm not sure why info would need to be 
promoted.  Working on reproducing this under hammer with the appropriate 
recency settings.

sage


On Thu, 11 Feb 2016, Jason Dillaman wrote:

> What's your cache mode?  In the master branch, I would expect that class method ops should force a promotion to the cache tier if the base tier is an EC pool [1].
> 
> [1] https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L8905
> 
> -- 
> 
> Jason Dillaman 
> 
> 
> ----- Original Message -----
> > From: "Nick Fisk" <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
> > To: "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Samuel Just" <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: "Jason Dillaman" <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Sent: Thursday, February 11, 2016 12:46:38 PM
> > Subject: RE: cls_rbd ops on rbd_id.$name objects in EC pool
> > 
> > Hi Sage,
> > 
> > Do you think this will get fixed in time for the Jewel release? It still
> > seems to happen in Master and is definitely related to the recency setting.
> > I'm guessing that the info command does some sort of read and then a write.
> > In the old behaviour the read would have always triggered a promotion?
> > 
> > 
> > nick@Ceph-Test:~$ ceph osd pool get cache1 min_read_recency_for_promote
> > min_read_recency_for_promote: 8
> > nick@Ceph-Test:~$ ceph osd pool get cache1 min_write_recency_for_promote
> > min_write_recency_for_promote: 8
> > nick@Ceph-Test:~$ rbd -p cache1 create Test99 --size=10G
> > nick@Ceph-Test:~$ rbd -p cache1 info Test99
> > rbd image 'Test99':
> >         size 10240 MB in 2560 objects
> >         order 22 (4096 kB objects)
> >         block_name_prefix: rbd_data.e8e734689a5e
> >         format: 2
> >         features: layering
> >         flags:
> > nick@Ceph-Test:~$ rados -p cache1 cache-flush rbd_id.Test99
> > nick@Ceph-Test:~$ rados -p cache1 cache-evict rbd_id.Test99
> > nick@Ceph-Test:~$ rbd -p cache1 info Test99
> > 2016-02-11 17:39:40.942030 7f0006eb3700 -1 librbd::image::OpenRequest: failed
> > to retrieve image id: (95) Operation not supported
> > 2016-02-11 17:39:40.942205 7f00066b2700 -1 librbd::ImageState: failed to open
> > image: (95) Operation not supported
> > rbd: error opening image Test99: (95) Operation not supported
> > nick@Ceph-Test:~$ ceph osd pool set cache1 min_read_recency_for_promote 0
> > set pool 12 min_read_recency_for_promote to 0
> > nick@Ceph-Test:~$ rbd -p cache1 info Test99
> > rbd image 'Test99':
> >         size 10240 MB in 2560 objects
> >         order 22 (4096 kB objects)
> >         block_name_prefix: rbd_data.e8e734689a5e
> >         format: 2
> >         features: layering
> >         flags:
> > 
> > 
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Nick Fisk [mailto:nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org]
> > > Sent: 05 February 2016 19:58
> > > To: 'Sage Weil' <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; 'Samuel Just' <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > Cc: 'Jason Dillaman' <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org;
> > > ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Subject: RE: cls_rbd ops on rbd_id.$name objects in EC pool
> > > 
> > > > -----Original Message-----
> > > > From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-
> > > > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sage Weil
> > > > Sent: 05 February 2016 18:45
> > > > To: Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > > Cc: Jason Dillaman <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>;
> > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > Subject: Re: cls_rbd ops on rbd_id.$name objects in EC pool
> > > >
> > > > On Fri, 5 Feb 2016, Samuel Just wrote:
> > > > > On Fri, Feb 5, 2016 at 7:53 AM, Jason Dillaman <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > > wrote:
> > > > > > #1 and #2 are awkward for existing pools since we would need a
> > > > > > tool to inject dummy omap values within existing images.  Can the
> > > > > > cache tier force-promote it from the EC pool to the cache when an
> > > > > > unsupported op is encountered?  There is logic like that in
> > > > > > jewel/master for handling the proxied writes.
> > > >
> > > > That sounded familiar but I couldn't find this in the code or history
> > > > between infernalis and master.  And then I went back and was unable to
> > > > reproduce the a problem on either infernalis branch or v9.2.0.
> > > >
> > > > Nick, I was doing
> > > >  1013  ./rbd -p ec create foo --size 10
> > > >  1014  ./rbd -p ec info foo
> > > >  1015  ./rados -p ec-cache cache-flush rbd_id.foo
> > > >  1016  ./rados -p ec-cache cache-evict rbd_id.foo
> > > >  1017  ./rbd -p ec info foo
> > > >  1018  ./rados -p ec-cache ls -
> > > >
> > > > The rbd.get_id is successfully forcing a promotion.
> > > >
> > > > Which makes me think something else is going on... Nick, can you try
> > > > to reproduce this with a userspace librbd client?  'rbd info' will do
> > > > a few basic operations, but if that isn't problematic, try 'rbd
> > > > bench-write' or 'rbd export', which will do real IO?
> > > 
> > > Hi Sage,
> > > 
> > > Just tried again and I can confirm its definitely not working, but I think
> > > I may
> > > have stumbled on the reason why.
> > > 
> > > First apologies for not mentioning it before, but I am still running that
> > > recency
> > > fix on Infernalis. Initially I thought this was a flushing issue as I just
> > > assumed
> > > those objects shouldn't get flushed out at all. But after reading your
> > > email
> > > where you said it forced the promotion, it struck me that the broken
> > > recency
> > > behaviour may have been masking this issue. With the fix it would only
> > > promote if the object was hot enough, which it probably in most cases
> > > wouldn't be. As a test I set my recency's down to 0 and tried the steps
> > > above
> > > again and this time it worked. Does this make sense?
> > > 
> > > Nick
> > > 
> > > >
> > > > sage
> > > >
> > > >
> > > > > -Sam
> > > > >
> > > > > >
> > > > > > --
> > > > > >
> > > > > > Jason Dillaman
> > > > > >
> > > > > > ----- Original Message -----
> > > > > >> From: "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > > > >> To: "Nick Fisk" <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
> > > > > >> Cc: "Jason Dillaman" <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
> > > > > >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > >> Sent: Friday, February 5, 2016 10:42:17 AM
> > > > > >> Subject: cls_rbd ops on rbd_id.$name objects in EC pool
> > > > > >>
> > > > > >> On Wed, 27 Jan 2016, Nick Fisk wrote:
> > > > > >> >
> > > > > >> > > -----Original Message-----
> > > > > >> > > From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org]
> > > > > >> > > On Behalf Of Jason Dillaman
> > > > > >> > > Sent: 27 January 2016 14:25
> > > > > >> > > To: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
> > > > > >> > > Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > >> > > Subject: Re: [ceph-users] Possible Cache Tier Bug - Can
> > > > > >> > > someone confirm
> > > > > >> > >
> > > > > >> > > Are you running with an EC pool behind the cache tier? I know
> > > > > >> > > there was an issue with the first Infernalis release where
> > > > > >> > > unsupported ops were being proxied down to the EC pool,
> > > > > >> > > resulting in that same error.
> > > > > >> >
> > > > > >> > Hi Jason, yes I am. 3x Replicated pool on top of an EC pool.
> > > > > >> >
> > > > > >> > It's probably something similar to what you mention. Either the
> > > > > >> > client should be able to access the RBD header object on the
> > > > > >> > base pool, or it should be flagged so that it can't be evicted.
> > > > > >>
> > > > > >> I just confirmed that the rbd_id.$name object doesn't have any
> > > > > >> omap, so from rados's perspective, flushing and evicting it is
> > > > > >> fine.  But yeah, the cls_rbd ops aren't permitted in the EC pool.
> > > > > >>
> > > > > >> In master/jewel we have a cache-pin function that prevents an
> > > > > >> object from being flushed.
> > > > > >>
> > > > > >> A few options are:
> > > > > >>
> > > > > >> 1) Have cls_rbd cache-pin it's objects.
> > > > > >>
> > > > > >> 2) Have cls_rbd put an omap key on the object to indirectly do
> > > > > >> the
> > > > same.
> > > > > >>
> > > > > >> 3) Add a requires-cls type object flag that keeps hte object out
> > > > > >> of an EC pool *until* it eventually supports cls ops.
> > > > > >>
> > > > > >> I'd lean toward 1 since it's simple and explicit, and when we
> > > > > >> eventually make classes work we can remove the cache-pin behavior
> > > > from cls_rbd.
> > > > > >> It's harder to fix in infernalis unless we also backport
> > > > > >> cache-pin/unpin ops, too, so maybe #2 would be a simple
> > > > > >> infernalis
> > > > workaround?
> > > > > >>
> > > > > >> Jason?  Sam?
> > > > > >> sage
> > > > > >>
> > > > > >>
> > > > > >>
> > > > > >> >
> > > > > >> > >
> > > > > >> > > --
> > > > > >> > >
> > > > > >> > > Jason Dillaman
> > > > > >> > >
> > > > > >> > >
> > > > > >> > > ----- Original Message -----
> > > > > >> > > > From: "Nick Fisk" <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
> > > > > >> > > > To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > >> > > > Sent: Wednesday, January 27, 2016 8:46:53 AM
> > > > > >> > > > Subject: [ceph-users] Possible Cache Tier Bug - Can someone
> > > > > >> > > > confirm
> > > > > >> > > >
> > > > > >> > > > Hi All,
> > > > > >> > > >
> > > > > >> > > > I think I have stumbled on a bug. I'm running Infernalis
> > > > > >> > > > (Kernel 4.4 on the
> > > > > >> > > > client) and it seems that if the RBD header object gets
> > > > > >> > > > evicted from the cache pool then you can no longer map it.
> > > > > >> > > >
> > > > > >> > > > Steps to reproduce
> > > > > >> > > >
> > > > > >> > > > rbd -p cache1 create Test --size=10G rbd - p cache1 map
> > > > > >> > > > Test
> > > > > >> > > >
> > > > > >> > > > /dev/rbd1  <-Works!!
> > > > > >> > > >
> > > > > >> > > > rbd unmap /dev/rbd1
> > > > > >> > > >
> > > > > >> > > > rados -p cache1 cache-flush rbd_id.Test rados -p cache1
> > > > > >> > > > cache-evict rbd_id.Test rbd - p cache1 map Test
> > > > > >> > > >
> > > > > >> > > > rbd: sysfs write failed
> > > > > >> > > > rbd: map failed: (95) Operation not supported
> > > > > >> > > >
> > > > > >> > > > or with the rbd-nbd client
> > > > > >> > > >
> > > > > >> > > > 2016-01-27 13:39:52.686770 7f9e54162b00 -1
> > > > > >> > > > asok(0x561837b88360)
> > > > > >> > > > AdminSocketConfigObs::init: failed:
> > > > AdminSocket::bind_and_listen:
> > > > > >> > > > failed to bind the UNIX domain socket to
> > > > > >> > > > '/var/run/ceph/ceph-client.admin.asok': (17) File exists
> > > > > >> > > > 2016-01-27 13:39:52.703987 7f9e32ffd700 -1
> > > > librbd::image::OpenRequest:
> > > > > >> > > > failed to retrieve image id: (95) Operation not supported
> > > > > >> > > > rbd-nbd: failed to map, status: (95) Operation not
> > > > > >> > > > supported
> > > > > >> > > > 2016-01-27 13:39:52.704138 7f9e327fc700 -1
> > > > > >> > > > librbd::ImageState: failed to open image: (95) Operation
> > > > > >> > > > not supported
> > > > > >> > > >
> > > > > >> > > > Nick
> > > > > >> > > >
> > > > > >> > > > _______________________________________________
> > > > > >> > > > ceph-users mailing list
> > > > > >> > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > >> > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > > >> > > >
> > > > > >> > > _______________________________________________
> > > > > >> > > ceph-users mailing list
> > > > > >> > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > >> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > > >> >
> > > > > >> > _______________________________________________
> > > > > >> > ceph-users mailing list
> > > > > >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > > >> >
> > > > > >> >
> > > > > >> --
> > > > > >> To unsubscribe from this list: send the line "unsubscribe
> > > > > >> ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > >> More majordomo info at
> > > > > >> http://vger.kernel.org/majordomo-info.html
> > > > > >>
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > > ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > >
> > > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More
> > > majordomo
> > > > info at http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
