From: Sage Weil <sweil@redhat.com>
Subject: Re: Status of luminous v12.2.1 QE validation
Date: Tue, 26 Sep 2017 15:56:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709261555490.27895@piezo.novalocal>
References: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com> <CA+2bHPZf2akxs+WtTmzpSyA0=T8rZcKsHXqUnwPMb9Los0XQYA@mail.gmail.com> <4d92b984acbdf857f8179bd1509d31fd@suse.com> <027e6d17-fb8b-1856-bb13-c5c0e9d361da@redhat.com>
 <931ca694dacee7132a1528990ce7b651@suse.com> <b0e4b529f93a0efb25e6404568d81ee1@suse.com> <alpine.DEB.2.11.1709251728090.27895@piezo.novalocal> <CA+2bHPZs7BOdOG9Vv-hhzcpjmhOPS=ekjOOZuCVkW81kGD=7ZA@mail.gmail.com> <c9ffa337c70dd576e07f7c384bf346c1@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966056AbdIZP4P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 26 Sep 2017 11:56:15 -0400
In-Reply-To: <c9ffa337c70dd576e07f7c384bf346c1@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek <abhishek@suse.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, "Durgin, Josh" <jdurgin@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Vasu Kulkarni <vakulkar@redhat.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ilya Dryomov <idryomov@redhat.com>, ceph-devel-owner@vger.kernel.org

On Tue, 26 Sep 2017, Abhishek wrote:
> On 2017-09-25 19:33, Patrick Donnelly wrote:
> > On Mon, Sep 25, 2017 at 10:28 AM, Sage Weil <sweil@redhat.com> wrote:
> > > On Mon, 25 Sep 2017, Abhishek wrote:
> > > > On 2017-09-25 11:43, Abhishek wrote:
> > > > > On 2017-09-25 03:08, Yan, Zheng wrote:
> > > > > > On 2017/9/24 22:03, Abhishek wrote:
> > > > > > > On 2017-09-19 23:11, Patrick Donnelly wrote:
> > > > > > > > On Tue, Sep 19, 2017 at 1:10 PM, Yuri Weinstein
> > > > <yweinste@redhat.com>
> > > > > > > > wrote:
> > > > > > > > > kcephfs - needs analysis - Patrick, Zheng FYI
> > > > > > > >
> > > > > > > > http://tracker.ceph.com/issues/21463
> > > > > > > > http://tracker.ceph.com/issues/21462
> > > > > > > > http://tracker.ceph.com/issues/21466
> > > > > > > > http://tracker.ceph.com/issues/21467
> > > > > > > > http://tracker.ceph.com/issues/21468
> > > > > > > >
> > > > > > > > Last 3 look like blockers. Zheng will have more input.
> > > > > > >
> > > > > > > Here are the results of a rerun with -k testing,
> > > > > > >
> > > > http://pulpito.ceph.com/abhi-2017-09-22_19:35:04-kcephfs-luminous-testing-basic-smithi/
> > > > > > > & details http://tracker.ceph.com/issues/21296#note-20
> > > > > > > There are a few failures which look environmental but a few look
> > > > like
> > > > > > > they are related to the changeset (the ones with cache)
> > > > > > >
> > > > > > "MDS cache is too large" issue should be fixed by
> > > > > > https://github.com/ceph/ceph/pull/17922
> > > > > Ah alright this is a qa suite fix, we can run a the suite with a qa
> > > > > suite argument just to be sure.
> > > > 
> > > > alternatively we can just merge this in luminous branch and this gets
> > > > tested
> > > > in the final qe run anyway, since we may have to do that since there are
> > > > some
> > > > rados and cephfs changes?
> > > 
> > > Yes, let's do that.
> > > 
> > > I think all of the other blockers are resolved now?
> > 
> > These whitelist QA fixes would be good to merge to silence spurious
> > failures for QE:
> > 
> > https://github.com/ceph/ceph/pull/17945
> > https://github.com/ceph/ceph/pull/17821
> 
> About QE validation, my vote is to just go through cephfs & rados suites as we
> have a rados and a few (mostly qe related) cephfs prs that went in.
> 
> Sage/Yuri/Patrick thoughts?

Yuri scheduled them last night and they look good (rados was all green :).

I think we're good to go!
sage

