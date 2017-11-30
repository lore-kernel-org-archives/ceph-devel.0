From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Thu, 30 Nov 2017 14:04:25 +0100
Message-ID: <20171130130425.snmqxfpw4f6dl4is@nora.maurer-it.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
 <4c4b5589-b1ae-3f8b-e900-af0f2895fbc9@corp.ovh.com>
 <CAC-Np1zsf+uqFi+ZdR7K3=re5ODpJvWFrTX-JU_8DkkyVGOz7A@mail.gmail.com>
 <d548c5a8-c0dc-0737-66f4-e3fc04f900d7@digiware.nl>
 <CAN-Gep+RmSB6gW5GRVsT8T7j60EAzGnfbgeqDjwCNDWocpgp3g@mail.gmail.com>
 <CAKPXa=Yrwpu-hbpOCSsVfq=GyXHTJ9K8iiLKSJuaYDdBpR+_0A@mail.gmail.com>
 <20171130113155.ce5qu2x34kiqooss@nora.maurer-it.com>
 <CAC-Np1wo_j5MBXTzm5kp-MjWiV=vkL+5Xt88SS617MJ4qmh5UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC-Np1wo_j5MBXTzm5kp-MjWiV=vkL+5Xt88SS617MJ4qmh5UQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Nov 30, 2017 at 07:04:33AM -0500, Alfredo Deza wrote:
> On Thu, Nov 30, 2017 at 6:31 AM, Fabian Gr=FCnbichler
> <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org> wrote:
> > On Tue, Nov 28, 2017 at 10:39:31AM -0800, Vasu Kulkarni wrote:
> >> On Tue, Nov 28, 2017 at 9:22 AM, David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
> >> > Isn't marking something as deprecated meaning that there is a better=
 option
> >> > that we want you to use and you should switch to it sooner than late=
r? I
> >> > don't understand how this is ready to be marked as such if ceph-volu=
me can't
> >> > be switched to for all supported use cases. If ZFS, encryption, Free=
BSD, etc
> >> > are all going to be supported under ceph-volume, then how can ceph-d=
isk be
> >> > deprecated before ceph-volume can support them? I can imagine many C=
eph
> >> > admins wasting time chasing an erroneous deprecated warning because =
it came
> >> > out before the new solution was mature enough to replace the existing
> >> > solution.
> >>
> >> There is no need to worry about this deprecation, Its mostly for
> >> admins to be prepared
> >> for the changes coming ahead and its mostly for *new* installations
> >> that can plan on using ceph-volume which provides
> >> great flexibility compared to ceph-disk.
> >
> > changing existing installations to output deprecation warnings from one
> > minor release to the next means it is not just for new installations
> > though, no matter how you spin it. a mention in the release notes and
> > docs would be enough to get admins to test and use ceph-volume on new
> > installations.
> >
> > I am pretty sure many admins will be bothered by all nodes running OSDs
> > spamming the logs and their terminals with huge deprecation warnings on
> > each OSD activation[1] or other actions involving ceph-disk, and having
> > this state for the remainder of Luminous unless they switch to a new
> > (and as of yet not battle-tested) way of activating their OSDs seems
> > crazy to me.
> >
> > I know our users will be, and given the short notice and huge impact
> > this would have we will likely have to remove the deprecation warnings
> > altogether in our (downstream) packages until we have completed testing
> > of and implementing support for ceph-volume..
> >
> >>
> >> a) many dont use ceph-disk or ceph-volume directly, so the tool you
> >> have right now eg: ceph-deploy or ceph-ansible
> >> will still support the ceph-disk, the previous ceph-deploy release is
> >> still available from pypi
> >>   https://pypi.python.org/pypi/ceph-deploy
> >
> > we have >> 10k (user / customer managed!) installations on Ceph Luminous
> > alone, all using our wrapper around ceph-disk - changing something like
> > this in the middle of a release causes huge headaches for downstreams
> > like us, and is not how a stable project is supposed to be run.
> =

> If you are using a wrapper around ceph-disk, then silencing the
> deprecation warnings should be easy to do.
> =

> These are plain Python warnings, and can be silenced within Python or
> environment variables. There are some details
> on how to do that here https://github.com/ceph/ceph/pull/18989

the problem is not how to get rid of the warnings, but having to when
upgrading from one bug fix release to the next.

> >
> >>
> >> b) also the current push will help anyone who is using ceph-deploy or
> >> ceph-disk in scripts/chef/etc
> >>    to have time to think about using newer cli based on ceph-volume
> >
> > a regular deprecate at the beginning of the release cycle were the
> > replacement is deemed stable, remove in the next release cycle would be
> > adequate for this purpose.
> >
> > I don't understand the rush to shoe-horn ceph-volume into existing
> > supposedly stable Ceph installations at all - especially given the
> > current state of ceph-volume (we'll file bugs once we are done writing
> > them up, but a quick rudimentary test already showed stuff like choking
> > on valid ceph.conf files because they contain leading whitespace and
> > incomplete error handling leading to crush map entries for failed OSD
> > creation attempts).
> =

> Any ceph-volume bugs are welcomed as soon as you can get them to us.
> Waiting to get them reported is a problem, since ceph-volume
> is tied to Ceph releases, it means that these will now have to wait
> for another point release instead of having them in the upcoming one.

we started evaluating ceph-volume at the start of this thread in order
to see whether a switch-over pre-Mimic is feasible. we don't
artificially delay bug reports, it just takes time to to test, find bugs
and report them properly.

> =

> >
> > I DO understand the motivation behind ceph-volume and the desire to get
> > rid of the udev-based trigger mess, but the solution is not to scare
> > users into switching in the middle of a release by introducing
> > deprecation warnings for a core piece of the deployment stack.
> >
> > IMHO the only reason to push or force such a switch in this manner would
> > be a (grave) security or data corruption bug, which is not the case at
> > all here..
> =

> There is no forcing here. A deprecation warning was added, which can
> be silenced.

I did not say you ARE forcing, I said the only reason to push OR force
something like this WOULD be.

> >
> > 1: have you looked at the journal / boot logs of a mid-sized OSD node
> > using ceph-disk for activation with the deprecation warning active?  if
> > my boot log is suddenly filled with 20% warnings, my first reaction will
> > be that something is very wrong.. my likely second reaction when
> > realizing what is going on is probably not fit for posting to a public
> > mailing list ;)
> =

> The purpose of the deprecation warning is to be annoying as you imply
> here, and again, there are mechanisms on how to omit them
> if you understand the issue.

point is - you should not purposefully attempt to annoy users and/or
downstreams by changing behaviour in the middle of an LTS release cycle,
unless there is an important reason to do so. something like this would
not be appropriate during the RC stage in most projects, no matter how
easy it is to work around in case you roll your own deployment scripts /
wrappers / packages..

you'd get almost the same net effect by introducing ceph-volume now (as
new, alternative way of creating and activating OSDs), deprecating
ceph-disk in Mimic (with the big fat warning), and removing it in
Mimic+1 - with much less irritation and annoyed users, and only a little
less new OSDs deployed with ceph-disk instead of ceph-volume.

I still don't see a big enough justification for this push - but maybe I
am missing an important factor? (although based on the other reactions
in this thread, it does not seem like we are the only ones who are
surprised/irritated by this course of action).
