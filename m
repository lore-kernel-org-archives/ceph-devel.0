From: Ken Dreyer <ken.dreyer@inktank.com>
Subject: Re: packaging: do not package libdir/ceph recursively
Date: Wed, 12 Feb 2014 11:26:18 -0700
Message-ID: <CAOpHjdBOqGkSqyR_eVYM72zhfnyWkbaO3dBPLMm1m=ooUvtjPA@mail.gmail.com>
References: <ord2is1oqw.fsf@livre.home> <ork3d0z0j9.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:58701 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbaBLS0j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2014 13:26:39 -0500
Received: by mail-vc0-f179.google.com with SMTP id lh14so7284225vcb.38
        for <ceph-devel@vger.kernel.org>; Wed, 12 Feb 2014 10:26:38 -0800 (PST)
In-Reply-To: <ork3d0z0j9.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 12, 2014 at 10:46 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> My earlier patch was partially redundant with commit e60dcfa80dec, that
> didn't make 0.76, so here's the non-redundant change, as a separate
> patch.

Thank you! I've added my signed-off-by and submitted it for inclusion
in master here: https://github.com/ceph/ceph/pull/1224

- Ken
