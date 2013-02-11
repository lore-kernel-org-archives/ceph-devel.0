From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD Weights
Date: Mon, 11 Feb 2013 13:31:01 -0800
Message-ID: <CAPYLRzh2+S8ijuRGs+Nv7rRaN2e7k-RH8HSr-qHeSSXWr+TQYw@mail.gmail.com>
References: <C4049E4484F13747B672D64B9C12C31328E13918@PWMAILM01.cscinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:62895 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605Ab3BKVbF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 16:31:05 -0500
Received: by mail-qc0-f177.google.com with SMTP id u28so2357506qcs.22
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 13:31:02 -0800 (PST)
In-Reply-To: <C4049E4484F13747B672D64B9C12C31328E13918@PWMAILM01.cscinfo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Mon, Feb 11, 2013 at 12:43 PM, Holcombe, Christopher
<cholcomb@cscinfo.com> wrote:
> Hi Everyone,
>
> I just wanted to confirm my thoughts on the ceph osd weightings.  My understanding is they are a statistical distribution number.  My current setup has 3TB hard drives and they all have the default weight of 1.  I was thinking that if I mixed in 4TB hard drives in the future it would only put 3TB of data on them.  I thought if I changed the weight to 3 for the 3TB hard drives and 4 for the 4TB hard drives it would correctly use the larger storage disks.  Is that correct?

Yep, looks good.
-Greg
PS: This is a good question for the new ceph-users list.
(http://ceph.com/community/introducing-ceph-users/)
:)
