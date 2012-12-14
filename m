From: Alex Elder <elder@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Fri, 14 Dec 2012 12:03:17 -0600
Message-ID: <50CB69E5.7080001@inktank.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <CAPud5_7jXmz9Bz9hAcQKG769wvuCn2eWkV-wc_qEZ7kPdsZf1Q@mail.gmail.com> <CAPud5_7P_Z-+14kyGZGxLCUY4SfTWnW3kTOpMh3OYBWgWCt_1w@mail.gmail.com> <alpine.DEB.2.00.1211212041240.9963@cobra.newdream.net> <CAPud5_4S6-K33f4qLR+-cMm5NLn35H3aXo_LVSenwBM2sxgELg@mail.gmail.com> <CAPud5_7EckkvSth8+YeGvEph1GxjTqovXhG6gVWKUX-3K9cLjQ@mail.gmail.com> <50B7C788.6040404@inktank.com> <50B93FCA.2060801@inktank.com> <CAPud5_4avt1ohkdg3s_pcwoF+4AfuAYDP3qJUqL84nFnmh2GjA@mail.gmail.com> <50BC2DE6.6050307@inktank.com> <50C65AE5.2050704@inktank.com> <CAPud5_7OPrpg1Q_UTw2PskG+o=+H82xgJHacmGT+bVOZkf466A@mail.gmail.com> <50C774FD.9030107@inktank.com> <50C78D09.5050403@inktank.com> <CAPud5_697TJpxU_fCe+FzmgeuTxWx61My5p+FJN_2B1fpn_G3Q@mail.gmail
 .com> <CAPud5_6q0gQD0ajpKZdvnaaMBvapQ59fkOA7ANVhPo0dMGJ+Sw@mail.gmail.com> <50CB57E2.10703@inktank.com> <CAPud5_7FF=AXMzd4N9kLb4DGQJgp0Csid7_LV3RKYbiTdB+09g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:62382 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab2LNSDU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 13:03:20 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3391664iay.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 10:03:19 -0800 (PST)
In-Reply-To: <CAPud5_7FF=AXMzd4N9kLb4DGQJgp0Csid7_LV3RKYbiTdB+09g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/14/2012 10:53 AM, Nick Bartos wrote:
> Yes I was only enabling debugging for libceph.  I'm adding debugging
> for rbd as well.  I'll do a repro later today when a test cluster
> opens up.

Excellent, thank you.	-Alex
