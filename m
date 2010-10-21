From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: commit ad12d5d5be41ce introduces a mkcephfs regression?
Date: Thu, 21 Oct 2010 09:38:33 -0600
Message-ID: <1287675513.6806.47.camel@sale659.sandia.gov>
References: <1287587307.6806.15.camel@sale659.sandia.gov>
 <AANLkTi=GukFwnuYg0VcprwXi7fkPKU-o4aO1Z6ZtQw_V@mail.gmail.com>
 <1287607793.6806.46.camel@sale659.sandia.gov>
 <AANLkTi=4F4ujKD1bkfZYNNhccVSUbPcjB-pbyodFBVL7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:44281 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab0JUPio (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Oct 2010 11:38:44 -0400
In-Reply-To: <AANLkTi=4F4ujKD1bkfZYNNhccVSUbPcjB-pbyodFBVL7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2010-10-20 at 16:27 -0600, Colin McCabe wrote:
> Fixed by 18b1f78b3df1a611e0c7932a2053d6b19a1ddc01.

Thanks for the quick turnaround.

-- Jim

> 
> cheers,
> Colin
> 
> 
> On Wed, Oct 20, 2010 at 1:49 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> > Hi Colin,
> >
> > On Wed, 2010-10-20 at 13:28 -0600, Colin McCabe wrote:
> >> Hi Jim,
> >>
> >> I think you're right. Commit ad12d5d5be41ce fixed a bug for users
> >> creating a journal that resided in a regular file, but introduced an
> >> inconvenience for users who put the journal on a raw block device. If
> >> no size is specified, but a raw block device is given as an argument,
> >> we should discover the size of the raw block device and set the
> >> journal size appropriately.
> >
> > Thanks for taking a look.
> >
> > -- Jim
> >
> >>
> >> cheers,
> >> Colin
> >>
> >>
> >
> >
> >
> 


