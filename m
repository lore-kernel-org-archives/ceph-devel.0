From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw static-website hosting design WIP: how S3-like should we be
 with endpoint types?
Date: Tue, 9 Jun 2015 11:59:33 -0400 (EDT)
Message-ID: <919435330.11886213.1433865573139.JavaMail.zimbra@redhat.com>
References: <20150609035221.GA2868@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:50086 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbFIP7i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 11:59:38 -0400
In-Reply-To: <20150609035221.GA2868@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, jonathan lacour <jonathan.lacour@dreamhost.com>



----- Original Message -----
> From: "Robin H. Johnson" <robbat2@gentoo.org>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Cc: "jonathan lacour" <jonathan.lacour@dreamhost.com>
> Sent: Monday, June 8, 2015 8:52:21 PM
> Subject: rgw static-website hosting design WIP: how S3-like should we be with endpoint types?
> 
> Hi,
> 
> I'm working on implementing S3 Static Website hosting on top of RGW,
> based on the initial work that Yehuda did (wip-static-website branch).
> 
> I have a scratchpad here:
> https://github.com/robbat2/temp-ceph-rgw-static-website-wiki/wiki
> WIP Codebase here:
> https://github.com/robbat2/ceph/tree/wip-static-website-robbat2-master
> 
> As part of writing up a full design for it, I'm wondering if we should
> try to be "as close to S3 as possible", or try to improve the experience
> for the administrator rather.
> 
> In S3, they explicitly add some DNS endpoints that are used for
> accessing the bucket in website mode. Via those special endpoints, there
> are MANY constraints applied [1], and you pretty much can't use them for
> anything else.
> 
> At this point in early implementation, it seems possible that rather
> than requiring organizations to have a separate DNS subdomain/wildcard
> scope for websites, that we can make the decision based on headers:
> If(bucket has website metadata set) {
>   if(request has auth headers) {
>     use normal REST mode
>   } else {
>     use website mode
>   }
> }
> 
> I've got it mostly working to make this behavior, but I'm wondering
> about fallout/breakage, and unintended consequences. The codebase is
> pretty ready for plugging the alternative logic with hostnames in as
> well.
> 
> The most notable one so far, is that under Amazon's S3, the website
> endpoint will server up only fixed pages for directories (no listing);
> and the regular REST endpoint will serve listings if the
> bucket/directory has a public ACL.
> 
> Another side-effect, and I think that's an improvement, is that if you
> use a browser to just access a bucket this way, you'll automatically get
> HTML error pages, instead of the XML blobs (as an admin of a RGW install
> previously, the non-technical users telling me the rendered HTML from
> their errors would have been a huge help instead of them being scared of
> the XML).
> 
> [1] The list of S3 website endpoint constraints is here:
> http://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteEndpoints.html
> 

A few options (not necessarily mutual exclusive):
 - anonymous access gets the website endpoint handling, authenticated gets the REST
 - read operations returns website, write operations handle REST
 - configurable (whether gateway handles either, or which)

I don't have a strong opinion, more of what users prefer.

Yehuda
  
