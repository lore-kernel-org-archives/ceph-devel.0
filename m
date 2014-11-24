From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Where do MDSHealthMetrics show up?
Date: Sun, 23 Nov 2014 21:27:33 -0800
Message-ID: <CAC6JEv8Zaun+fgAZZxNr6DxDiBi3zd-2tAMsKQ2rGzBXmNFb7g@mail.gmail.com>
References: <CAD=PzHKrzs9Wx-pjONM+nL_eoO8+0crr-_K1iVT_PrMJJdr5bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:64020 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaKXF1e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 00:27:34 -0500
Received: by mail-ig0-f177.google.com with SMTP id uq10so2574340igb.16
        for <ceph-devel@vger.kernel.org>; Sun, 23 Nov 2014 21:27:34 -0800 (PST)
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com. [209.85.223.169])
        by mx.google.com with ESMTPSA id 3sm7170836ion.37.2014.11.23.21.27.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 21:27:33 -0800 (PST)
Received: by mail-ie0-f169.google.com with SMTP id y20so8206466ier.14
        for <ceph-devel@vger.kernel.org>; Sun, 23 Nov 2014 21:27:33 -0800 (PST)
In-Reply-To: <CAD=PzHKrzs9Wx-pjONM+nL_eoO8+0crr-_K1iVT_PrMJJdr5bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 20, 2014 at 5:54 PM, Michael Sevilla <mikesevilla3@gmail.com> wrote:
> Hi. Where do the MDSHealthMetrics in MMDSBeacon (e.g.,
> MDS_HEALTH_TRIM) show up in the monitors? When we run ceph -s? I
> suspect I don't see them because I'd have to run ceph -s at the exact
> moment when the MDS is trimming. Is there an easier way to see these
> warning or is there some debug flag I need to turn on?

This should be turning up in the ceph health warnings if there are any
issues, which you will see (if they're still live) by running "ceph
-s", or will pop up in "ceph -w". There's a bug right now though that
prevents them from showing up on peon monitors, which might be why
you're missing them: http://tracker.ceph.com/issues/10151

(You can specify the specific monitor to connect to with the ceph tool
by setting the "-m" option, if you want to always connect to the
leader.)
-Greg
