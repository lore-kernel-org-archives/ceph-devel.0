From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: mon IO usage
Date: Tue, 21 May 2013 09:10:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305210909190.16413@cobra.newdream.net>
References: <CAF6-1L4oWCwNxywALb=cUNP_pbD=ND631MJqvCWyvAfvNdWauQ@mail.gmail.com>
	<519B6F28.9000400@scholarstack.com>
	<519B75B2.4070405@scholarstack.com>
	<CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
	<alpine.DEB.2.00.1305210854320.16413@cobra.newdream.net>
	<CAF6-1L4C1QQHZ_5=3OCATFTCD_As63HEjJLcKsGURAV02PFQPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF6-1L4C1QQHZ_5=3OCATFTCD_As63HEjJLcKsGURAV02PFQPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sylvain Munaut <s.munaut-IEbV4ISQ1OTUSxYbhEqsfVaTQe2KTcn/@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, Mike Dawson <mike.dawson-9dgm/EUDD3RBYT3KYJiKsA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 21 May 2013, Sylvain Munaut wrote:
> Hi,
> 
> >> So, AFAICT, the bulk of the write would be writing out the pgmap to
> >> disk every second or so.
> >
> > It should be writing out the full map only every N commits... see 'paxos
> > stash full interval', which defaults to 25.
> 
> But doesn't it also write it in full when there is a new pgmap ?
> 
> I have a new one about every second and its size * period seemed to
> match the IO rate pretty well which it why I thought it was the reason
> for the IO.

Hmm.  Can you generate a log with 'debug mon = 20', 'debug paxos = 20', 
'debug ms = 1' for a few minutes over which you see a high data rate and 
send it my way?  It sounds like there is something wrong with the 
stash_full logic.

Thanks!

> >> Is it really needed to write it in full ? It doesn't change all that
> >> much AFAICT, so writing incremental changes with only periodic flush
> >> might be a better option ?
> >
> > Right.  It works this way now only because we haven't fully transitioned
> > from the old scheme.  The next step is to store the PGMap over lots of
> > leveldb keys (one per pg) so that there is no big encode/decode of the
> > entire PGMap structure...
> 
> Makes sense. I'm not sure of the "per-key" overhead of leveldb though,
> in case where there are lots ( > 10k ) PGs.

Yeah, it will be larger on-disk, but the io rate will at least be 
proportional to the update rate.  :)

sage
