From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: how to do when data size big than osd disk.
Date: Mon, 24 Jan 2011 09:09:19 -0800
Message-ID: <AANLkTikjjJB4YOhB3qmiM0rcMX8Rs0VA_4ZWrqkNFWqu@mail.gmail.com>
References: <AANLkTik231Dz019ztWhJsMX0tnVKL-EdmkY8ROCSWLnV@mail.gmail.com>
	<Pine.LNX.4.64.1101201325570.25905@cobra.newdream.net>
	<D0C67741759ABD4BBD8D3A5CB815606E07E556@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42957 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1AXRKi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jan 2011 12:10:38 -0500
Received: by eye27 with SMTP id 27so1973546eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jan 2011 09:10:36 -0800 (PST)
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E556@mail.cloud-valley.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Jan 23, 2011 at 8:28 PM, Longguang Yue
<longguang_yue@tcloudcomputing.com> wrote:
> 2 out of 3 is down,so the live osd is full, data lose.
> How to solve the case?
Well, there's no way to magically make Ceph store more data than the
OSD can hold. However, if you can bring the other OSDs back up you
haven't lost any data.
It's possible that in this scenario the cluster won't recover properly
due to the surviving OSD running out of space, but let's leave dealing
with that until we know it's going to be a problem.
