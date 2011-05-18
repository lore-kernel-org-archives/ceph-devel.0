From: Sage Weil <sage@newdream.net>
Subject: Re: librados dependency
Date: Wed, 18 May 2011 09:04:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105180903510.1988@cobra.newdream.net>
References: <BANLkTin4zPSHQ7afkXRStuDJWbzZUCe9ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37426 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655Ab1ERQDE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 12:03:04 -0400
In-Reply-To: <BANLkTin4zPSHQ7afkXRStuDJWbzZUCe9ew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 18 May 2011, Yehuda Sadeh Weinraub wrote:
> The ceph master branch was broken today, as librados was using some
> undefined symbols (that are defined in libcrush). At the moment I
> worked around the issue by adding libcrush to the linkage where
> appropriate, however, we should definitely want to remove this
> dependency.

Which symbols?

sage
