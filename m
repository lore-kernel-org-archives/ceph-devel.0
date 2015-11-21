From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: Aggregate failure report in ceph -s
Date: Sat, 21 Nov 2015 15:46:00 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC036504FE@shsmsx102.ccr.corp.intel.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC0365008A@shsmsx102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1511200324480.24879@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55764 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760776AbbKUPqW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Nov 2015 10:46:22 -0500
In-Reply-To: <alpine.DEB.2.00.1511200324480.24879@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Yeah, that is what I mean, and the output make more sense than I was th=
inking before (only show if I cannot reach the whole crush level ).

I will try to to it then.

Thanks.

-Xiaoxi



> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, November 20, 2015 7:28 PM
> To: Chen, Xiaoxi
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Aggregate failure report in ceph -s
>=20
> On Fri, 20 Nov 2015, Chen, Xiaoxi wrote:
> >
> > Hi Sage,
> >
> > =A0=A0=A0=A0=A0=A0 As we are looking at the failure detection part =
of
> > ceph(basically around osd flipping issue), we=A0 got some suggestio=
n
> > from customer that showing the aggregated failure report in ?ceph ?=
s?.
> The idea is:
> >
> > =A0=A0=A0=A0=A0 When an OSD find it cannot hear heartbeat from some=
 of the
> > peers, it will try to aggregate the failure domain, say ?I cannot
> > reach all my peers in Rack C,=A0=A0=A0 something wrong??=A0 and thi=
s kind of
> > log will be showed on ceph ?s.=A0=A0 So if we see ceph ?s and notic=
e a lot
> > of complain saying cannot reach Rack C, we will easily diagnose the=
 Rack C
> has some network issue.
> >
> >
> >
> > =A0=A0=A0=A0=A0 Is that make sense?
>=20
> Yeah, sounds reasonable to me!  It's a bit more awkward to do this at=
 the
> mon level since rack C may talk to the mon, but doing it at the OSD m=
akes
> sense.  There will be a lot of heuristics involved, though.  I expect=
 the
> messages might include
>=20
> - cannot reach _% of peers outside of my $crushlevel $foo [on front|b=
ack]
> - cannot reach _% of hosts in $crushlevel $foo [on front|back]
>=20
> ?
>=20
> Also note that it would be easiest to log these in the cluster log (c=
eph -w, not
> ceph -s).. I'm guessing that's what you mean?
>=20
> Thanks!
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
