From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW S3 Website hosting, non-clean code for early review
Date: Tue, 23 Jun 2015 16:30:19 -0400 (EDT)
Message-ID: <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com>
References: <20150623093325.GH10754@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47550 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbbFWUa0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 16:30:26 -0400
In-Reply-To: <20150623093325.GH10754@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel@vger.kernel.org, Jonathan LaCour <jonathan.lacour@dreamhost.com>



----- Original Message -----
> From: "Robin H. Johnson" <robbat2@gentoo.org>
> To: ceph-devel@vger.kernel.org
> Cc: "Jonathan LaCour" <jonathan.lacour@dreamhost.com>
> Sent: Tuesday, June 23, 2015 2:33:25 AM
> Subject: RGW S3 Website hosting, non-clean code for early review
> 
> Hi,
> 
> As an extension of earlier work done by Yehuda [1], I've gotten the
> great majority of the work done to support static website hosting in
> RGW, just like AmazonS3 [2].
> 
> I need to do some cleanups of the code prior to major review for
> submission, and solve one thorny problem first, have a few discussions
> about best courses of action, and then I'll be submitting this for more
> reviews before merging.
> 
> ceph [3]
> s3-tests, unit tests [4]
> s3-tests, fuzzer tests [5]
> 
> The thorny problem:
> -------------------
> One of the pieces of functionality in S3Website is the ability to serve
> any public object in the bucket as the content on a custom error page
> (think shiny 404 error). In some cases, like trivial 403/404 errors, we
> can determine this quite early, before we fetch the object, and redirect
> the request to the error object instead (provided that we also redo the
> ACL check on the error object).
> 
> In more complex cases (eg 416 Range Unsatisfiable, 412 Precondition
> Failed), it happens very late in the RGW request processing, and the
> req_state struct seems to have been mangled/pre-filled with a lot of
> decisions that aren't solvable.
> 
> Either I have to repeat a lot of code for it, which I'm not happy about,
> or I have to refactor RGWGetObj* to more safely made the second GET
> request for the error object (and make sure range headers etc are NOT
> used for the get of the error object). I'm leaning to the latter.

Is generating a new req_state a possibility? E.g., you catch the error at the top level, and restart most of the request processing with a newly created req_state?

> 
> Oh, and for added fun, if an error object is configured, but is missing
> or private, you get a similar but different than without any error
> object configured, and sometimes the error codes are in the headers, but
> not always.
> 
> Discussion pieces:
> ------------------
> RGWRegion
> - presently has both "endpoints" and "hostnames", but doesn't make clear
>   which APIs (S3, Swift, S3Website) might be available at each; or allow
>   combinations to dedicate a specific FQDN to a given API.
>   I'd like to replace both structures with a map structure [6]

Makes sense.

> Bucket existence privacy:
> - In general I agree with the goal that we should be closely compatible
>   with AmazonS3, but with an eye to security, I'd like to consider a specific
>   deviation:
> - In AmazonS3, you can enumerate buckets for existence, simply looking
>   for 404 NoSuchBucket vs 403 AccessDenied. I'd like to offer a
>   configuration option that returns 403 Forbidden or 401 Unauthorized on
>   anonymous requests to non-existent buckets.

As long as it's configurable.

> - Testing some of functionality against AmazonS3 has been somewhat
>   painful, as AmazonS3 only provides eventual consistency of the website
>   configuration (with the highest time I've seen so far being about 30
>   seconds).

Yup.

> 
> New configuration options/changes:
> ----------------------------------
> rgw_enable_apis: gains 's3website' mode
> rgw_dns_s3website_name: similar to rgw_dns_name, but for s3website endpoint
> RGWRegion having per-rgw-api hostnames
> 
> Patch series breakdown plans:
> -----------------------------
> Here's the breakdown of patch series I'm considering for the changes
> (net 2kLOC in ceph, 1kLOC in testcases).
> [TODO marks pieces not in these sets of commits yet, but will be soon).
> 
> ceph
> - split Formatter.cc
>   - JSON/XML/Table formatter are separator now
>   - add header & footer support for formatters
>   - add knowledge of status
>   - add HTML formatter
> - Add optional error handler hooks to RGWOp and RGWHandler for abort_early
> - Add optional retarget handler hooks
> - Add more flexible redirect handling
> - S3website code
> - x-amz-website-redirect-location handling (TODO: needs a bit more polish and
> testing)
> - TODO: Add more input validations to match S3, on stuff that's NOT
>   documented but was discovered when I applied weirder testcases to
>   AmazonS3:
>   - 'Hostname' field has non-trivial validation (maybe borrow the
>     outcome of wip-bucket_name_restrictions)
>   - The 'Protocol' field for a redirect must be http/https, cannot be
>     gopher or anything else.
>   - The HttpRedirectCode field must contain one of: 301-305, 307, 308
>     The docs don't say this, and the error message says 'Any 3XX value
>     except 300'.
>   - First-match in RoutingRules wins; watch out with rules that match
>     4XX error codes.
> - Documentation
>   - TODO: esp the parts missing from the S3 docs above
> 
> s3-tests, unit tests
> - refactor for more requests
> - add new utiliities
> - add website tests
> s3-tests, fuzzer tests [5]
> 
> Links for all the bits above
> ----------------------------
> [1] https://github.com/ceph/ceph/tree/wip-static-website
> [2] http://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html
> [3]
> https://github.com/ceph/ceph/compare/master...robbat2:wip-static-website-robbat2-master
> [4]
> https://github.com/ceph/s3-tests/compare/master...robbat2:wip-static-website
> [5]
> https://github.com/ceph/s3-tests/compare/master...robbat2:wip-website-fuzzy
> [6]
> https://github.com/ceph/ceph/compare/master...robbat2:wip-static-website-robbat2-master#diff-ee7891a35944697538486c9269e0d65bR909
> 

Great! I'll wait for the cleaned up pull request.

Yehuda

> --
> Robin Hugh Johnson
> Gentoo Linux: Developer, Infrastructure Lead
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
