From: Kefu Chai <kchai@redhat.com>
Subject: Re: Apply for GSOC
Date: Mon, 27 Mar 2017 02:44:50 -0400 (EDT)
Message-ID: <2055767632.6232788.1490597090878.JavaMail.zimbra@redhat.com>
References: <CAHfGNnv9Z0UFTs2QLH5CDhUe7yJOM5PphdZHi7U5VB147uo6Mg@mail.gmail.com> <CAHfGNnsG4V4pZQv6wgWrLEVAvAk2_kDg+fZzWeK3p4=d1U4t-g@mail.gmail.com> <357468547.4233015.1490001752978.JavaMail.zimbra@redhat.com> <CAHfGNntLP-W7UDzkwJT_YGwFeKX+ZSm67_QhX4ZCec0GSVZTtQ@mail.gmail.com> <CAHfGNnvFRd46=t42cTw9p4EguqU3rr_B3=FpBz=rnkMhaoK-dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbdC0Go5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Mar 2017 02:44:57 -0400
In-Reply-To: <CAHfGNnvFRd46=t42cTw9p4EguqU3rr_B3=FpBz=rnkMhaoK-dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?5Y+y6buY6Ie7?= <shimozhen@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

+ ceph-devel

----- Original Message -----
> From: "史默臻" <shimozhen@gmail.com>
> To: "Kefu Chai" <kchai@redhat.com>
> Sent: Monday, March 27, 2017 2:19:54 PM
> Subject: Re: Apply for GSOC
> 
> Dear Kefu Chai,
> In order to learn more about this project, I have done some investigate
> about ceph and the CRUSH algorithm, including some blogs and the source
> code.
> Now I have some questions about it:
> 
>    1. First I wonder why "once any of the storage device assigned to a
>    storage pool is full, the whole pool is not writeable anymore, even there
>    is abundant space in other devices.", Is it a limitation of the CRUSH
>    algorithm?


let me put this way, if the replica number of a pool#0 is 3, and the crush rule
of that pool selects OSD.2, OSD.1 and OSD.0 for the PG 0.3. if OSD.1 is full, 
any write request targeting objects belong to PG 0.3 will be blocked. does this 
make sense to you?

>    2. What is the relationship between the bucket, item, and the physical
>    hardware? As far as my understand, we regard every rack, host, and disk as
>    a bucket, and use our algorithm to balance the storage on it. Is that
>    correct or is there some additional remarks?

in the source code, any none-leaf node in CRUSH is a bucket. but, in the context
of CRUSH, bucket is a node in the tree hierarchy. see http://docs.ceph.com/docs/master/rados/operations/crush-map/#crush-maps.

>    3. If I'm going to make a tool to evaluate the performance of the
>    algorithm, can I simply regard the hardware storage as structure of rack,
>    host, and disk like the following picture? Could I get some knowledge of
>    the true industrial storage environment?
> 
> [image: 内嵌图片 1]

/// the attached pic is a hierarchical representation of a CRUSH tree.

yes. i think so.

> I'm afraid that these questions might bother you but I really want to write
> a better proposal and get a good knowledge about the project. Thank you
> very much!
> 
> Mozhen Shi
> 
> 2017-03-20 17:47 GMT+08:00 史默臻 <shimozhen@gmail.com>:
> 
> > Dear Kefu,
> > I'm so happy to get your reply and I have got your point. I'm going to
> > prepare for the document and try to make a proposal.
> > Thank you!
> >
> > 2017-03-20 17:22 GMT+08:00 Kefu Chai <kchai@redhat.com>:
> >
> >>
> >>
> >> ----- Original Message -----
> >> > From: "史默臻" <shimozhen@gmail.com>
> >> > To: kchai@redhat.com
> >> > Sent: Monday, March 20, 2017 11:43:39 AM
> >> > Subject: Re: Apply for GSOC
> >> >
> >> > Did you recieve my email? I'm afraid that my mailbox doesn't work. It's
> >> > near March 21, the day I could start to submit the proposal. I'm so
> >> sorry
> >> > to disturb you but I hope to hear from you soon.
> >> > Thank you very much!
> >>
> >> Hi Shino,
> >>
> >> yes, but it's my mailbox for work. and in general, i don't read mails in
> >> it on week-end. FWIW, the application deadline is April 3. see
> >> https://developers.google.com/open-source/gsoc/timeline.
> >>
> >> >
> >> > 2017-03-18 19:41 GMT+08:00 史默臻 <shimozhen@gmail.com>:
> >> >
> >> > > Dear Kefu Chai,
> >> > >
> >> > > Hello, I’m Shi Mozhen, a graduate student from Peking University,
> >> school
> >> > > of computer science. I knew the GSOC by friends who had joined this
> >> project
> >> > > last year and I have great interest on it.
> >> > >
> >> > > About the project ‘CEPH-MGR: SMARTER REWEIGHT-BY-UTILIZATION’. I think
> >> > > this project combines code and math knowledge and it perfectly fits a
> >> CS
> >> > > student like me J. I think such a project is moderate difficult for me
> >> > > and I have enough confidence for it.
> >> > >
> >> > > Moreover, I have learned some knowledge on my courses and I think it’s
> >> > > amazing to meet a problem in Real industrial environment and solve it.
> >> > > Finally, about myself, I did lots of python code on big data in my
> >> research
> >> > > team before, and I got pretty good marks on my math courses.
> >> > >
> >> > > I know this email is too late and I am sorry for that. But in short, I
> >> > > would like to know if I can apply for this project successfully.
> >>
> >> please see https://developers.google.com/open-source/gsoc/faq#what_are_
> >> the_eligibility_requirements_for_participation for more info if you can
> >> apply. and if you can submit all the required document in addition to the
> >> proposal, i guess we can consider it a successful application. but to get
> >> enrolled is another story.
> >>
> >> > >
> >> > > Hope to hear from you soon, if successful, I'll start writing the
> >> proposal
> >> > > right away.
> >> > >
> >> > >
> >> > > Best wishes,
> >> > >
> >> > > Shi Mozhen
> >> > >
> >> >
> >>
> >
> >
>
