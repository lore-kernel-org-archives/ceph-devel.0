From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 04 Mar 2014 08:53:16 +0800
Message-ID: <531523FC.8070509@ubuntukylin.com>
References: <alpine.DEB.2.00.1403031423270.17314@cobra.newdream.net> <CAGd4Wr38czZ5REXmFaeniR8Umr9z-UN8sMrfMawh4ZF0pR_NhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:53210 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838AbaCDAxX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 19:53:23 -0500
In-Reply-To: <CAGd4Wr38czZ5REXmFaeniR8Umr9z-UN8sMrfMawh4ZF0pR_NhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@inktank.com>, Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Then it seems that Coverity is only able to perform intra-procedure 
check, is there any inter-procedure check option to turn on?

On 2014/3/4 6:53, John Spray wrote:
> On Mon, Mar 3, 2014 at 10:23 PM, Sage Weil <sage@inktank.com> wrote:
>> ** CID 1188299:  Data race condition  (MISSING_LOCK)
>> /mds/MDSUtility.cc: 142 in MDSUtility::handle_mds_map(MMDSMap *)()
>
> Is there a trick to getting coverity to realise that the lock is held,
> but by the calling function?  Does it recognise assertions that the
> lock is held?
>
> Cheers,
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
