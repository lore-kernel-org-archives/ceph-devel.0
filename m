From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: commit ad12d5d5be41ce introduces a mkcephfs regression?
Date: Wed, 20 Oct 2010 14:49:53 -0600
Message-ID: <1287607793.6806.46.camel@sale659.sandia.gov>
References: <1287587307.6806.15.camel@sale659.sandia.gov>
 <AANLkTi=GukFwnuYg0VcprwXi7fkPKU-o4aO1Z6ZtQw_V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:51359 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab0JTUuH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 16:50:07 -0400
In-Reply-To: <AANLkTi=GukFwnuYg0VcprwXi7fkPKU-o4aO1Z6ZtQw_V@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Colin,

On Wed, 2010-10-20 at 13:28 -0600, Colin McCabe wrote:
> Hi Jim,
> 
> I think you're right. Commit ad12d5d5be41ce fixed a bug for users
> creating a journal that resided in a regular file, but introduced an
> inconvenience for users who put the journal on a raw block device. If
> no size is specified, but a raw block device is given as an argument,
> we should discover the size of the raw block device and set the
> journal size appropriately.

Thanks for taking a look.

-- Jim

> 
> cheers,
> Colin
> 
> 


