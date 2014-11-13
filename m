From: Sage Weil <sage@newdream.net>
Subject: Re: Problem in src_cmpxattr?
Date: Thu, 13 Nov 2014 06:42:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411130636560.24889@cobra.newdream.net>
References: <5464BA37.1080801@cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40043 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbaKMOmT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 09:42:19 -0500
In-Reply-To: <5464BA37.1080801@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joaquim Rocha <joaquim.rocha@cern.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Joaquim,

On Thu, 13 Nov 2014, Joaquim Rocha wrote:
> Hi there,
> 
> I need to create an object O (if it doesn't exist) and set an xattr on it
> based on a condition that another xattr in a different object (X) should obey.
> For this, on the same write operation (called on O) I call create (not
> exclusively), setxattr and src_cmpxattr (with X as the src_oid), respectively.
> 
> What I noticed is that if object O does not exist, the src_cmpxattr returns
> -ENOENT (even if object X does exist). IMO, this error should only be returned
> if X didn't exist and not O.

This will only work if you force rados to store O and X in the same PG in 
the cluster.  This is done with the locator_set_key() method, which 
essentially let's you specify a string other than the object name to 
decide where the object goes.  So you could store O in the 'O' slot 
(default), then set the locator key to '0' and store X in the same place. 
Then the src_cmpxattr method should do what you want.

This lets you have a cluster of objects that are stored together and that 
you can clone data between using clone_range.  But you can't do this sort 
of test-and-set between arbitrary objects in the cluster because they 
will usually be stored on different OSDs...

> Is this the correct expectation for what src_cmpxattr should do (compare an
> xattr on the given source object to the parameters given)?
>
> Is this somehow expected? If so, is there any other way that I can accomplish
> what I need as mentioned above?

Yeah, the ENOENT is telling you that there is no O stored at locator key 
X.

We would love to add some simple transactional support to rados that would 
let you do this in the general case, but there's a long list of other 
important things to get done first!

sage
