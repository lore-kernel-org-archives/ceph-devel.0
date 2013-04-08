From: Dan Mick <dan.mick@inktank.com>
Subject: Re: pg dump --format crashes all mon nodes
Date: Mon, 08 Apr 2013 03:32:53 -0700
Message-ID: <51629CD5.6010105@inktank.com>
References: <CAPHxCcS+bHq5Roc6g6WZkn_hYn667Eod5b3fPv3Q4oU7JwatSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:39602 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758482Ab3DHKc5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 06:32:57 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so5058923iag.22
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 03:32:57 -0700 (PDT)
In-Reply-To: <CAPHxCcS+bHq5Roc6g6WZkn_hYn667Eod5b3fPv3Q4oU7JwatSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lorieri <lorieri@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Indeed.  http://tracker.ceph.com/issues/4678.  Thanks for the report.

On 4/5/2013 5:49 PM, Lorieri wrote:
> Hi,
>
> My colleague run ceph pg dump --format with no other arguments.
> It crashes all mon daemons in the cluster.
>
> happens in ceph 0.60 and 0.56
> 3 mon, 3 osd, default crush map
>
> # ceph pg dump --format
> 2013-04-05 21:21:42.198843 7f3b1e58b700  0 monclient: hunting for new mon
> 2013-04-05 21:21:42.210685 7f3b1e58b700  0 monclient: hunting for new mon
> 2013-04-05 21:21:42.229632 7f3b1e58b700  0 monclient: hunting for new mon
> 2013-04-05 21:21:42.230233 7f3b22ca4700  0 -- 10.134.35.70:0/3005 >>
> 10.134.35.68:6789/0 pipe(0x7f3b14005130 sd=3 :0 pgs=0 cs=0 l=1).fault
> 2013-04-05 21:21:45.178005 7f3b1c486700  0 -- 10.134.35.70:0/3005 >>
> 10.134.35.69:6789/0 pipe(0x7f3b18000f90 sd=3 :0 pgs=0 cs=0 l=1).fault
> 2013-04-05 21:21:48.178089 7f3b22ca4700  0 -- 10.134.35.70:0/3005 >>
> 10.134.35.70:6789/0 pipe(0x7f3b18003010 sd=4 :0 pgs=0 cs=0 l=1).fault
>
> # ceph health
> 2013-04-05 21:24:22.365023 7f59371ec700  0 -- :/3114 >>
> 10.134.35.70:6789/0 pipe(0x1e51540 sd=3 :0 pgs=0 cs=0 l=1).fault
> 2013-04-05 21:24:25.365819 7f593d909700  0 -- :/3114 >>
> 10.134.35.69:6789/0 pipe(0x7f592c000c00 sd=4 :0 pgs=0 cs=0 l=1).fault
> 2013-04-05 21:24:28.365786 7f59371ec700  0 -- :/3114 >>
> 10.134.35.70:6789/0 pipe(0x7f592c003010 sd=4 :0 pgs=0 cs=0 l=1).fault
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

