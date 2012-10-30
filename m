From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RGW in Bobtail
Date: Tue, 30 Oct 2012 18:54:16 +0100
Message-ID: <50901448.6070508@widodh.nl>
References: <CAC-hyiG5hCVBx-_-S7ViK4FrKro+rJ+-mtKS=p0Kw_k0RvJHnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:44172 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab2J3RyS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 13:54:18 -0400
In-Reply-To: <CAC-hyiG5hCVBx-_-S7ViK4FrKro+rJ+-mtKS=p0Kw_k0RvJHnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 30-10-12 18:36, Yehuda Sadeh wrote:
> We've been quite busy in the last few months, and the next ceph long
> term is right around the corner so here's a list of some of the new
> features rgw is getting:
>
>   - Garbage collection
>
> This removes the requirement of running a periodic cleanup process to
> purge stale data, as rgw now handles it by itself. It also takes care
> of a possible race that was possible with the old method (if not used
> correctly) where still-in-use objects could be removed.
>
>   - New usage statistics
>
> The new usage statistics are powerful, though lightweight. They reduce
> the load on the cluster, and they provide indexed user usage
> information. It is possible to request a specific user's activity
> record within a specific timeframe. Note that the records granularity
> are now 1 hour.
>
>   - RESTful API for usage
>
> As a first go in doing a RESTful management API, we've created an API
> to access and purge the users' usage data. As part of this work, we've
> added the possibility to turn on and off specific APIs (s3, swift,
> management).
>
>   - POST object
>
> A long standing missing feature was the ability to upload an object
> through http POST, which makes it possible to create web forms that
> upload objects. It is compatible with the S3 POST object operation.
>
>   - Vanity host names (through DNS CNAME)
>
> With this feature, it is possible for the users to have their own
> domain appear as serving objects. A user would set a DNS CNAME record
> in their domain that would point at their bucket, and for any request
> coming in to that host name, rgw will serve the correct bucket.
>
>   - Striping for all objects
>
> In order to make sure the load is spread uniformly across the cluster,
> all objects will be striped.
>

Will this be part of libradosgw? Or a separate library. There are more 
use-cases then the RGW for striping over RADOS objects.

It would be very handy if this striping would come in it's own library.

>   - Extend APIs
>
> Swift manifest object, S3 multi objects delete, etc.
>
>   - Keystone
>
> This is not completely implemented yet, but it is likely that it will
> make it to Bobtail. We'll make it so that Swift authentication (and
> user management) will be able to go through Keystone.
>
>
> There was also a lot of internal cleanup that was done, as we prepared
> for the future. Some notable features that we have been thinking of
> and may make it for the nearer future post Bobtail:
>   - complete management API: everything that is controllable via
> radosgw-admin will also be handled through a RESTful api
>   - support for multiple "domains": a domain is the collection of users
> and their buckets (what is currently a single rgw instance)
>   - libradosgw: a library to control rgw objects and management
>   - multiple ceph clusters support
>   - object caching

Do you want to go down that way? It's all HTTP, why re-invented the 
Wheel? We have a couple of beautiful reverse proxy HTTP servers which 
you will probably never outperform.

Think about Varnish or nginx.

What I should do is implement some notification framework where you can 
notify a cache in front that a POST request came in and that a specific 
object needs to be purged.

Varnish for example has a CLI over which you can purge objects from it's 
cache.

Wordpress for example uses this. With a special plugin Varnish can cache 
everything for infinity until the Wordpress plugin tells Varnish to 
purge a specific page/object.

RGW will never outperform a HTTP proxy due to all the latency it has to 
go through fetching the object from the Ceph cluster.

With Varnish as a cache in front of it you can easily reach 20k req/sec 
on a single object without ever contacting the Ceph cluster.

>   - dedup
>   - alternative frontend (e.g., use embedded http server)

Makes sense, the FCGI interface is posing problems like the buffering we 
see by lighttpd for example.

Wido

>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
