From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: Ceph mon crash
Date: Thu, 22 Mar 2012 16:28:55 -0300
Message-ID: <orbonoe8p4.fsf@livre.localdomain>
References: <CAHULbCnEs7o6E5mvUtMjN7NxJ3-fn8M-nriUdCqqceiBOvXKKA@mail.gmail.com>
	<CAHULbCk9RkaDUKYncp4-cYB3H9uhU8rjP+z0PW7YRD+goTORcg@mail.gmail.com>
	<CAHULbCk1Lqp7fe6+0hSZkJp57Aht57zzoF8bXLpuBa+TCfcX4w@mail.gmail.com>
	<66BEE4F342554A54BA21F31CB051E2C4@dreamhost.com>
	<CAHULbCkQ-vzDgHHZtSLNGgZFLAODphUTjFJfmK5y+SnveJqfYg@mail.gmail.com>
	<A542F36937A84D5D9450188A02E47FC7@dreamhost.com>
	<CAHULbCmyc+OtJd72JJDCKE_gH=2v+SLDMjYTpZQmtRqzYCw9vA@mail.gmail.com>
	<CAHULbCk3nktgUEWuQURc2mBs7cOOKWPir8msVcQpF4wM_TTYtA@mail.gmail.com>
	<1479058075F34FB781EA8541B5C0EA78@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:42864 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753015Ab2CVT3G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Mar 2012 15:29:06 -0400
In-Reply-To: <1479058075F34FB781EA8541B5C0EA78@dreamhost.com> (Greg Farnum's
	message of "Tue, 20 Mar 2012 09:49:25 -0700")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ruslan usifov <ruslan.usifov@gmail.com>, ceph-devel@vger.kernel.org

On Mar 20, 2012, Greg Farnum <gregory.farnum@dreamhost.com> wrote:

> Ah. I'm not sure we actually support removal of all the MDSes once you
> start one up.

I did that the other day, by mistake.  It was interesting to get an mds
back up: AFAICT, nothing will ever promote a subsequently-added mds from
standby[-replay] to replay, because no mds has failed.  Oops ;-)

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
