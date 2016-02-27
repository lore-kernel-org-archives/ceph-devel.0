From: Marcus Watts <mwatts@redhat.com>
Subject: Re: ceph + -lssl
Date: Sat, 27 Feb 2016 02:50:01 -0500
Message-ID: <20160227075001.GA21701@degu.b.linuxbox.com>
References: <20160224050912.GA6585@degu.b.linuxbox.com>
 <CADRKj5Shu=S4aHX+bz-yw8zuXgGPWE2YE_au5x1HYExwer6HTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58656 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbcB0HuF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 27 Feb 2016 02:50:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id C060F486A5
	for <ceph-devel@vger.kernel.org>; Sat, 27 Feb 2016 07:50:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CADRKj5Shu=S4aHX+bz-yw8zuXgGPWE2YE_au5x1HYExwer6HTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 26, 2016 at 12:43:24PM -0800, Yehuda Sadeh-Weinraub wrote:
> I rebased these 4 commits on top of a recent master, and here's the
> new pull request:
> 
> https://github.com/ceph/ceph/pull/7825
> 
> On Tue, Feb 23, 2016 at 9:09 PM, Marcus Watts <mwatts@redhat.com> wrote:
> > I've been working on better integrating ssl int ceph.
...

Thanks Yehuda for doing this.

Matt pointed out in the pull request that cmake builds were failing
on this branch.  I've pushed a commit to fix that.

					-Marcus Watts
