From: Kefu Chai <kchai@redhat.com>
Subject: Re: Queries regarding projects in Gsoc 2017.
Date: Tue, 28 Mar 2017 09:08:36 -0400 (EDT)
Message-ID: <149370577.6738851.1490706516464.JavaMail.zimbra@redhat.com>
References: <CA+TGOtkX+8CHoK1qSCTwGX=HhhEzVqGz1nUjYX1058qds=rRWQ@mail.gmail.com> <58d1eea6.4392630a.53da8.08d4@mx.google.com> <2047520927.4853285.1490169993798.JavaMail.zimbra@redhat.com> <CA+TGOtkhgoy4pg4rNT2gpiNKC1FHB4YN0t7DijMQR7DuCJ1xzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753100AbdC1NJC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Mar 2017 09:09:02 -0400
In-Reply-To: <CA+TGOtkhgoy4pg4rNT2gpiNKC1FHB4YN0t7DijMQR7DuCJ1xzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Prajwal Bhandary <reachprajwalbhandary@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

+ ceph-devel

----- Original Message -----
> From: "Prajwal Bhandary" <reachprajwalbhandary@gmail.com>
> To: "Kefu Chai" <kchai@redhat.com>
> Sent: Tuesday, March 28, 2017 6:13:40 AM
> Subject: Re: Queries regarding projects in Gsoc 2017.
> 
> hey Chai!
> 
> I've dropped the idea to pursue the project on optimizing the crush
> algorithm, I'd like to continue attempting for the projects on OSD
> auto-tuning, slow OSD determination and Pool pg_num auto-tuning . I had a
> few questions if you could clarify with me,
> 
> OSD tuning of slow OSD :
> - How would i classify if the response is slow or normal ?

please see my previous reply.

> - All i need to do is determine the slow OSD's and report themis it ? Or do
> I need reassign them in some manner or something ?

yes. you could do some preliminary investigation trying to root cause the slowness.
but that would be overlapped with the idea of http://ceph.com/gsoc2017-ideas/#root-cause-analysis-tool.

> 
> Pool pg_num auto-tuning :
> - Should i be building a module to just determine the pg_num ? ( using the
> formula mentioned in the docs or come up with some optimized )

it's supposed to be a python module hosted by ceph-mgr.

> - Will i be required to include features such as returning the particular
> hash id of the object ?

it's not in the scope of this project.

> 
> last question being:
> Is there a possibility for me to apply for one of the projects and
> implement both the above projects ?


it's possible i guess. you can apply for both of them. and if you are enrolled,
and there is no student being assigned to another idea, you *can* work
on another one also like any other contributor. you will need to ask the community
on this before starting working on it. otherwise your work could be wasted.

> 
> I've done a fair amount of research on the docs and I'd love to work on
> both projects if its possible .
> 
> Hoping to hear from you soon!
> 
> Thank you,
> Prajwal.
> 
> On Wed, Mar 22, 2017 at 1:36 PM, Kefu Chai <kchai@redhat.com> wrote:
> 
> >
> >
> > ----- Original Message -----
> > > From: "Prajwal" <reachprajwalbhandary@gmail.com>
> > > To: kchai@redhat.com
> > > Sent: Wednesday, March 22, 2017 11:25:26 AM
> > > Subject: RE: Queries regarding projects in Gsoc 2017.
> > >
> > > Hello,
> > >
> > > I just wanted to check if the previous email did reach you, as im
> > interested
> > > in applying for the previously mentioned projects . So, I'd like a bit of
> > > guidance on it .
> >
> > Hi Prajwal!
> >
> > sorry for the latency, i didn't get a chance to reply your mail yesterday.
> >
> > >
> > > Thank you,
> > > Prajwal
> > >
> > > -----Original Message-----
> > > From: "Prajwal Bhandary" <reachprajwalbhandary@gmail.com>
> > > Sent: ‎21-‎03-‎2017 12:19 AM
> > > To: "kchai@redhat.com" <kchai@redhat.com>
> > > Subject: Queries regarding projects in Gsoc 2017.
> > >
> > > Hey Chai,
> > >
> > >
> > > I'm a student hailing from India, pursuing my undergraduate course in
> > CSE .
> > > I've got pretty fair knowledge in python, I've been programming with it
> > > since a year and a half . I was really interested in the following
> > projects
> > > posted on your website :
> > >
> > >
> > >  ceph-mgr : Smarter Reweight by Utilization
> > >  ceph-mgr : Slow OSD Identification, Automated Cluster Response
> >
> > ceph comes with various tools and metrics that one can use to diagnose the
> > performance of the storage cluster. for example,
> >
> > - perf counters: http://docs.ceph.com/docs/master/dev/perf_counters/
> > - the "dump_historic_ops" subcommand
> > - the "dump_ops_in_flight" subcommand
> >
> > >  ceph-mgr : Pool pg_num Autu-Tuning
> > >
> >
> > you could check out http://ceph.com/pgcalc/, with the help of ceph-mgr
> > we can integrate it in a more user friendly way.
> >
> > >
> > > I would be submitting my proposal on the mentioned projects its self,
> > but I
> > > thought getting a more deeper understanding of the problem from you would
> > > help me give in a better proposal . I feel I haven't really understood
> > the
> > > latter two projects too well, as I've found papers on the CRUSH algorithm
> > > for starters but nothing on the other two, if you could probably point
> > me in
> > > the right direction on give me more of an insight if possible .
> > >
> > >
> > > Hoping to hear from you soon.
> > >
> > >
> > > Thank you,
> > >
> > >
> > > Prajwal .
> >
>
