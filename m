From: Sebastien Ponce <sebastien.ponce-vJEk5272eHo@public.gmane.org>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 22:25:15 +0200
Message-ID: <1399321515.14136.8.camel@seblap.cern.ch>
References: <980181538.654650.1399300829103.JavaMail.zimbra@redhat.com>
	<355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
	<CABBk=J8=GgAPM7qWfs9=OZt6yHVERggiugPui31w4b=GPk8Oow@mail.gmail.com>
	<1793642728.775752.1399309685692.JavaMail.zimbra@redhat.com>
	<CA+4uBUaOWEwpet3dr1mzYQtr_Xju8a3aCgFAf4BCu22WGQ+aZg@mail.gmail.com>
	<1666953774.790843.1399311496408.JavaMail.zimbra@redhat.com>
	<CA+4uBUavv2d63qn0zY=yfS7KV4c45JH6Dr0PupKa+zTOh2GC1Q@mail.gmail.com>
	<324933830.809209.1399313264579.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
In-Reply-To: <324933830.809209.1399313264579.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://supercolony.gluster.org/mailman/options/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <http://supercolony.gluster.org/pipermail/gluster-devel/>
List-Post: <mailto:gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://supercolony.gluster.org/mailman/listinfo/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
Errors-To: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
To: Jeff Darcy <jdarcy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org, Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Samuel Just <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> The data distribution
> issue has turned out to be a practical non-issue for GlusterFS
> users.  Sure, if you have very few "elephant objects" on very few
> small-ish bricks (our equivalent of OSDs) then you can get skewed
> distribution.  On the other hand, that problem *very* quickly
> solves itself for even moderate object and brick counts, to the
> point that almost no users have found it useful to enable striping.
> Has your experience been different, or do you not know because
> striping is mandatory instead of optional?

We have indeed an example of a case where striping is needed here at
CERN : we are starting to test rados as a backend for the disk cache of
our mass storage system (understand tape backend). There, files can
indeed be really big (up to TB level) and we need parallel accesses to
be able to feed our tape drives to their limit of > 250MB/s.

The solution has been to implement a layer of striping on top of rados
that "hides" the striping while basically keeping the rados interface
and (most of) the consistency and locking.
This is currently not integrated in the ceph mainstream but is available
and ready for merge. See blue print at
https://wiki.ceph.com/Planning/Blueprints/Firefly/Object_striping_in_librados#section_4 and implementation/pull request at https://github.com/ceph/ceph/pull/1186.
By the way, it needs some review :-)

Sebastien
