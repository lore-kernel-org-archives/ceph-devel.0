From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Fwd: wip-hint
Date: Sun, 23 Feb 2014 11:10:11 -0800
Message-ID: <CABBk=J8o5kpOHu4mVPizf4ACSZMu7XOMTu_OtL5sSpeVjmXHJQ@mail.gmail.com>
References: <alpine.DEB.2.00.1402230742470.17508@cobra.newdream.net>
	<CABBk=J-o-hcyUZzoDDvCV=+YJyUunKmDobDUtSAnsWnEMxYp_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:34000 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbaBWTKL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 14:10:11 -0500
Received: by mail-vc0-f179.google.com with SMTP id lh14so4938097vcb.24
        for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 11:10:11 -0800 (PST)
In-Reply-To: <CABBk=J-o-hcyUZzoDDvCV=+YJyUunKmDobDUtSAnsWnEMxYp_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Samuel Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

(resending to get through the list) My main concern is that the whole
notion of hint needs to be abstracted. Instead of having a specific op
for allocation hints we should have a generic hint operation that
would contain a hint type in it. That hint will then be parsed within
the various osd components, and will be used if identified and if
needed. Then you'd be able to add various hints without needing to
change the  protocol itself. Not sure if the operation itself needs to
have a "write" flag set on it, as hints may apply to read operations
too (e.g., a hint to prefetch data read). We may want to create two
different ops, one for read and one for write.
I think that a first step would be to modify the current op and add a
"hint type" string at the data portion, and an optional bufferlist for
data. The size params need to be generic and not specific (param1,
param2, ...).

The reasoning behind that is that at one point we may have different
backbends plugging into the osd externally. Providing a proper osd
backbend sdk might be another step. So we'd want this to be as
abstract as possible. These hints could be sent blindly without the
osd needing to understand their meaning, leaving it to the backbend to
interpret.

Yehuda

On Sunday, February 23, 2014, Sage Weil <sage@inktank.com> wrote:
>
> Hey Sam, Yehuda,
>
> Can you take a final look at https://github.com/ceph/ceph/pull/1284?
>
> Yehuda, you mentioned wanting to make the hint op as general as possible.
> This bit is only addressing the allocation piece, and there is room in the
> args struct to add additional fields (so far 0 means 'not
> specified/undefined'), but I'm not sure if that captures your concerns.
>
> Thanks!
> sage
>
>
