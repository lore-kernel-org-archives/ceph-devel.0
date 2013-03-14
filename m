From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS locality API RFC
Date: Thu, 14 Mar 2013 11:29:04 -0700
Message-ID: <697CF5409C9749BBA0F2F86CCBDD2B17@inktank.com>
References: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:64250 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab3CNS3J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 14:29:09 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so2612299pbb.13
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 11:29:08 -0700 (PDT)
In-Reply-To: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, March 14, 2013 at 11:14 AM, Noah Watkins wrote:
> The current CephFS API is used to extract locality information as fol=
lows:
> =20
> First we get a list of OSD IDs:
> =20
> ceph_get_file_extent_osds(offset) -> [OSD ID]*
> =20
> Using the OSD IDs we can then query for the CRUSH bucket hierarchy:
> =20
> ceph_get_osd_crush_location(osd_id) -> path
> =20
> The path includes hostname information, but we'd still like to get th=
e IP. The current API for doing this is:
> =20
> ceph_get_file_stripe_address(offset) -> [sockaddr]*
> =20
> that returns an IP for each OSD holds replicas. The order of the outp=
ut list should be the same as the the OSD list, but It'd be nice to hav=
e a consistent API that deals with OSD id, making the correspondence ex=
plicit.
Agreed. We should probably deprecate the get_file_stripe_address() and =
make them turn IDs into addresses on their own.

> For instance:
> =20
> ceph_get_file_stripe_address(osd_id) -> sockaddr
How about =20
ceph_get_osd_address(osd_id) -> sockaddr
;)

 =20
> Another option is to have `ceph_get_osd_crush_location` return both t=
he path and a sockaddr.

No way =E2=80=94 that's conflating two different things rather more tha=
n we should be. For one thing the sockaddr can change during a daemon r=
estart but the crush location won't.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
