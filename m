From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: How to delete a mds?
Date: Tue, 26 Jun 2012 10:16:55 -0700
Message-ID: <CAPud5_7HcZGgg6PXK7Hw9-kmoJ5ew7=09rV5fR_dupNcoAd7Sg@mail.gmail.com>
References: <CAPud5_4V=7U+OsVy7cyTwW3_dU8cEBhjw1bpEtM75WczyYvCqQ@mail.gmail.com>
	<Pine.LNX.4.64.1206252114550.21315@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758499Ab2FZRQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 13:16:56 -0400
Received: by pbbrp8 with SMTP id rp8so339359pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 10:16:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206252114550.21315@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

That did it, thanks.

On Mon, Jun 25, 2012 at 9:16 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 25 Jun 2012, Nick Bartos wrote:
>> We decided to stop using the posix filesystem, and as such have
>> stopped running ceph-mds (and removed the mds things from ceph.conf)=
=2E
>> However we get warnings about the missing mds when running 'ceph
>> health'.
>>
>> How do I delete all the mdses? =A0I tried 'ceph mds rm <mdsname>' bu=
t
>> that doesn't seem to do any good.
>
> The 'rm' refuses to do it if it is in use. =A0Instead,
>
> =A0- make sure the ceph-mds daemon(s) aren't running
> =A0- ceph mds newfs metadata data
>
> That will blow away the old mdsmap (and fs metadata!). =A0Until a new
> 'first' ceph-mds starts up, ceph health won't complain.
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
