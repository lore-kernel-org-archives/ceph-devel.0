From: "Plaetinck, Dieter" <dieter@vimeo.com>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 20:32:35 +0200
Message-ID: <20120828203235.45f1e3a5@dieter-t420s>
References: <503D0A00.2080905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ny-iacmail.iac.com ([63.119.10.45]:12130 "EHLO
	ny-iacmail.iac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab2H1SeE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 14:34:04 -0400
In-Reply-To: <503D0A00.2080905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 28 Aug 2012 11:12:16 -0700
Ross Turk <ross@inktank.com> wrote:

> 
> Hi, ceph-devel! It's me, your friendly community guy.
> 
> Inktank has an engineering team dedicated to Ceph, and we want to work 
> on the right stuff. From time to time, I'd like to check in with you to 
> make sure that we are.
> 
> Over the past several months, Inktank's engineers have focused on core 
> stability, radosgw, and feature expansion for RBD. At the same time, 
> they have been regularly allocating cycles to integration work. 
> Recently, this has consisted of improvements to the way Ceph works 
> within OpenStack (even though OpenStack isn't the only technology that 
> we think Ceph should play nicely with).
> 
> What other sorts of integrations would you like to see Inktank engineers 
> work on?

are we only supposed to give answers wrt. integration with other software?
if not, I would suggest to write documentation.
and also integration with CM like puppet/chef
both of these points can give a shorter "time from zero to working cluster" which IMHO is critical
in attracting new users. (myself included)
