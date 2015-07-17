From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: MVC in ceph-deploy.
Date: Thu, 16 Jul 2015 23:16:50 -0700
Message-ID: <CACkq2mph0_rOpUu5peAq_4AJ1aa3N0E2=-i_XxcR1eyxF4kkow@mail.gmail.com>
References: <55A4F165.4060402@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35893 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbbGQGRL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2015 02:17:11 -0400
Received: by oibn4 with SMTP id n4so65060963oib.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2015 23:17:10 -0700 (PDT)
In-Reply-To: <55A4F165.4060402@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Owen,

I'm still giving this one some thought. I've gone back and reviewed
https://github.com/ceph/ceph-deploy/pull/320 a few more times.  I do
understand how it works (it took a couple times through it), and
cosmetic things notwithstanding I can appreciate what it is doing.  I
also fully get that the choice of sqlalchemy vs <choice of data store>
makes no difference to the merit of the idea.  I'm still formulating
my opinion, however, but wanted to let you know I was thinking about
it.

 - Travis

On Tue, Jul 14, 2015 at 4:24 AM, Owen Synge <osynge@suse.com> wrote:
> Dear all,
>
> ceph-deploy is to quote
>
> <quote>
> It is not a generic deployment system, it is only for Ceph, and is
> designed for users who want to quickly get Ceph running with sensible
> initial settings without the overhead of installing Chef, Puppet or Juju.
>
> It does not handle client configuration beyond pushing the Ceph config
> file and users who want fine-control over security settings, partitions
> or directory locations should use a tool such as Chef or Puppet.
> </quote>
>
> What we have currently in ceph-deploy is mixing cluster state discovery,
> cluster state modification, in many functions with no attempt to reuse
> state discovery code. I see no consistent design pattern, but can see
> code that is production grade. Being production grade code I oppose
> major code changes that might break functionality happening all at once.
>
> I propose with some small changes for finding out what is to be done,
> storing it in one place, finding out what state the cluster is and
> storing it in one place. Then comparing these two stored states, then
> making changes as needed to the clusters state as just general good
> practice. This is can be called MVC in design pattern terminology if all
> the state gathering code is separated from all the state changing code,
> these would then be View parts to MVC. The controller would be the
> component that directs the interaction between the model and the views
> which also should be separate.
>
> From experience I have found that MVC has 5 major benefits compared to
> the way ALL of the code base is in ceph-deploy for a project like
> ceph-deploy when I have made similar incremental changes toward this
> design pattern in the past on the YAIM project for deploying dcache.
> (which was more complex than ceph deployment and I had to write it in BASH)
>
> (1) Cluster state discovery code only has to be developed tested and
> used once as it is placed in model.
>
> (2) the MVC model can be nested, so potentially removing the need to
> iterate across nodes, in more than one place in the code base.
>
> (3) Making the code MVC will allow the model and the view that is
> involved in state gathering code to be reused the functionality and
> validation of ceph-deploy in general will improve siginifcantly.
>
> (4) The command line to desired model state, "view" code can be shared
> by all ceph-deploy components.
>
> (5) By discovering the state of the cluster before changing any cluster
> state, things such as needing a change of ceph.conf, which requires a
> flag argument to allow this, can be detected at the start of an
> operation so the user can get a clear and early error, rather than
> failing at a later stage for configuration. Making cluster configuration
> closer to atomic, and following the good practice of failing fast.
>
> For me this clearly sates why MVC is a good standard approach to cluster
> management that will reduce code duplication in many areas of the code
> base and simple way to keep the code base extensible.
>
> Considering we do not have this model, some may consider moving to this
> model a major re-factor. I think this is invalid because I think its
> reasonable to see it from this perspective:
>
> (A) we can start on an area of the code base that is under new
> development. eg rgw support in ceph-deploy.
>
> (B) I can see removing code duplication as a incremental process that
> will each have its own change.
>
> (C) I do not see the need to move all code to an MVC model at the same time.
>
> (D) I do not see splitting your code into discovery , storing state and
> applying changes to significantly increase the work for any one change.
>
> Now my points are made I have a couple of final misunderstandings to
> clear up in any discussion of MVC:
>
> (I) I would be happy for the model to be based upon python objects.
>
> (II) While I like the idea of using sqlalcamy and sqllite as a nice way
> to get a type safe model with firm constraints, I do not see this as the
> only way we can make a model for MVC. I demonstrated in a code sample
> with a draft of a complete relational model to ceph cluster deployment
> using sqllite in memory, that made use of the flexibility of setuptools
> the deployment issues people raised with this approach where not
> present. This said it is essential to understand I do not see this as
> more than a potential implementation, or in any way other than as a
> potential implementation, of a model for the use by the MVC design patten.
>
> So to summarise:
>
> I think we should go toward an MVC pattern in ceph-deploy for new
> development (such as rgw), in preference to code consistency across
> ceph-deploy.
>
> I think we should re-factor existing code to use a shared model in an
> MVC pattern only after the model has matured with new development work
> based upon it.
>
> I think even if ceph-deploy never gets any new functionality, beyond
> what is currently planned, moving to MVC will reduce the support burden
> in the long/medium term and potentially in the short term.
>
> Should further features ever be commissioned from ceph-deploy I think
> any work already done towards building an MVC pattern will be reused and
> result in less work.
>
> Best regards
>
> Owen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
