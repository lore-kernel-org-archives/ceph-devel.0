From: Gregory Farnum <greg@inktank.com>
Subject: Re: osd recovery extremely slow with current master
Date: Mon, 19 Nov 2012 15:21:33 -0800
Message-ID: <CAPYLRzgqPZWZAMjJD_WrCx8m+HB6i1LKeLLNRZHmbgLnTJ6W+Q@mail.gmail.com>
References: <50A2AE92.1010205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59040 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab2KSXVe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:21:34 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7705670iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:21:34 -0800 (PST)
In-Reply-To: <50A2AE92.1010205@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Which version was this on? There was some fairly significant work to
recovery done to introduce a reservation scheme and some other stuff
that might need some different defaults.
-Greg

On Tue, Nov 13, 2012 at 12:33 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi list,
>
> osd recovery seems to be really slow with current master.
>
> I see only 1-8 active+recovering out of 1200. Even there's no load on ceph
> cluster.
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
