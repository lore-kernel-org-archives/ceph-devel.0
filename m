From: Dan Mick <dmick@redhat.com>
Subject: Re: Troublesome documentation link on http://ceph.com
Date: Thu, 3 Dec 2015 15:25:38 -0800
Message-ID: <5660CF72.3090704@redhat.com>
References: <565D9611.3000109@suse.cz> <565FD289.6030302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366AbbLCXZi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 18:25:38 -0500
In-Reply-To: <565FD289.6030302@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, ceph-devel@vger.kernel.org

On 12/02/2015 09:26 PM, Dan Mick wrote:
> On 12/01/2015 04:44 AM, Nathan Cutler wrote:
>> So I go to http://ceph.com and click on the "Documentation" link. In the
>> HTML source code the linked URL is http://ceph.com/docs but the HTTP
>> server rewrites this to:
>>
>> http://docs.ceph.com/docs/v0.80.5/
>>
>> Could someone arrange for this to be changed s/v0.80.5/master/ ?
>>
>> ( Searching for Ceph documentation is already difficult as it is,
>> because Google does not provide links to the master version, but only to
>> old outdated versions - see for example the first two search results in
>> a Google search for "troubleshoot pgs in ceph":
>> http://tinyurl.com/nfuohss )
>>
> 
> Yes, agreed; we were in the process of relocating that webserver, so had
> been neglecting the old configuration.  Hopefully we'll get it redone
> tomorrow (one in a list of a zillion things around the move, but an
> important one).
> 

I've updated DNS to point at the new server, and redirected both
docs.ceph.com/ and docs.ceph.com/docs to docs.ceph.com/docs/master.
I've (at least temporarily) removed the 'version selector' javascript
from the page as well; you can still select other versions by editing
the URL.  Barring any DNS caching past the records' TTLs on your end,
the new addresses should be active by now.

Because the site had been using 301 redirects, you may need to do
something special to make your browser realize that the redirect should
no longer be used (the browser caches redirects).  Google "clear cached
redirects" for your particular browser if you appear not to be getting
the correct info.

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
