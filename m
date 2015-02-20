From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Clocks out of sync
Date: Fri, 20 Feb 2015 15:12:52 -0800
Message-ID: <CAC6JEv8a29skrLyFkDbeQ2K3LV1SULmEFpnFKOEXmcfp-+w3bQ@mail.gmail.com>
References: <54E7BE6D.5040503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:44184 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbBTXMx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 18:12:53 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so6862682iga.0
        for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 15:12:53 -0800 (PST)
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com. [209.85.223.180])
        by mx.google.com with ESMTPSA id z29sm17786553ioi.36.2015.02.20.15.12.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 15:12:52 -0800 (PST)
Received: by iecrd18 with SMTP id rd18so11549172iec.8
        for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 15:12:52 -0800 (PST)
In-Reply-To: <54E7BE6D.5040503@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Clocks in the labs have seemed a lot less well-synced lately than they
had been previously. :( I think there was some issue and then a change
to the NTP configuration, but I'm not clear on the details.
-Greg

On Fri, Feb 20, 2015 at 3:08 PM, David Zafman <dzafman@redhat.com> wrote:
>
> On 2 of my rados thrash runs clocks out of sync.   Is this an occasional
> issue or did we have an infrastructure problem?
>
> On burnupi19 and burnupi25:
> 2015-02-20 12:52:52.636017 mon.1 10.214.134.14:6789/0 177 : cluster [WRN]
> message from mon.0 was stamped 0.501458s in the future, clocks not
> synchronized
>
> On plana62 and plana64:
> 2015-02-20 10:00:56.842533 mon.0 10.214.132.14:6789/0 3 : cluster [WRN]
> message from mon.1 was stamped 0.855106s in the future, clocks not
> synchronized
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
