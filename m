From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: zero length write fro store_test to bluestore
Date: Mon, 20 Jun 2016 16:02:20 +0000
Message-ID: <BLUPR0201MB1524A6F9C8259C1AB7B647EBE82A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <e175ac33-0398-2154-6edd-6ee932509c8c@mirantis.com>
 <alpine.DEB.2.11.1606201354350.21827@piezo.us.to>
 <37e7147d-cda6-f17e-0a51-36f8cf205976@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0067.outbound.protection.outlook.com ([207.46.100.67]:15904
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754393AbcFTQCf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 12:02:35 -0400
In-Reply-To: <37e7147d-cda6-f17e-0a51-36f8cf205976@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

How does FileStore handle this case? Why are we doing anything different?

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Igor Fedotov
> Sent: Monday, June 20, 2016 6:57 AM
> To: Sage Weil <sweil@redhat.com>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: zero length write fro store_test to bluestore
> 
> 
> 
> On 20.06.2016 16:55, Sage Weil wrote:
> > On Mon, 20 Jun 2016, Igor Fedotov wrote:
> >> Hi All,
> >>
> >> I'm hitting the following issue while running Synthetic test case
> >> (from
> >> store_test.cc) against bluestore:
> >>
> >> store_test asserts on read data mismatch when read happens after the
> >> zero-length write above object boundary.
> >>
> >> Test case assumes all the data between the old and new object
> >> boundaries are filled with zeros. But current bluestore write path
> >> implementation simply discards zero-length writes and hence doesn't
> >> raise object size. As a result subsequent read doesn't return anything
> above the old boundary.
> >>
> >> The question is what's the proper fix for that:
> >>
> >> 1) Ignore zero-length writes in the test case and do not increase
> >> object size/fill content on them.
> >>
> >> or
> >>
> >> 2) Increase object content size on such writes in the bluestore.
> > Heh, I just hit this too.  I think it makes more sense for 0 length
> > writes to not affect object size.  I added a test for it and fixed
> > Memstore.  store_test.cc needs to be adjusted still though...
> >
> > Pushed patches to top of wip-bluestore-2q, do you mind pulling those 2
> > out and fixing store_test in another PR?
> OK, will do.
> >
> > Thanks!
> > sage
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
