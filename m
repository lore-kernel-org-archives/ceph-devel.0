From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Wed, 5 Sep 2012 09:14:19 -0700
Message-ID: <CADvuQRGsRQ2AYM7ceaQiR-F+7J1P1TR-_AXfPLWHznYetkhoog@mail.gmail.com>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl>
 <CADxhoDR-3guBfFXc_QSmvPthVp5R=vS9tB2zpn-WRaLCSAu=ZA@mail.gmail.com> <50476FAE.8030107@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53842 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab2IEQOl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 12:14:41 -0400
Received: by vcbfk26 with SMTP id fk26so1053665vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 09:14:40 -0700 (PDT)
In-Reply-To: <50476FAE.8030107@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Calvin Morrow <calvin.morrow@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 5, 2012 at 8:28 AM, Wido den Hollander <wido@widodh.nl> wrote:
> You can only specify one monitor in CloudStack, but your cluster can have
> multiple.
>
> This is due to the internals of CloudStack. It stores storage pools in a URI
> format, like: rbd://admin:secret@1.2.3.4/rbd

You know, for a custom scheme like "rbd:", any generic URI parser has
no business dictating what's allowed and what's not. Just don't use
"//" and you're not forced to follow those rules.

For example, rbd:?id=admin&secret=s3kr1t&mon=1.2.3.4&mon=5.6.7.8&pool=rbd
is perfectly legal.

Whether some Java library fails to implement generic URIs is another concern..

http://tools.ietf.org/html/rfc3986#section-3
