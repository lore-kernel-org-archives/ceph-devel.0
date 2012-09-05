From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Wed, 5 Sep 2012 15:52:18 -0700
Message-ID: <CADvuQRGxJNSDd15jJCo9SBsY6=bki8EzjHQ0vTk7oE4nacA09g@mail.gmail.com>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl>
 <CADxhoDR-3guBfFXc_QSmvPthVp5R=vS9tB2zpn-WRaLCSAu=ZA@mail.gmail.com>
 <50476FAE.8030107@widodh.nl> <CADvuQRGsRQ2AYM7ceaQiR-F+7J1P1TR-_AXfPLWHznYetkhoog@mail.gmail.com>
 <5047866B.80102@widodh.nl> <CADvuQREoGMAL+fKTMpYDk73-8f5yWVNHTAjpiHrLFEO6noFJ4w@mail.gmail.com>
 <5047D49B.3060105@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35193 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab2IEWwj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 18:52:39 -0400
Received: by vbbff1 with SMTP id ff1so741442vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 15:52:38 -0700 (PDT)
In-Reply-To: <5047D49B.3060105@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 5, 2012 at 3:39 PM, Wido den Hollander <wido@widodh.nl> wrote:
> The main problem with that is how CloudStack internally stores the data. At
> the storage driver the URI doesn't arrive in plain format, it gets splitted
> with getHost(), getAuthUsername(), getPath() and arrives in these separate
> variables at the point where libvirt is being called.

Perhaps they would we amenable to a pretty little patch that passes
the URI all the way through?
