From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: jerasure / gf-complete & 32 bits
Date: Sun, 30 Mar 2014 10:58:27 -0400
Message-ID: <CAOGLoJOVtfFB24=DBJQ4YL-PbS-mfebKGRHypNJE9o98yvGuqw@mail.gmail.com>
References: <5335AE3D.1050104@dachary.org>
	<53368DA3.7080206@dachary.org>
	<BC86EB1E-D599-4286-A73E-29130DB0A5A2@gmail.com>
	<53373D73.9030000@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:50352 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbaC3O62 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Mar 2014 10:58:28 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so5762457eek.12
        for <ceph-devel@vger.kernel.org>; Sun, 30 Mar 2014 07:58:27 -0700 (PDT)
In-Reply-To: <53373D73.9030000@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Mar 29, 2014 at 5:38 PM, Loic Dachary <loic@dachary.org> wrote:
> I'm not sure it's worth fixing : https://github.com/ceph/ceph/pull/1563

Line 25 in https://github.com/ceph/ceph/pull/1563/files has a typo:

+        INTEL_SSE3_FLAGS="-mssse3 -DINTEL_SSE3"

should be:

+        INTEL_SSE3_FLAGS="-msse3 -DINTEL_SSE3"

(The AX_CHECK_COMPILE_FLAG call is correct.)

Cheers.  -- justin
