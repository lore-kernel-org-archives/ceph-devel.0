From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: [rgw][Swift API] Reusing WSGI middleware of Swift
Date: Wed, 15 Apr 2015 12:09:09 -0400 (EDT)
Message-ID: <989418932.216748.1429114149891.JavaMail.zimbra@redhat.com>
References: <CA+H5UW1oCwFQ9E_2hTn-tDn2CP6AVY+Dij5xzMRogStsOW9dNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:40505 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbbDOQJL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 12:09:11 -0400
In-Reply-To: <CA+H5UW1oCwFQ9E_2hTn-tDn2CP6AVY+Dij5xzMRogStsOW9dNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Neil Levine <nlevine@redhat.com>



----- Original Message -----
> From: "Radoslaw Zarzynski" <rzarzynski@mirantis.com>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, April 15, 2015 8:31:22 AM
> Subject: [rgw][Swift API] Reusing WSGI middleware of Swift
> 
> Hello Guys,
> 
> Swift -- besides implementing the OpenStack Object Storage API v1 -- provides
> a bunch of huge extensions like SLO/DLO (static/dynamic large objects), bulk
> operations (inc. server-side archive extraction), staticweb and many more.
> Full list is available in Swift's source code [1]. I'm pretty sure it would
> be nice to have at least some degree of compatibility with them.
> 
> Reimplementing those features could be painful. Maintaining them would be
> another challenge. Even after accomplishing that we still would not provide
> users with ability to use (and easily create) a third party extensions like
> ClamAV-based virus scanner [2]. However, maybe there is another solution.
> 
> Swift internally utilizes a pipeline-based architecture. Component delivering
> the base of OSOS API (the "proxy-server" WSGI application) could be seen
> as the last stage of such pipeline. Between it and user a lot of additional
> middleware modules exist. All of them are interconnected with the WSGI
> interface. In a pure theory, if we provide a WSGI-RGW bridge, we would be
> able
> to reuse them and save a lot of efforts.
> 
> I created a really stupid proof of concept [3] built on top of wsgiproxy [4]
> and civetweb frontend of RGW. Its primary role is a WSGI-HTTP mediator.
> The code is terrible, definitely needs rework but already allowed to pass
> a few middleware-related API tests from Tempest.
> 
> What would be necessary on the RGW's side? Basically:
> * support for extraction of account (aka tenant) name from URL;
> * good conformance with OSOS API;
> * optionally: a configuration parameter to disable auth mechanisms inside RGW
>   and delegate the work to Swift middleware.
> 
> What's your opinion? I would like to start a discussion to verify the
> concept.

That is really interesting. A while back I actually floated around such an idea. My main motivation was for keeping up to date with keystone, but I can see other uses for it.
Generally I think it would be great to have such a module. I'm not sure that it would be the way to go with regard to SLO/DLO, these would result in a hacky and racy solutions at best.

Yehuda

> 
> Regards,
> Radoslaw Zarzynski
> 
> [1] https://github.com/openstack/swift/tree/master/swift/common/middleware
> [2]
> https://julien.danjou.info/blog/2013/extending-swift-with-a-middleware-clamav
> [3] https://github.com/rzarzynski/rgwift
> [4] http://pythonpaste.org/wsgiproxy/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
