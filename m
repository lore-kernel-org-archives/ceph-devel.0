From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RGW, future directions
Date: Thu, 24 May 2012 07:15:47 +0200
Message-ID: <4FBDC403.9090106@widodh.nl>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:42312 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab2EXFPw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 01:15:52 -0400
In-Reply-To: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org



On 22-05-12 20:07, Yehuda Sadeh wrote:
> RGW is maturing. Beside looking at performance, which highly ties into
> RADOS performance, we'd like to hear whether there are certain pain
> points or future directions that you (you as in the ceph community)
> would like to see us taking.
>
> There are a few directions that we were thinking about:
>
> 1. Extend Object Storage API
>
> Swift and S3 has some features that we don't currently support. We can
> certainly extend our functionality, however, is there any demand for
> more features? E.g., self destructing objects, web site, user logs,
> etc.
>
> 2. Better OpenStack interoperability
>
> Keystone support? Other?
>
> 3. New features
>
> Some examples:
>
>   - multitenancy: api for domains and user management
>   - snapshots
>   - computation front end: upload object, then do some data
> transformation/calculation.
>   - simple key-value api
>
> 4. CDMI
>
> Sage brought up the CDMI support question to ceph-devel, and I don't
> remember him getting any response. Is there any intereset in CDMI?
>
>
> 5. Native apache/nginx module or embedded web server
>
> We still need to prove that the web server is a bottleneck, or poses
> scaling issues. Writing a correct native nginx module will require
> turning rgw process model into event driven, which is not going to be
> easy.
>

I'd not go for a native nginx or Apache module, that would bring extra C 
code into the story which would mean extra dependencies.

My vote would still go to a embedded webserver written in something like 
Python. You could then use Apache/nginx/Varnish as a reverse proxy in 
front and do all kinds of cool stuff.

You could even doing caching in nginx or Varnish and let the RGW notify 
those proxy's when an object has changed so they can purge their cache. 
This would dramatically improve the performance of the gateway.

It would also simplify the code, why try to do caching on your own when 
some great HTTP caches are out there?

> 6. Improve garbage collection
>
> Currently rgw generates intent logs for garabage removal that require
> running an external tool later, which is an administrative pain. We
> can implement other solutions (OSD side garbage collection,
> integrating cleanup process into the gateway, etc.) but we need to
> understand the priority.
>
> 7. libradosgw
>
> We have had this in mind for some time now. Creating a programming api
> for rgw, not too different from librados and librbd. It'll hopefully
> make code much cleaner. It will allow users to write different front
> ends for the rgw backend, and it will make it easier for users to
> write applications that interact with the backend, e.g., do processing
> on objects that users uploaded, FUSE for rgw without S3 as an
> intermediate, etc.
>

Yes, I would really like this. Combine this with the Python 
stand-alone/embedded webserver I proposed and you get a really nice RGW 
I think.

> 8. Administration tools improvement
>
> We can always do better there.
>

When we have libradosgw it wouldn't be that hard to make a nice web 
front-end where you can manage the whole thing.

> 9. Other ideas?
>
>
> Any comments are welcome!
>
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
