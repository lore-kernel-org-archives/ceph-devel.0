From: Sage Weil <sage@inktank.com>
Subject: Re: Set object mtime
Date: Mon, 25 Mar 2013 12:38:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303251237090.12444@cobra.newdream.net>
References: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com> <5150A306.6030509@42on.com> <CAFtEh-d6r4S+1G1LLhWnzJXhKR1maQXJYrVK8nn+3UjjchoSZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50961 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758873Ab3CYTia (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 15:38:30 -0400
In-Reply-To: <CAFtEh-d6r4S+1G1LLhWnzJXhKR1maQXJYrVK8nn+3UjjchoSZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 25 Mar 2013, Damien Churchill wrote:
> On 25 March 2013 19:18, Wido den Hollander <wido@42on.com> wrote:
> > On 03/25/2013 12:27 PM, Damien Churchill wrote:
> >>
> >> Does anyone know if it's possible to set an objects mtime at all in RADOS?
> >>
> >
> > You mean with a specific operation while not modifying the content of the
> > object?
> >
> > I checked the rados API, but I couldn't find any method which allows you to
> > do so.
> 
> Neither could I. I guess the question should be changed to:
> 
> How difficult would it be to allow the modification time to be set
> (including setting it to a time in the past) without changing the
> object?

The CREATE operation just creates the object if it doesn't exist.  You can 
use that op and set the mtime to whatever you want.  You probably need to 
use the C++ bindings with the ObjectWriteOperation method; I don't think 
there is a standalone call for it (tho one is easily added).

sage
