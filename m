From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: ceph versions
Date: Thu, 26 Feb 2015 16:32:30 -0800
Message-ID: <mcodv0$e87$1@ger.gmane.org>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55915 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbbB0Acu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 19:32:50 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YR8rH-0005pq-Vv
	for ceph-devel@vger.kernel.org; Fri, 27 Feb 2015 01:32:48 +0100
Received: from 50.245.141.77 ([50.245.141.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 01:32:47 +0100
Received: from eternaleye by 50.245.141.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 01:32:47 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Commentary inline.

Note that when I talk about dependencies, I'm speaking as someone who does 
distro packaging - and thus what would require manual changes on the 
packager's part vs. ability to specify general constraints.

Sage Weil wrote:

> Hammer will most likely be v0.94[.x].  We're getting awfully close to
> 0.99, though, which makes many people think 1.0 or 1.00 (isntead of
> 0.100), and the current versioning is getting a bit silly.  So let's talk
> about alternatives!
> 
> Here are a few of options:
> 
> -- Option A -- "doubles and triples"
> 
> X.Y[.Z]
> 
>  - Increment X at the start of each major dev cycle (hammer, infernalis)
>  - Increment Y for each iteration during that cycle
>  - Eventually decide it's good and start adding .Z for the stable fixes.
> 
> For example,
> 
>  1.0 first infernalis dev release
>  1.1 dev release
>  ...
>  1.8 infernalis rc
>  1.9 infernalis final
>  1.9.1 stable update
>  1.9.2 stable update
>  ...
>  2.0 first j (jewel?) dev release
>  2.1 next dev release
>  ...
>  2.8 final j
>  2.8.x stable j releases
> 
> Q: How do I tell if it's a stable release?
> A: It is a triple instead of a double.
> 
> Q: How do I tell if this is the final release in the series?
> A: Nobody knows that until we start doing stable updates; see above.

Pros:
- Linux uses this, so there's some precedent
- Mapping names to numbers is clear

Cons:
- Do we define X.Y.0 as the first stable, or an alias for X.Y?
- Impossible to express the stable/unstable constraint in terms of 
dependencies
- Impossible to express breaking-change constraint in terms of dependencies

> -- Option B -- "even/odd"
> 
> X.Y.Z
> 
>  - if Y is even, this is a stable series
>  - if Y is odd, this is a dev release
>  - increment X when something major happens
> 
>  1.0 hammer final
>  1.0.1 stable/bugfix
>  1.0.2 stable
>  1.0.3 stable
>  ...
>  1.1.0 infernalis dev release
>  1.1.1 infernalis dev release
>  1.1.2 infernalis dev release
>  ...
>  1.2.0 infernalis final
>  1.2.1 stable branch
>  ...
>  1.3.0 j-release dev
>  1.3.1 j-release dev
>  1.3.2 j-release dev
>  ...
>  1.4.0 j-release final
>  1.4.1 stable
>  1.4.1 stable
> 
> Q: How do I tell if it's a stable release?
> A: Second item is even.

Pros:
- Linux used to do this (and the reasons it stopped don't really apply)
- Some other projects still do this
- Mapping names to numbers is clear

Cons:
- Impossible to express the stable/unstable constraint in terms of 
dependencies
- Impossible to express breaking-change constraint in terms of dependencies

> -- Option C -- "semantic"
> 
> major.minor.patch
> 
> - MAJOR version when you make incompatible API changes,
> - MINOR version when you add functionality in a backwards-compatible
> manner, and
> - PATCH version when you make backwards-compatible bug fixes.
> 
>  1.0.0 hammer final
>  1.0.1 bugfix
>  1.0.1 bugfix
>  1.0.1 bugfix
>  1.1 infernalis dev release
>  1.2 infernalis dev release
>  2.0 infernalis dev release
>  2.1 infernalis dev release
>  2.2 infernalis dev release
>  2.3 infernalis final
>  2.3.0 bugfix
>  2.3.1 bugfix
>  2.3.2 bugfix
>  2.4 j dev release
>  ...
>  2.14 j final
>  2.14.0 bugfix
>  2.14.1 bugfix
>  ...
>  2.15 k dev
>  ..
>  3.3 k final
>  3.3.1 bugfix
>  ...
>  
> Q: How do I tell what named release series this is?
> A: As with the others, you just have to know.
> 
> Q: How do we distinguish between stable-series updates and dev updates?
> A: Stable series are triples.
> 
> Q: How do I know if I can downgrade?
> A: The major hasn't changed.
> 
> Q: Really?
> A: Well, maybe.  We haven't dealt with downgrades yet so this assumes we
> get it right (and test it).  We may not realize there is a
> backward-incompatible change right away and only discover it later during
> testing, at which point the versions are fixed; we'd probably bump the
> *next* release in response.

Pros:
- Dependencies can express breaking-change constraints
- Strong adoption in the language-packaging world (Ruby, Node, Rust...)
- Determining whether the major needs bumped could possibly be automated

Cons:
- Mapping names to numbers is nontrivial
- Impossible to express stable/unstable constraint in terms of dependencies
- Requires more developer effort to determine what version to release with

> -- Option D -- "labeled"
> 
> X.Y-{dev,rc,release}Z
> 
>  - Increment Y on each major named release
>  - Increment X if it's a major major named release (bigger change
> than usual)
>  - Use dev, rc, or release prefix to clearly label what type of release
> this is
>  - Increment Z for stable updates
> 
>  1.0-dev1 first infernalis dev release
>  1.0-dev2 another dev release
>  ...
>  1.0-rc1 first rc
>  1.0-rc2 next rc
>  1.0-release1 final release
>  1.0-release2 stable update
>  1.0-release3 stable update
>  1.1-dev1 first cut for j-release
>  1.1-dev2 ...
>  ...
>  1.1-rc1
>  1.1-release1 stable
>  1.1-release2 stable
>  1.1-release3 stable
> 
> Q: How do I tell what kind of release this is?
> A: Look at the string embedded in the version
> 
> Q: Will these funny strings confuse things that sort by version?
> A: I don't think so.

Pros:
- Mapping versions to names is easy

Cons:
- Impossible to express the stable/unstable constraint in terms of 
dependencies
- Impossible to express breaking-change constraint in terms of dependencies
- Special strings either complicate packaging (need to map dependency-safe 
version format to this) or require separate packages for each chain (and if 
they're not parallel installable, further complexity shows up)

> -- Option E -- "ubuntu"
> 
> YY.MM[.Z]
> 
>  - YY is year, MM is month of release
>  - Z for stable updates
> 
>  15.03 hammer final
>  15.03.1 bugfix
>  15.03.2 bugfix
>  ...
>  15.04 infernalis dev
>  15.05 infernalis dev
>  ...
>  15.07 infernalis final
>  15.07.1 bugfix
>  15.07.2 bugfix
>  ...
> 
> Q: What if we have more than one dev release a month?  Like, on a 2 weeks
> schedule, as we have been.
> A: We move to monthly dev releases.  Or, we put an 'a' or 'b' suffix on
> there?  Meh.
> 
> Q: How do I tell if it's a stable release?
> A: It's a triple.

Pros:
- Simple

Cons:
- Impossible to express stable/unstable constraint in terms of dependencies
- Impossible to express breaking-change constraint in terms of dependencies
- Hard to map versions to names
- "Meh" is the _worst_ thing a packager can hear from a dev regarding a 
versioning system

> -- Option F -- "flat"
> 
> X[.Y]
> 
>  - increment X on every release, regardless of whether it is a named
> release or not
>  - add a .Y (or .0) if it is a stable release
> 
>  1.0 hammer final
>  1.1 bugfix
>  1.2 bugfix
>  ...
>  2 infernalis dev
>  3 infernalis dev
>  ...
>  8 infernalis rc
>  9.0 infernalis final
>  9.1 bugfix
>  ...
>  10 j dev
>  11 j dev
>  12 j dev
>  ...
>  17.0 j final
>  17.1 j bugfix
>  ...
> 
> Q: What if the number gets big?
> A: Too late!
> 
> Q: How do I tell if it's a stable release?
> A: double instead of single item

Pros:
- Udev does this... sort of. They don't do points.

Cons:
- Impossible to express stable/unstable constraint in terms of dependencies
- Impossible to express breaking-change constraint in terms of dependencies
- Hard to map versions to names


Now, overall I'm most sympathetic to semantic, for a few reasons:
- Humans care about stable/unstable, sort of - but that's mostly about only 
wanting to update _at all_ in an explicit manner.
- Dependencies care HUGELY about breaking changes, but not at all about 
stable/unstable
- Currently, the libraries and the servers are combined in one version 
number. Because of that, failing to express breaking-change constraints can 
do things like make Qemu fail to run with an error loading shared libraries.
- For language bindings, semantic offers the largest potential for version 
sync
- Mapping between names and versions is a rare event; dependency resolution 
happens on every invocation of the package manager


