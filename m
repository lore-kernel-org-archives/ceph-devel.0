From: Tommi Virtanen <tv@inktank.com>
Subject: Re: rbd locking and handling broken clients
Date: Wed, 13 Jun 2012 16:19:15 -0700
Message-ID: <CADvuQRGWFojF0-48EU101iMv_y35YzQptap1y5FxaZeRm=dSQQ@mail.gmail.com>
References: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39326 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab2FMXTg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 19:19:36 -0400
Received: by dady13 with SMTP id y13so1705526dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 16:19:36 -0700 (PDT)
In-Reply-To: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, mandell@pistoncloud.com

On Wed, Jun 13, 2012 at 10:40 AM, Gregory Farnum <greg@inktank.com> wrote:
> 2) Client fencing. See http://tracker.newdream.net/issues/2531. There

You know, I'd be really happy if this could be achieved by means of
removing cephx keys.
