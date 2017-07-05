From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: Optimization Analysis Tool
Date: Wed, 5 Jul 2017 22:46:19 +0530
Message-ID: <CAAXqJ+pDo3G2X9_3Z=+ApafR4nJyCvN_fCNRXobZYzQHqNzjrQ@mail.gmail.com>
References: <CAAXqJ+qsutkbJZTCRbvR=yuNjVX5n_Vk9V=XEBUa8dmKefhEzA@mail.gmail.com>
 <CAJE9aOOy2yvD=kHKbsvyOEsVdZfO7whPtkpqkpYtSPGdySW49Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34149 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbdGERQ0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jul 2017 13:16:26 -0400
Received: by mail-wr0-f173.google.com with SMTP id 77so266545793wrb.1
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jul 2017 10:16:25 -0700 (PDT)
In-Reply-To: <CAJE9aOOy2yvD=kHKbsvyOEsVdZfO7whPtkpqkpYtSPGdySW49Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On Tue, Jul 4, 2017 at 5:44 PM, kefu chai <tchaikov@gmail.com> wrote:
>
> On Tue, Jul 4, 2017 at 1:20 AM, Spandan Kumar Sahu
> <spandankumarsahu@gmail.com> wrote:
> > Hi everyone.
> >
> > As a part of GSoC, I will be implementing a tool, to analyse the need
> > of reweighting devices in the crushmap, and assign a score to the
> > reweight-by-utilisation algorithm. Please correct me where I am wrong,
> > and any other suggestions are more than welcome.
> >
> > The tool shall be a python module, in /src/pybind/mgr and it will use
> > Ceph's current python mgr module to get "pg_summary".
> >
> > The parameters that I plan to use are:
> > * The devices utilisation
> >   The number of over-filled devices along with the the amount of
> > over-filled%, will generate a score, using t-distribution. The reason,
> > I shall consider only over-filled devices is because one 10%
> > underfilled with 5 2% overfilled devices, is arguably a better
> > situation than one 10% overfilled with 5 2% underfilled devices. The
> > data for expected distribution after optimization can be obtained from
> > python-crush module.
>
> i assume the utilization is the ending status of the reweight.
>
We will have to take the utilisation of both before and after
reweight, if we are to assign a score.
> >
> > * Expected amount of data flow over the network
> >   A score for it can be predicted, using the number of PGs that will
> > be swapped during optimization, which can be found in python-crush[1].
> > However, the number of PGs, might not give a better idea about the
> > amount of data flow, over the network. Hence, using python mgr-module,
> > and obtaining pgmap before and after each optimization step, will give
> > the amount of data flow in the network.
> >
> > * Time for optimization process
> >  This will simply keep a note of the time taken to produce an
> > optimized crushmap from the existing one.
>
> please note, in practice, administrator might want to reweight the cluster in a
> iterative manner, say, change the weight with a smaller step size and multiple
> steps, instead of setting the new weights in a single shot, to
> minimize the impact
> to the production.
>
Yes, there is an option in python-crush, that does so. We can specify
how many PGs would be swapped in each step and then, the administrator
can decide upto how much steps would he would want the process to go
on.
But I doubt, how will we keep track of the time, when the actual
reweight happens, and what information might it give. The time for
calculating a reweighted crushmap, should be the thing we should try
and keep a track of.

> >
> > I would be using data from python-crush[2] and from pg_map (in json
> > format) obtained by sending commands to python mgr module, to gather
> > the values for the required parameters. A weighted combination of this
> > shall determine the score for the optimization algorithm in place.
> >
> > My initial target is to output the results into a file. I would try to
> > merge it with the dashboard plugin in mgr module, after the
> > implementing the tool at first.
> >
> > [1]: http://libcrush.org/main/python-crush/blob/master/tests/test_optimize.py#L460
> > [2]:http://libcrush.org/main/python-crush/blob/master/
> >
> > --
> > Spandan Kumar Sahu
> > IIT Kharagpur
>
>
>
> --
> Regards
> Kefu Chai




-- 
Spandan Kumar Sahu
IIT Kharagpur
