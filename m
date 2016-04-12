From: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Deprecating ext4 support
Date: Tue, 12 Apr 2016 22:08:55 +0100
Message-ID: <4f0f087c.9Ro.9Gf.hg.1qX1VyMOaD@mailjet.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
	<4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz>
	<alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
	<8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz>
	<alpine.DEB.2.11.1604121525020.29593@cpach.fuggernut.com>
	<2CBEF339-052C-42D8-A6EA-5BA9C5B8DE9F@schermer.cz>
	<alpine.DEB.2.11.1604121639590.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1604121639590.29593-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
Content-Language: en-gb
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Sage Weil' <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, 'Jan Schermer' <jan-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>
Cc: 'ceph-devel' <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'ceph-users' <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Jan,

I would like to echo Sage's response here. It seems you only want a subset
of what Ceph offers, whereas RADOS is designed to offer a whole lot more,
which requires a lot more intelligence at the lower levels.

I must say I have found your attitude to both Sage and the Ceph project as a
whole over the last few emails quite disrespectful. I spend a lot of my time
trying to sell the benefits of open source, which centre on the openness of
the idea/code and not around the fact that you can get it for free. One of
the things that I like about open source is the constructive, albeit
sometimes abrupt, constructive criticism that results in a better product.
Simply shouting Ceph is slow and it's because dev's don't understand
filesystems is not constructive.

I've just come back from an expo at ExCel London where many providers are
passionately talking about Ceph. There seems to be a lot of big money
sloshing about for something that is inherently "wrong"

Sage and the core Ceph team seem like  very clever people to me and I trust
that over the years of development, that if they have decided that standard
FS's are not the ideal backing store for Ceph, that this is probably correct
decision. However I am also aware that the human condition "Can't see the
wood for the trees" is everywhere and I'm sure if you have any clever
insights into filesystem behaviour, the Ceph Dev team would be more than
open to suggestions.

Personally I wish I could contribute more to the project as I feel that I
(any my company) get more from Ceph than we put in, but it strikes a nerve
when there is such negative criticism for what effectively is a free
product.

Yes, I also suffer from the problem of slow sync writes, but the benefit of
being able to shift 1U servers around a Rack/DC compared to a SAS tethered
4U jbod somewhat outweighs that as well as several other advanatages. A new
cluster that we are deploying has several hardware choices which go a long
way to improve this performance as well. Coupled with the coming Bluestore,
the future looks bright.

> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of
> Sage Weil
> Sent: 12 April 2016 21:48
> To: Jan Schermer <jan-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>
> Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; ceph-users <ceph-
> users-Qp0mS5GaXlQ@public.gmane.org>; ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
> Subject: Re: [ceph-users] Deprecating ext4 support
> 
> On Tue, 12 Apr 2016, Jan Schermer wrote:
> > Still the answer to most of your points from me is "but who needs that?"
> > Who needs to have exactly the same data in two separate objects
> > (replicas)? Ceph needs it because "consistency"?, but the app (VM
> > filesystem) is fine with whatever version because the flush didn't
> > happen (if it did the contents would be the same).
> 
> If you want replicated VM store that isn't picky about consistency, try
> Sheepdog.  Or your mdraid over iSCSI proposal.
> 
> We care about these things because VMs are just one of many users of
> rados, and because even if we could get away with being sloppy in some (or
> even most) cases with VMs, we need the strong consistency to build other
> features people want, like RBD journaling for multi-site async
replication.
> 
> Then there's the CephFS MDS, RGW, and a pile of out-of-tree users that
> chose rados for a reason.
> 
> And we want to make sense of an inconsistency when we find one on scrub.
> (Does it mean the disk is returning bad data, or we just crashed during a
write
> a while back?)
> 
> ...
> 
> Cheers-
> sage
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
