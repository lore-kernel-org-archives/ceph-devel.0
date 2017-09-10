From: Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Ceph-maintainers] Ceph release cadence
Date: Sun, 10 Sep 2017 12:56:31 +0300
Message-ID: <CADRKj5TC26Z=FZpx3TLspQcCoMBXfbpxyMr7iVZfmrxLAtvi_g@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <20170907113913.wutbtiy2pavl5mfc@suse.com>
 <alpine.DEB.2.11.1709081601550.16664@piezo.novalocal>
 <CAJ4mKGaht37m-Gz=Y3R54+BM6PfHwux4CkjTcrz79LUGVd9MMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGaht37m-Gz=Y3R54+BM6PfHwux4CkjTcrz79LUGVd9MMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, Lars Marowsky-Bree <lmb-IBi9RG/b67k@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I'm not a huge fan of train releases, as they tend to never quite make
it on time and it always feels a bit artificial timeline anyway. OTOH,
I do see and understand the need of a predictable schedule with a
roadmap attached to it. There are many that need to have at least a
vague idea on what we're going to ship and when, so that they can plan
ahead. We need it ourselves, as sometimes the schedule can dictate the
engineering decision that we're going to make.
On the other hand, I think that working towards a release that come
out after 9 or 12 months is a bit too long. This is a recipe for more
delays as the penalty for missing a feature is painful. Maybe we can
consider returning to shorter iterations for *dev* releases. These are
checkpoints that need to happen after a short period (2-3 weeks),
where we end up with a minimally tested release that passes some smoke
test. Features are incrementally added to the dev release. The idea
behind a short term dev release is that it minimizes the window where
master is completely unusable, thus reduces the time to stabilization.
Then it's easier to enforce a train schedule if we want to. It might
be easier to let go of a feature that doesn't make it, as it will be
there soon, and maybe if really needed we (or the downstream
maintainer) can make the decision to backport it. This makes me think
that we could revisit the our backport policy/procedure/tooling, so
that we can do it in a sane and safe way when needed and possible.

Yehuda

On Fri, Sep 8, 2017 at 7:59 PM, Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> I think I'm the resident train release advocate so I'm sure my
> advocating that model will surprise nobody. I'm not sure I'd go all
> the way to Lars' multi-release maintenance model (although it's
> definitely something I'm interested in), but there are two big reasons
> I wish we were on a train with more frequent real releases:
>
> 1) It reduces the cost of features missing a release. Right now if
> something misses an LTS release, that's it for a year. And nobody
> likes releasing an LTS without a bunch of big new features, so each
> LTS is later than the one before as we scramble to get features merged
> in.
>
> ...and then we deal with the fact that we scrambled to get a bunch of
> features merged in and they weren't quite baked. (Luminous so far
> seems to have gone much better in this regard! Hurray! But I think
> that has a lot to do with our feature-release-scramble this year being
> mostly peripheral stuff around user interfaces that got tacked on
> about the time we'd initially planned the release to occur.)
>
> 2) Train releases increase predictability for downstreams, partners,
> and users around when releases will happen. Right now, the release
> process and schedule is entirely opaque to anybody who's not involved
> in every single upstream meeting we have; and it's unpredictable even
> to those who are. That makes things difficult, as Xiaoxi said.
>
> There are other peripheral but serious benefits I'd expect to see from
> fully-validated train releases as well. It would be *awesome* to have
> more frequent known-stable points to do new development against. If
> you're an external developer and you want a new feature, you have to
> either keep it rebased against a fast-changing master branch, or you
> need to settle for writing it against a long-out-of-date LTS and then
> forward-porting it for merge. If you're an FS developer writing a very
> small new OSD feature and you try to validate it against RADOS, you've
> no idea if bugs that pop up and look random are because you really did
> something wrong or if there's currently an intermittent issue in RADOS
> master. I would have *loved* to be able to maintain CephFS integration
> branches for features that didn't touch RADOS and were built on top of
> the latest release instead of master, but it was utterly infeasible
> because there were too many missing features with the long delays.
>
> On Fri, Sep 8, 2017 at 9:16 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> I'm going to pick on Lars a bit here...
>>
>> On Thu, 7 Sep 2017, Lars Marowsky-Bree wrote:
>>> On 2017-09-06T15:23:34, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> > Other options we should consider?  Other thoughts?
>>>
>>> With about 20-odd years in software development, I've become a big
>>> believer in schedule-driven releases. If it's feature-based, you never
>>> know when they'll get done.
>>>
>>> If the schedule intervals are too long though, the urge to press too
>>> much in (so as not to miss the next merge window) is just too high,
>>> meaning the train gets derailed. (Which cascades into the future,
>>> because the next time the pressure will be even higher based on the
>>> previous experience.) This requires strictness.
>>>
>>> We've had a few Linux kernel releases that were effectively feature
>>> driven and never quite made it. 1.3.x? 1.5.x? My memory is bad, but they
>>> were a disaster than eventually led Linus to evolve to the current
>>> model.
>>>
>>> That serves them really well, and I believe it might be worth
>>> considering for us.
>>
>> This model is very appealing.  The problem with it that I see is that the
>> upstream kernel community doesn't really do stable releases.  Mainline
>> developers are just getting their stuff upstream, and entire separate
>> organizations and teams are doing the stable distro kernels.  (There are
>> upstream stable kernels too, yes, but they don't get much testing AFAICS
>> and I'm not sure who uses them.)
>>
>> More importantly, upgrade and on-disk format issues are present for almost
>> everything that we change in Ceph.  Those things rarely come up for the
>> kernel.  Even the local file systems (a small piece of the kernel) have
>> comparatively fewer format changes that we do, it seems.
>>
>> These make the upgrade testing a huge concern and burden for the
>> Ceph development community.
>>
>>> I'd try to move away from the major milestones. Features get integrated
>>> into the next schedule-driven release when they deemed ready and stable;
>>> when they're not, not a big deal, the next one is coming up "soonish".
>>>
>>> (This effectively decouples feature development slightly from the
>>> release schedule.)
>>>
>>> We could even go for "a release every 3 months, sharp", merge window for
>>> the first month, stabilization the second, release clean up the third,
>>> ship.
>>>
>>> Interoperability hacks for the cluster/server side are maintained for 2
>>> years, and then dropped.  Sharp. (Speaking as one of those folks
>>> affected, we should not burden the community with this.) Client interop
>>> is a different story, a bit.
>>>
>>> Basically, effectively edging towards continuous integration of features
>>> and bugfixes both. Nobody has to wait for anything much, and can
>>> schedule reasonably independently.
>>
>> If I read between the lines a bit here, but this sounds like is:
>>
>>  - keep the frequently major releases (but possibly shorten the 6mo
>>    cadence)
>>  - do backports for all of them, not just the even ones
>>  - test upgrades between all of them within a 2 year horizon, instead
>>    of just the last major one
>>
>> Is that accurate?
>>
>> Unfortunately it sounds to me like that would significantly increase the
>> maintenance burden (double it even?) and slow development down.  The user
>> base will also end up fragmented across a broader range of versions, which
>> means we'll see a wider variety of bugs and each release will be less
>> stable.
>>
>> This is full of trade-offs... time we spend backporting or testing
>> upgrades is time we don't spend fixing bugs or improving performance or
>> adding features.
>
> Not all newly-allocated effort for doing maintenance and testing
> necessarily means reducing effort available for new feature
> development. Sometimes it just makes that development easier and more
> efficient!    I think we'd find that more tested and stable releases
> would spread joy and stability throughout our development process and
> make life much easier on prospective contributors.
> -Greg
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
