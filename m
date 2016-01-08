From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: ovh hammer runs
Date: Fri, 8 Jan 2016 13:23:51 -0800
Message-ID: <CAMMFjmFGcG2fP_gu-W-T9UTJq1HBeYqRBo+oNxuBL1Tmh3N9rg@mail.gmail.com>
References: <CAN=+7FXzHqeDrLYUhYnG4kMr+aBmmipPOsAHUkS5pgbg+3BrVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34393 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbcAHVXw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jan 2016 16:23:52 -0500
Received: by mail-io0-f169.google.com with SMTP id 1so252113117ion.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jan 2016 13:23:52 -0800 (PST)
In-Reply-To: <CAN=+7FXzHqeDrLYUhYnG4kMr+aBmmipPOsAHUkS5pgbg+3BrVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "Meno, Gregory" <gmeno@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>

rados/hammer suite/runs were moved from ovh to smithi for now

Thx
YuriW

On Fri, Jan 8, 2016 at 11:40 AM, Samuel Just <sjust@redhat.com> wrote:
> We're still seeing ENOSPC hangs in the hammer runs, which are making
> them not very valuable.  I filed a feature bug which should help
> (http://tracker.ceph.com/issues/14312), but in the mean time, I think
> we should move the hammer and jewel nightlies to smithi.  If it turns
> out to be too much load, we can reassess.
> -Sam
