From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Is there any way to collect object-level I/O access traces in Ceph?
Date: Fri, 16 Jan 2015 13:21:58 -0800
Message-ID: <CAC6JEv8-BE=+p_h54z__bAf5vev8jJttBf5nBw8PNm6w8nJw9Q@mail.gmail.com>
References: <CAJqA8gsUn19CDswyeYiQj9Ex0vaQeybvBVDOx3nG2w70_esCAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39457 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbAPVWA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 16:22:00 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so22966384iec.5
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 13:21:59 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id gc7sm2040973igd.8.2015.01.16.13.21.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 13:21:58 -0800 (PST)
Received: by mail-ie0-f171.google.com with SMTP id ar1so22976449iec.2
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 13:21:58 -0800 (PST)
In-Reply-To: <CAJqA8gsUn19CDswyeYiQj9Ex0vaQeybvBVDOx3nG2w70_esCAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lipeng Wan <lipengwan86@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 16, 2015 at 11:28 AM, Lipeng Wan <lipengwan86@gmail.com> wrote:
> Dear all,
>
> Does Ceph provide a way to collect object-level I/O access traces?
> Specifically, can we collect the traces to record how many times each
> object has been accessed (read, write, etc.) during a fixed period of
> time?

I don't think we have any programmatic access, but depending on what
you need it for you could enable messenger logging (or filestore
logging, depending on what exactly you want) and count the references
there.
-Greg
