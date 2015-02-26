From: Sage Weil <sweil@redhat.com>
Subject: ceph versions
Date: Thu, 26 Feb 2015 15:12:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbbBZXM1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 18:12:27 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1QNCQUk032193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 18:12:27 -0500
Received: from redhat.com (ovpn-112-33.phx2.redhat.com [10.3.112.33])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1QNCPgT008353
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 18:12:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hammer will most likely be v0.94[.x].  We're getting awfully close to 
0.99, though, which makes many people think 1.0 or 1.00 (isntead of 
0.100), and the current versioning is getting a bit silly.  So let's talk 
about alternatives!

Here are a few of options:

-- Option A -- "doubles and triples"

X.Y[.Z]

 - Increment X at the start of each major dev cycle (hammer, infernalis)
 - Increment Y for each iteration during that cycle
 - Eventually decide it's good and start adding .Z for the stable fixes.

For example,

 1.0 first infernalis dev release
 1.1 dev release
 ...
 1.8 infernalis rc
 1.9 infernalis final
 1.9.1 stable update 
 1.9.2 stable update 
 ...
 2.0 first j (jewel?) dev release
 2.1 next dev release
 ...
 2.8 final j
 2.8.x stable j releases

Q: How do I tell if it's a stable release?
A: It is a triple instead of a double.

Q: How do I tell if this is the final release in the series?
A: Nobody knows that until we start doing stable updates; see above.


-- Option B -- "even/odd"

X.Y.Z

 - if Y is even, this is a stable series
 - if Y is odd, this is a dev release
 - increment X when something major happens

 1.0 hammer final
 1.0.1 stable/bugfix
 1.0.2 stable
 1.0.3 stable
 ...
 1.1.0 infernalis dev release
 1.1.1 infernalis dev release
 1.1.2 infernalis dev release
 ...
 1.2.0 infernalis final
 1.2.1 stable branch
 ...
 1.3.0 j-release dev
 1.3.1 j-release dev
 1.3.2 j-release dev
 ...
 1.4.0 j-release final
 1.4.1 stable
 1.4.1 stable

Q: How do I tell if it's a stable release?
A: Second item is even.


-- Option C -- "semantic"

major.minor.patch

- MAJOR version when you make incompatible API changes,
- MINOR version when you add functionality in a backwards-compatible 
manner, and
- PATCH version when you make backwards-compatible bug fixes.

 1.0.0 hammer final
 1.0.1 bugfix
 1.0.1 bugfix
 1.0.1 bugfix
 1.1 infernalis dev release
 1.2 infernalis dev release
 2.0 infernalis dev release
 2.1 infernalis dev release
 2.2 infernalis dev release
 2.3 infernalis final
 2.3.0 bugfix
 2.3.1 bugfix
 2.3.2 bugfix
 2.4 j dev release
 ...
 2.14 j final
 2.14.0 bugfix
 2.14.1 bugfix
 ...
 2.15 k dev
 ..
 3.3 k final
 3.3.1 bugfix
 ...
 
Q: How do I tell what named release series this is?
A: As with the others, you just have to know.

Q: How do we distinguish between stable-series updates and dev updates?
A: Stable series are triples.

Q: How do I know if I can downgrade?
A: The major hasn't changed.

Q: Really?
A: Well, maybe.  We haven't dealt with downgrades yet so this assumes we 
get it right (and test it).  We may not realize there is a 
backward-incompatible change right away and only discover it later during 
testing, at which point the versions are fixed; we'd probably bump the 
*next* release in response.


-- Option D -- "labeled"

X.Y-{dev,rc,release}Z

 - Increment Y on each major named release
 - Increment X if it's a major major named release (bigger change 
than usual)
 - Use dev, rc, or release prefix to clearly label what type of release 
this is
 - Increment Z for stable updates

 1.0-dev1 first infernalis dev release
 1.0-dev2 another dev release
 ...
 1.0-rc1 first rc
 1.0-rc2 next rc
 1.0-release1 final release
 1.0-release2 stable update
 1.0-release3 stable update
 1.1-dev1 first cut for j-release
 1.1-dev2 ...
 ...
 1.1-rc1
 1.1-release1 stable
 1.1-release2 stable
 1.1-release3 stable

Q: How do I tell what kind of release this is?
A: Look at the string embedded in the version

Q: Will these funny strings confuse things that sort by version?
A: I don't think so.


-- Option E -- "ubuntu"

YY.MM[.Z]

 - YY is year, MM is month of release
 - Z for stable updates

 15.03 hammer final
 15.03.1 bugfix
 15.03.2 bugfix
 ...
 15.04 infernalis dev
 15.05 infernalis dev
 ...
 15.07 infernalis final
 15.07.1 bugfix
 15.07.2 bugfix
 ...

Q: What if we have more than one dev release a month?  Like, on a 2 weeks 
schedule, as we have been.
A: We move to monthly dev releases.  Or, we put an 'a' or 'b' suffix on 
there?  Meh.

Q: How do I tell if it's a stable release?
A: It's a triple.


-- Option F -- "flat"

X[.Y]

 - increment X on every release, regardless of whether it is a named 
release or not
 - add a .Y (or .0) if it is a stable release

 1.0 hammer final
 1.1 bugfix
 1.2 bugfix
 ...
 2 infernalis dev
 3 infernalis dev
 ...
 8 infernalis rc
 9.0 infernalis final
 9.1 bugfix
 ...
 10 j dev
 11 j dev
 12 j dev
 ...
 17.0 j final
 17.1 j bugfix
 ...

Q: What if the number gets big?
A: Too late!

Q: How do I tell if it's a stable release?
A: double instead of single item
