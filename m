From: John Axel Eriksson <john@insane.se>
Subject: Re: RGW in Bobtail
Date: Fri, 2 Nov 2012 10:08:39 +0100
Message-ID: <CAMmJxtJ3+C_i389NhnJ-mvUFrvQAr0ZPd2PnnsC7XyQLpy5a2A@mail.gmail.com>
References: <CAC-hyiG5hCVBx-_-S7ViK4FrKro+rJ+-mtKS=p0Kw_k0RvJHnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36463 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab2KBJIk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 05:08:40 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3579532vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 02:08:40 -0700 (PDT)
In-Reply-To: <CAC-hyiG5hCVBx-_-S7ViK4FrKro+rJ+-mtKS=p0Kw_k0RvJHnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 30, 2012 at 6:36 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> We've been quite busy in the last few months, and the next ceph long
> term is right around the corner so here's a list of some of the new
> features rgw is getting:
>
>  - Garbage collection
>
> This removes the requirement of running a periodic cleanup process to
> purge stale data, as rgw now handles it by itself. It also takes care
> of a possible race that was possible with the old method (if not used
> correctly) where still-in-use objects could be removed.

Sounds great - I was bitten by this once.

>
>  - New usage statistics
>
> The new usage statistics are powerful, though lightweight. They reduce
> the load on the cluster, and they provide indexed user usage
> information. It is possible to request a specific user's activity
> record within a specific timeframe. Note that the records granularity
> are now 1 hour.
>
>  - RESTful API for usage
>
> As a first go in doing a RESTful management API, we've created an API
> to access and purge the users' usage data. As part of this work, we've
> added the possibility to turn on and off specific APIs (s3, swift,
> management).
>
>  - POST object
>
> A long standing missing feature was the ability to upload an object
> through http POST, which makes it possible to create web forms that
> upload objects. It is compatible with the S3 POST object operation.

This would be really useful to us.

>
>  - Vanity host names (through DNS CNAME)
>
> With this feature, it is possible for the users to have their own
> domain appear as serving objects. A user would set a DNS CNAME record
> in their domain that would point at their bucket, and for any request
> coming in to that host name, rgw will serve the correct bucket.
>
>  - Striping for all objects
>
> In order to make sure the load is spread uniformly across the cluster,
> all objects will be striped.
>
>  - Extend APIs
>
> Swift manifest object, S3 multi objects delete, etc.
>
>  - Keystone
>
> This is not completely implemented yet, but it is likely that it will
> make it to Bobtail. We'll make it so that Swift authentication (and
> user management) will be able to go through Keystone.
>
>
> There was also a lot of internal cleanup that was done, as we prepared
> for the future. Some notable features that we have been thinking of
> and may make it for the nearer future post Bobtail:
>  - complete management API: everything that is controllable via
> radosgw-admin will also be handled through a RESTful api
>  - support for multiple "domains": a domain is the collection of users
> and their buckets (what is currently a single rgw instance)
>  - libradosgw: a library to control rgw objects and management
>  - multiple ceph clusters support
>  - object caching
>  - dedup
>  - alternative frontend (e.g., use embedded http server)

This sounds awesome - we had trouble with the fact that it was fcgi.
It works just fine for us at this point but an http
frontend would be most welcome.


>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
