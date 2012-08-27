From: Martin Mailand <martin@tuxadero.com>
Subject: Re: v0.51 released
Date: Mon, 27 Aug 2012 17:15:53 +0200
Message-ID: <503B8F29.4070001@tuxadero.com>
References: <alpine.DEB.2.00.1208260858010.11218@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:47550 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2H0PQD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 11:16:03 -0400
In-Reply-To: <alpine.DEB.2.00.1208260858010.11218@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

is in this release the rbd layering/cloning already testable?
Do you have a link to the docs how to use it?

Best Regards,
  martin


Am 26.08.2012 17:58, schrieb Sage Weil:
> The latest development release v0.51 is ready. Notable changes include:
>
>   * crush: tunables documented; feature bit now present and enforced
>   * osd: various fixes for out-of-order op replies
>   * osd: several rare peering cases fixed
>   * osd: fixed detection of EIO errors from fs on read
>   * osd: new 'lock' rados class for generic object locking
>   * librbd: fixed memory leak on discard
>   * librbd: image layering/cloning
>   * radosgw: fix range header for large objects, ETag quoting, GMT dates,
>     other compatibility fixes
>   * mkcephfs: fix for default keyring, osd data/journal locations
>   * wireshark: ceph protocol dissector patch updated
>   * ceph.spec: fixed packaging problem with crush headers
>
> Full RBD cloning support will be in place in v0.52, as will a refactor of
> the messenger code with many bug fixes in the socket failure handling.
> This is available for testing now in 'next' for the adventurous. Improved
> OSD scrubbing is also coming soon. We should (finally) be building some
> release RPMs for v0.52 as well.
>
> You can get v0.51 from the usual locations:
>
>   * Git at git://github.com/ceph/ceph.git
>   * Tarball athttp://ceph.newdream.net/download/ceph-0.51.tar.gz
>   * For Debian/Ubuntu packages, seehttp://ceph.newdream.net/docs/master/install/debian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

