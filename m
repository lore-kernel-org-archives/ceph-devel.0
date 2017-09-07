From: Lars Marowsky-Bree <lmb-IBi9RG/b67k@public.gmane.org>
Subject: Re: [Ceph-maintainers] Ceph release cadence
Date: Thu, 7 Sep 2017 13:39:13 +0200
Message-ID: <20170907113913.wutbtiy2pavl5mfc@suse.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 2017-09-06T15:23:34, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

Hi Sage,

thanks for kicking off this discussion - after the L experience, it was
on my hot list to talk about too.

I do agree that we need predictable releases more than feature-rich
releases. Distributors like to plan, but that's not a reason. However,
we like to plan because *users* like to plan their schedules and
upgrades, and I think that matters more.

> - Not a lot of people seem to run the "odd" releases (e.g., infernalis, =

> kraken).  This limits the value of actually making them.  It also means =

> that those who *do* run them are running riskier code (fewer users -> mor=
e =

> bugs).

Yes. Odd releases never really make it to user systems. They're on the
previous LTS release. In the devel releases, the code is often too
unstable, and developers seem to cram everything in. Basically, the odd
releases are long periods working up to the next stable release.

(And they get all the cool names, which I find personally sad. I want my
users to run Infernalis, Kraken, and Mimic. ;-)

> - The more recent requirement that upgrading clusters must make a stop at =

> each LTS (e.g., hammer -> luminous not supported, must go hammer -> jewel =

> -> lumninous) has been hugely helpful on the development side by reducing =

> the amount of cross-version compatibility code to maintain and reducing =

> the number of upgrade combinations to test.

On this, I feel that it might make more sense to phrase this so that
such cross version compatibility is not tied to major releases (which
doesn't really help them plan lifecycles if those releases aren't
reliable), but to time periods.

> - When we try to do a time-based "train" release cadence, there always =

> seems to be some "must-have" thing that delays the release a bit.  This =

> doesn't happen as much with the odd releases, but it definitely happens =

> with the LTS releases.  When the next LTS is a year away, it is hard to =

> suck it up and wait that long.

Yes, I can see that. This is clearly something we'd want to avoid.

> A couple of options:
> =

> * Keep even/odd pattern, and continue being flexible with release dates

I admit I'm not a fan of this one.

> * Drop the odd releases but change nothing else (i.e., 12-month release =

> cadence)
>   + eliminate the confusing odd releases with dubious value

Periods too long for regular users. Admittedly, I suspect for RH and
SUSE with RHCS or SES respectively, this doesn't matter much - but it's
not good for the community as a whole. Also, this means not enough
community / end-user testing will happen for 11 out of those 12 months,
implying such long cycles make it hard to release n+1.0 in high
quality.

I've been doing software development for almost two decades, and no user
really touches betas before one calls it an RC, and even then ...

> * Drop the odd releases, and aim for a ~9 month cadence. This splits the =

> difference between the current even/odd pattern we've been doing.

It's a step up, but the period is still both too long, and unaligned.
This makes lifecycle management for everyone annoying.

> * Drop the odd releases, but relax the "must upgrade through every LTS" t=
o =

> allow upgrades across 2 versions (e.g., luminous -> mimic or luminous -> =

> nautilus).  Shorten release cycle (~6-9 months).
> =

>   + more flexibility for users
>   + downstreams have greater choice in adopting an upstrema release
>   - more LTS branches to maintain
>   - more upgrade paths to consider

From the list of options you provide, I like this one the best; the ~6
month release cycle means there should be one about once per year as
well, which makes cycling easier to plan.

> Other options we should consider?  Other thoughts?

With about 20-odd years in software development, I've become a big
believer in schedule-driven releases. If it's feature-based, you never
know when they'll get done.

If the schedule intervals are too long though, the urge to press too
much in (so as not to miss the next merge window) is just too high,
meaning the train gets derailed. (Which cascades into the future,
because the next time the pressure will be even higher based on the
previous experience.) This requires strictness.

We've had a few Linux kernel releases that were effectively feature
driven and never quite made it. 1.3.x? 1.5.x? My memory is bad, but they
were a disaster than eventually led Linus to evolve to the current
model.

That serves them really well, and I believe it might be worth
considering for us.

I'd try to move away from the major milestones. Features get integrated
into the next schedule-driven release when they deemed ready and stable;
when they're not, not a big deal, the next one is coming up "soonish".

(This effectively decouples feature development slightly from the
release schedule.)

We could even go for "a release every 3 months, sharp", merge window for
the first month, stabilization the second, release clean up the third,
ship.

Interoperability hacks for the cluster/server side are maintained for 2
years, and then dropped.  Sharp. (Speaking as one of those folks
affected, we should not burden the community with this.) Client interop
is a different story, a bit.

Basically, effectively edging towards continuous integration of features
and bugfixes both. Nobody has to wait for anything much, and can
schedule reasonably independently.

There is a single LTS release: Ceph. Keep on rolling.

Also, Mimic is a good release to pick for a change like this, because it
can be everything to everyone ;-)


Regards,
    Lars

-- =

Architect SDS, Distinguished Engineer
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton, HRB=
 21284 (AG N=FCrnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde
