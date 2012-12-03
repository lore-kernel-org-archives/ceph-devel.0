From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd: error finding header: (2) No such file or directory
Date: Mon, 03 Dec 2012 12:52:28 -0800
Message-ID: <50BD110C.1090005@inktank.com>
References: <50B964D0.7000806@fremaks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34204 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2LCUwj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 15:52:39 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2278671pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 12:52:39 -0800 (PST)
In-Reply-To: <50B964D0.7000806@fremaks.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Simon_Frerichs_=7C=A0Fremaks_GmbH?= <frerichs@fremaks.de>
Cc: ceph-devel@vger.kernel.org

On 11/30/2012 06:00 PM, Simon Frerichs | Fremaks GmbH wrote:
> Hi,
>
> we war starting to see this error on some images:
>
> -> rbd info kvm1207
> error opening image kvm1207: (2) No such file or directory
> 2012-12-01 02:58:27.556677 7ffd50c60760 -1 librbd: error finding header:
> (2) No such file or directory
>
> Anyway to fix these images?

If you can figure out which block prefix the images used, you can
reconstruct the header enough to make the image accessible again.

Check out this thread:

http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/7775

Do you know how the header object became missing? Did you have any
issues with your cluster, or scrub errors? If you're mysteriously
missing these header objects, other objects storing the data for the
image might be missing as well, which could cause strange errors
later.

Josh
