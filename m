From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS locality API RFC
Date: Thu, 14 Mar 2013 12:33:59 -0700
Message-ID: <A0B382C5B48F4832B9DFA685943B5BF4@inktank.com>
References: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu>
 <697CF5409C9749BBA0F2F86CCBDD2B17@inktank.com>
 <AFC48281-A237-442F-A9FA-98861A32E363@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:40216 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab3CNTeF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 15:34:05 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so2667110pbc.9
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 12:34:04 -0700 (PDT)
In-Reply-To: <AFC48281-A237-442F-A9FA-98861A32E363@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, March 14, 2013 at 11:33 AM, Noah Watkins wrote:
> =20
> On Mar 14, 2013, at 11:29 AM, Greg Farnum <greg@inktank.com (mailto:g=
reg@inktank.com)> wrote:
> =20
> > On Thursday, March 14, 2013 at 11:14 AM, Noah Watkins wrote:
> > > The current CephFS API is used to extract locality information as=
 follows:
> > > =20
> > > First we get a list of OSD IDs:
> > > =20
> > > ceph_get_file_extent_osds(offset) -> [OSD ID]*
> > > =20
> > > Using the OSD IDs we can then query for the CRUSH bucket hierarch=
y:
> > > =20
> > > ceph_get_osd_crush_location(osd_id) -> path
> > > =20
> > > The path includes hostname information, but we'd still like to ge=
t the IP. The current API for doing this is:
> > > =20
> > > ceph_get_file_stripe_address(offset) -> [sockaddr]*
> > > =20
> > > that returns an IP for each OSD holds replicas. The order of the =
output list should be the same as the the OSD list, but It'd be nice to=
 have a consistent API that deals with OSD id, making the correspondenc=
e explicit.
> > Agreed. We should probably deprecate the get_file_stripe_address() =
and make them turn IDs into addresses on their own.
> =20
> =20
> =20
> Is there an API deprecation protocol, or just -ENOTSUPP?
Well, for the moment I was thinking sticking "DEPRECATED" next to it an=
d not using it anywhere else =E2=80=94 but that is probably an acceptab=
le choice instead. I doubt anybody's using it outside of the old Hadoop=
 bindings. Which I am looking forward to being able to purge out of all=
 memory=E2=80=A6. ;)
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
