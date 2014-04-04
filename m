From: Gregory Farnum <greg@inktank.com>
Subject: Re: Multiple Posix namespaces?
Date: Fri, 4 Apr 2014 12:24:04 -0700
Message-ID: <CAPYLRzgJpb1Sk3r5DnVhsz_U9hVkdds3RDdKTD=kEPK2RMPPuQ@mail.gmail.com>
References: <17BE816D-D0AD-4077-9D85-B43E16F8F1A9@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:60129 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbaDDTYG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Apr 2014 15:24:06 -0400
Received: by mail-qa0-f42.google.com with SMTP id k15so3610227qaq.29
        for <ceph-devel@vger.kernel.org>; Fri, 04 Apr 2014 12:24:05 -0700 (PDT)
In-Reply-To: <17BE816D-D0AD-4077-9D85-B43E16F8F1A9@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: ceph-devel Development <ceph-devel@vger.kernel.org>

Not yet, no. There are a couple different approaches to this that a
third-party contributor could work on without too much difficulty (I
*think* there's a blueprint floating around somewhere), but nobody's
done so yet.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Apr 4, 2014 at 11:58 AM, Atchley, Scott <atchleyes@ornl.gov> wrote:
> Can a single RADOS system support more than one POSIX namespace (i.e. two or more distinct POSIX namespaces sharing the same set of RADOS servers?
>
> Scott--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
