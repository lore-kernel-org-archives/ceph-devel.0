From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: librados AIO problem diagnostic
Date: Wed, 1 Oct 2014 10:50:00 +0200
Message-ID: <1412153400.6822.14.camel@sebmain.cern.ch>
References: <542BA6D4.4070207@dachary.org>
	 <1412148537.6822.11.camel@sebmain.cern.ch> <542BBC5D.8080304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:35164 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbaJAIuv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Oct 2014 04:50:51 -0400
In-Reply-To: <542BBC5D.8080304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I've tried on 3 machines up to now, with different kernels :
  - a RHEL6 (or close to it) with kernel 2.6.32-358.2.1.el6.x86_64
  - a debian unstable box with kernel 3.12-1-amd64 #1 SMP Debian 3.12.6-2
  - an ubuntu one, as you suggested, don't remember the kernel (and box is gone)

Sebastien


On Wed, 2014-10-01 at 10:33 +0200, Loic Dachary wrote:
> Which kernel are you running accord to uname -a ? I have:
> 
> Linux 0a2ad46b4fb5 3.13.0-23-generic #45-Ubuntu SMP Fri Apr 4 06:58:38 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
> 
> On 01/10/2014 09:28, Sebastien Ponce wrote:
> > Thanks for this effort !
> > I'll look at all that this afternoon (it's mid morning here).
> > Concerning configure and autogen, I do the standard (naive ?)
> > "./autogen.sh; ./configure; make" given by the readme.
> > 
> > Sebastien
> > 
> > 
> > On Wed, 2014-10-01 at 09:01 +0200, Loic Dachary wrote:
> >> Hi Sebastien,
> >>
> >> In the context of http://tracker.ceph.com/issues/9356 I'm trying to collect as much information as I can in an environment that can be reconstructed to avoid interferences. Could you please let me know which ./configure line you are using ? Or which do_autogen.sh command you are using.
> >>
> >> Thanks in advance :-)
> >>
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 


