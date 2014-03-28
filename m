From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 23/33] libceph: enable OSDMAP_ENC feature bit
Date: Fri, 28 Mar 2014 17:01:53 +0200
Message-ID: <CALFYKtDoF54yQCo==SK_3MQP=G6-YyYKnDLpBs15h1HxO6aYKg@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-24-git-send-email-ilya.dryomov@inktank.com>
	<53348AE3.2030700@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:59650 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbaC1PBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 11:01:54 -0400
Received: by mail-qc0-f181.google.com with SMTP id e9so5968052qcy.40
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 08:01:53 -0700 (PDT)
In-Reply-To: <53348AE3.2030700@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 10:32 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
>> Announce our support for "new" osdmap enconding.
>
> Looks OK to me.  Isn't there a version of this OSD
> map encoding?  Maybe there'll be a "newer" one someday?

Reworded to "Announce our support for "new" (v7 - split and separately
versioned client and osd sections) osdmap enconding."

Thanks,

                Ilya
