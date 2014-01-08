From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Client Incarnation & librados documentation
Date: Wed, 8 Jan 2014 15:33:32 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6AF45F@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE6AF398@PLOXCHG03.cern.ch>,<alpine.DEB.2.00.1401080651160.10011@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:25287 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbaAHPdf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2014 10:33:35 -0500
In-Reply-To: <alpine.DEB.2.00.1401080651160.10011@cobra.newdream.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks,

I have few more questions to the CLS plug-ins .... as far as I understand the client specifies the plug-in class to be called, right?

Is there a way to disable the default implementation of object read/write/delete... or can one overwrite the default implementation and call the native functions from the plugin?

To be concrete I need to derive the default implementation of most RADOS methods and want to add an authorization layer on top ... also for the delete operation. Would that be possible with the current code?

I try to make a small test program for the seteuid TIME_WAIT problem ...

Cheers Andreas.
________________________________________
From: Sage Weil [sage@inktank.com]
Sent: 08 January 2014 15:56
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: Client Incarnation & librados documentation

On Wed, 8 Jan 2014, Andreas Joachim Peters wrote:
> Hi,
>
> I have a question concerning the variable used by
> "objecter->set_client_incarnation().."
>
> What I have seen is that currently it is always set to 0.
>
> Would it be possible to add this as a variable to an IoCtx and do
> "objecter->set_client_incarnation()" according to the context before
> each objecter->XXX call. I have seen that every call to the objecter is
> already locked with the client mutex, so that should be safe ?!?!?

That would be possible, yeah...

> What was the original purpose of this variable?

It was added ages ago because I needed to distinguish between an mds0 that
has failed the next instance of the mds0 daemon after a restart.  By
incrementing that field, the old entity_name_t != the new one.  That is
the only purpose... we never actually look at the field anywhere except
for when printing it as a string.

Honesting, I think the 'right' thing to do would be to remove it entirely
(it is confusing!) and make the MDS entity_name_t use the gid (global id)
that it got when it authenticated.  That would make it unique.  The only
downside is that it no longer looks like 'mds0.123' and so it isn't
obvious when reading the logs which rank the request came from.

> I want to use it to identify more fine grained clients using a shared
> librados instance and use it to authorize on server side object
> operations using an OSD plugin ...

That is a bit unusual, but might be a worthwhile reason to keep the field
around.

> Is there any better (larger than int32)  existing available 'blob' to
> move something with each message from librados to an OSD plugin?

You mean to a rados class?  Any rados request can get an arbitrary
bufferlist passed in with whatever you want (the "argument(s)")...

> One small point concerning the librados documention ... we noticed when
> one uses seteuid(uid) together with librados all OSD connections get
> recreated after each seteuid call and one accumulates TIME_WAIT sockets
> ... maybe you can document this 'feature' ...

That sounds totally bizarre and is news to me.  Maybe you can provide a
simple reproducer program that demonstrates the problem?

Thanks!
sage


>
> Thanks, Andreas.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>