From: Gaudenz Steinlin <gaudenz@debian.org>
Subject: Re: Request for static uid/gid for ceph
Date: Mon, 04 May 2015 15:00:26 +0200
Message-ID: <87h9rsts45.fsf@meteor.durcheinandertal.bofh>
References: <87egnl2u87.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vechigen.cirrax.com ([217.197.128.12]:39639 "EHLO
	mail.cirrax.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbbEDQZx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 12:25:53 -0400
In-Reply-To: <87egnl2u87.fsf@meteor.durcheinandertal.bofh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: base-passwd@packages.debian.org
Cc: timm@fnal.gov, ceph-maintainers@ceph.com, ceph-devel@vger.kernel.org


Hi base-passwd maintainers

Did you receive the request below? Anything I need to do to get it
processed? Any estimate how long it will take until I get a decision?

Thanks for your work

Gaudenz

Gaudenz Steinlin <gaudenz@debian.org> writes:

> Hi
>
> Ceph is currently developing unprivileged user support, and the upstream
> developers are asking each of the distros to allocate a static numerical
> UID for the "ceph" user and group.
>
> The reason for the static number is to allow Ceph users to hot-swap hard
> drives from one OSD server to another. Currently this practice works
> because Ceph writes its files as "uid 0", but when Ceph starts writing
> its files as an unprivileged user, it will be nice to allow
> administrators to unplug a drive and plug it into another computer and
> everything to just work.
>
> For this I'm requesting an uid and gid from the reserved range
> 60000-64999 according to the process outlined in
> https://anonscm.debian.org/cgit/users/cjwatson/base-passwd.git/tree/README.
>
> Thanks,
> Gaudenz
>
> _______________________________________________
> Ceph-maintainers mailing list
> Ceph-maintainers@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com
