From: Wido den Hollander <wido@42on.com>
Subject: Re: /usr/bin/cephfs tool
Date: Fri, 09 Jan 2015 16:24:08 +0100
Message-ID: <54AFF298.2090806@42on.com>
References: <alpine.DEB.2.00.1501090719200.10528@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:52114 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725AbbAIPYK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Jan 2015 10:24:10 -0500
In-Reply-To: <alpine.DEB.2.00.1501090719200.10528@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, gfarnum@redhat.com
Cc: ceph-devel@vger.kernel.org

On 01/09/2015 04:20 PM, Sage Weil wrote:
> Should we drop this entirely in hammer?  If I remember correctly all of 
> the layout stuff is fully supported using virtual xattrs and standard 
> tools.  The only thing left is the tool that shows you how file blocks map 
> to objects map to OSDs (or something like that), which I've never used and 
> have never seen anyone use...
> 

I'm in favor of dropping it! It confused me a couple of weeks ago since
I thought for a second that it was still the right way to go.

With CephFS becoming more mature in Hammer we should not encourage users
to use this deprecated tool.

They should use vxattrs from the beginning.

I'm +1 in dropping this tool entirely in Hammer.

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
