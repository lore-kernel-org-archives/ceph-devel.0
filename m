From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 16:48:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706301642570.3424@piezo.novalocal>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
	<c4cf8858-6c29-4ec7-7ffa-479781258569@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <c4cf8858-6c29-4ec7-7ffa-479781258569-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Lenz Grimmer <lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 30 Jun 2017, Lenz Grimmer wrote:
> Hi Sage,
> 
> On 06/30/2017 05:21 AM, Sage Weil wrote:
> 
> > The easiest thing is to
> > 
> > 1/ Stop testing filestore+btrfs for luminous onward.  We've recommended 
> > against btrfs for a long time and are moving toward bluestore anyway.
> 
> Searching the documentation for "btrfs" does not really give a user any
> clue that the use of Btrfs is discouraged.
> 
> Where exactly has this been recommended?
> 
> The documentation currently states:
>
> http://docs.ceph.com/docs/master/rados/configuration/ceph-conf/?highlight=btrfs#osds
> 
> "We recommend using the xfs file system or the btrfs file system when
> running mkfs."
> 
> http://docs.ceph.com/docs/master/rados/configuration/filesystem-recommendations/?highlight=btrfs#filesystems
> 
> "btrfs is still supported and has a comparatively compelling set of
> features, but be mindful of its stability and support status in your
> Linux distribution."
> 
> http://docs.ceph.com/docs/master/start/os-recommendations/?highlight=btrfs#ceph-dependencies
> 
> "If you use the btrfs file system with Ceph, we recommend using a recent
> Linux kernel (3.14 or later)."
> 
> As an end user, none of these statements would really sound as
> recommendations *against* using Btrfs to me.
> 
> I'm therefore concerned about just disabling the tests related to
> filestore on Btrfs while still including and shipping it. This has
> potential to introduce regressions that won't get caught and fixed.

Ah, crap.  This is what happens when devs don't read their own 
documetnation.  I recommend against btrfs every time it ever comes up, the 
downstream distributions all support only xfs, but yes, it looks like the 
docs never got updated... despite the xfs focus being 5ish years old now.

I'll submit a PR to clean this up, but
 
> > 2/ Leave btrfs in the mix for jewel, and manually tolerate and filter out 
> > the occasional ENOSPC errors we see.  (They make the test runs noisy but 
> > are pretty easy to identify.)
> > 
> > If we don't stop testing filestore on btrfs now, I'm not sure when we 
> > would ever be able to stop, and that's pretty clearly not sustainable.
> > Does that seem reasonable?  (Pretty please?)
> 
> If you want to get rid of filestore on Btrfs, start a proper deprecation
> process and inform users that support for it it's going to be removed in
> the near future. The documentation must be updated accordingly and it
> must be clearly emphasized in the release notes.
> 
> Simply disabling the tests while keeping the code in the distribution is
> setting up users who happen to be using Btrfs for failure.

I don't think we can wait *another* cycle (year) to stop testing this.

We can, however,

 - prominently feature this in the luminous release notes, and
 - require the 'enable experimental unrecoverable data corrupting features =
btrfs' in order to use it, so that users are explicitly opting in to 
luminous+btrfs territory.

The only good(ish) news is that we aren't touching FileStore if we can 
help it, so it less likely to regress than other things.  And we'll 
continue testing filestore+btrfs on jewel for some time.

Is that good enough?

sage
