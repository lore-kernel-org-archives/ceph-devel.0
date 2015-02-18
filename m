From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: ceph:rgw issue #10698
Date: Wed, 18 Feb 2015 11:56:10 -0500 (EST)
Message-ID: <1514977430.7344768.1424278570323.JavaMail.zimbra@redhat.com>
References: <54E32EFE.4080209@switch.ch> <784895333.6829144.1424192912653.JavaMail.zimbra@redhat.com> <54E44E2F.2020009@switch.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:38334 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbBRQ4Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 11:56:16 -0500
In-Reply-To: <54E44E2F.2020009@switch.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Valery Tschopp <valery.tschopp@switch.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Valery Tschopp" <valery.tschopp@switch.ch>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, February 18, 2015 12:32:47 AM
> Subject: Re: ceph:rgw issue #10698
> 


> Hi Yehuda,
> 
> Would it be possible to have the bug fixes #10698 + #10062 for the S3
> POST issue be backported for the new release of firefly?
> 
> This feature is very important for us, our video conversion engine
> relies on the user S3 browser POST.
> 

I reopened the issues, set them as pending for backport. Pushed the wip-firefly-rgw-backports branch with these fixes in it.

Yehuda

> Best regards,
> Valery
> 
> On 17/02/15 18:08 , Yehuda Sadeh-Weinraub wrote:
> >> Subject: ceph:rgw issue #10698
> >>
> >> Hello Yehuda,
> >>
> >> The issue http://tracker.ceph.com/issues/10698 "rgw: not failing
> >> POST requests if keystone not configured" is marked as resolved,
> >> but I don't think it is backported in firefly.
> >>
> >> Issue http://tracker.ceph.com/issues/10062 should already be
> >> backported, if I'm not wrong...
> >>
> >
> > Neither made it in. The bug wasn't set to be backported to firefly.
> > We can set it to get backported if there's a demand, however, I'm not
> > sure that it's going to be a trivial backport.
> >
> > Yehuda
> >
> 
> --
> SWITCH
> --------------------------
> Valery Tschopp, Software Engineer, Peta Solutions
> Werdstrasse 2, P.O. Box, 8021 Zurich, Switzerland
> email: valery.tschopp@switch.ch phone: +41 44 268 1544
> 
> 
> 
