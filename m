From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: SMART monitoring
Date: Fri, 27 Dec 2013 11:15:38 -0500
Message-ID: <CAOGLoJPoS3WUUJuyRqkiUbT+DoDCochHZ-LThC4Ro8wUCdkD0g@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B68565E03@BITCOM1.int.sbss.com.au>
	<alpine.DEB.2.00.1312261807240.2168@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57588 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab3L0QPj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Dec 2013 11:15:39 -0500
Received: by mail-wi0-f174.google.com with SMTP id z2so14450171wiv.13
        for <ceph-devel@vger.kernel.org>; Fri, 27 Dec 2013 08:15:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1312261807240.2168@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 26, 2013 at 9:17 PM, Sage Weil <sage@inktank.com> wrote:
> I think the question comes down to whether Ceph should take some internal
> action based on the information, or whether that is better handled by some
> external monitoring agent.  For example, an external agent might collect
> SMART info into graphite, and every so often do some predictive analysis
> and mark out disks that are expected to fail soon.
>
> I'd love to see some consensus form around what this should look like...

My $.02 from the peanut gallery: at a minimum, set the HEALTH_WARN flag if
there is a SMART failure on a physical drive that contains an OSD.  Yes,
you could build the monitoring into a separate system, but I think it'd be
really useful to combine it into the cluster health assessment.  -- justin
