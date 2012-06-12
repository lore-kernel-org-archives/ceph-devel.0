From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Release names survey
Date: Tue, 12 Jun 2012 16:50:31 -0700
Message-ID: <CAC-hyiGEXaN2a4kKi0fvrT=oJLbYJxt0JyDu1uosNWEN+90Ncw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2FLXuc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 19:50:32 -0400
Received: by bkcji2 with SMTP id ji2so4990271bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 16:50:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When will there be 1.0?

Those of you who have been following Ceph, have probably noticed that
the Ceph version is going up in quite a rapid pace. This is due to the
fact that we try to follow Scrum, which is an agile methodology in
which we move in relatively small development cycles and deliver a new
version at the end of these cycles. This on one hand allows us to
present progress and to adapt while we are moving, but on the other
hand it makes it harder for some of our users. Not all users
necessarily want to run the bleeding edge.
We do provide a more stable branch, but that's usually the previous
release with critical fixes on top of it.
At this point we think that considering the project state, we should
provide a stable release. This is not going to be version 1.0. It will
be version A. Once version A is tagged, it'll get the full stable
release treatment, and there will be a relatively long period where
we'd backport bug fixes, and other required changes. The following
version would be version B, and so on. The current thought is that
we're going to have 2-4 releases a year, which will provide a much
more stable base than the current 15-20 annual releases.

One issue that we haven't cleared up yet, is how to name these
releases. Following the footsteps of other projects that use lettered
release names, we'd want to have some common theme. We did try, but
we'd need your help to make the final decision. Following are the
options (in no particular order). Also note that these are just
possible names examples, but there may be other names.

We have set up a survey here, so please make your selection:

http://bit.ly/LROUnL


* Oceanic Trenches

aleutian
bougainville
cayman
hikurangi
izu
japan
kermadec
mariana
newhebrides
philippine
ryukyu
sandwich
tonga
yap

* Pirates

ahoy / aaarrr
booty
cutlass
doubloon
eyepatch
furner
guybrush
...

* Cephalopods/Marine Animals

argonaut
banana / bobtail
cuttlefish
dofleini
e?
flamboyant
...
kraken
...
vampire / vlugaris


* Ocean currents

angola
benguela
canary
equatorial
falkland
gulfstream
humboldt
irrminger
kuroshio
labrador
mozambique

* Oceans / Seas

adriatic
baltic
celtic / caribbean
davis / deadsea
...


Thanks,
Yehuda
