From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: unstable crushtool fails to open log file
Date: Thu, 6 Jan 2011 08:28:47 -0700
Message-ID: <1294327727.4984.159.camel@sale659.sandia.gov>
References: <1294252746.4984.154.camel@sale659.sandia.gov>
 <AANLkTiniHXyQ=vwnwfdNeO4P6+yWiJvZhAWm0FjOQfAB@mail.gmail.com>
 <1294253392.4984.156.camel@sale659.sandia.gov>
 <AANLkTikGFgpu5OuLPZg27_o1CeTzB5uH=Q-Txyh1D80V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:42446 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab1AFP3A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jan 2011 10:29:00 -0500
In-Reply-To: <AANLkTikGFgpu5OuLPZg27_o1CeTzB5uH=Q-Txyh1D80V@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Colin,

On Wed, 2011-01-05 at 17:30 -0700, Colin McCabe wrote:
> Hi Jim,
> 
> This should be fixed by 8adaa0478a94b5f731ee77e12a8dac29e3a7b46a
> 
> Command line (non-daemon) programs should now log to stderr, always,
> rather than trying to open logfiles or syslog.

Got it; thanks for the quick turnaround.

-- Jim

> 
> cheers,
> Colin
> 
> 
> On Wed, Jan 5, 2011 at 10:49 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > Hi Colin,
> >
> > On Wed, 2011-01-05 at 11:46 -0700, Colin McCabe wrote:
> >> Hi Jim,
> >>
> >> We should be defaulting to sending logs to stderr for command-line
> >> tools like crushtool.
> >>
> >> I'll resolve this in a bit.
> >
> > Cool, thanks.
> >
> > -- Jim
> >
> >>
> >> C.
> >>
> >>
> >> On Wed, Jan 5, 2011 at 10:39 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> >> > Hi,
> >> >
> >> > unstable branch crushtool is failing for me like this:
> >> >
> >> > # crushtool --num_osds 32 -o test.crushmap --build shelf uniform 8 host uniform 1 root straw 0
> >> > failed to open log file '/var/log/ceph/': error 21: Is a directory
> >> >
> >> > This error seems to happen at crushtool.cc:925:
> >> >
> >> > 925           dout(0) << "layer " << type
> >> > 926                   << "  " << l.name
> >> > 927                   << "  bucket type " << l.buckettype
> >> > 928                   << "  " << l.size
> >> > 929                   << dendl;
> >> >
> >> >
> >> > AFAICS commit 986c2af4aeb switched dout to use DoutStreambuf,
> >> > and by default (commit 952111451c3) everything now logs to a
> >> > file.
> >> >
> >> > What's the right way to get crushtool to log to stdout or
> >> > stderr?  Or, how to I get crushtool to use a log file
> >> > of my choice?
> >> >
> >> > Thanks -- Jim
> >> >
> >> >
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >>
> >
> >
> >
> 


