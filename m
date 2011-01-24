From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: xtreemfs
Date: Mon, 24 Jan 2011 10:59:48 -0800
Message-ID: <AANLkTikpLF-v1F=ELqSUNPJxikspLrNW-F6oohJzT8X-@mail.gmail.com>
References: <AANLkTikayUp=kCnikVPxi2wYch_yY_3fXpLKg6GfCgbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60693 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1AXS7t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jan 2011 13:59:49 -0500
Received: by ewy5 with SMTP id 5so2083421ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jan 2011 10:59:48 -0800 (PST)
In-Reply-To: <AANLkTikayUp=kCnikVPxi2wYch_yY_3fXpLKg6GfCgbf@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Markus Kienast <mark@trickkiste.at>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 24, 2011 at 10:46 AM, Markus Kienast <mark@trickkiste.at> wrote:
> How does ceph differentiate itself from xtreemfs?
Ceph and XtreemFS have pretty different goals.
From what I've read, Xtreemfs is designed as a WAN distributed FS with
interesting file replication strategies designed to minimize latency
across the internet.
Ceph is a cluster filesystem designed to be used across a high-speed
low-latency network that provides pseudo-random but deterministic
block-based replication of data, with strong consistency guarantees,
and extreme scalability. (Unlike xtreemfs, Ceph can shard
responsibility for metadata across many nodes, and since it calculates
data placement rather than assigning it, less metadata needs to be
stored and cached.)

If you have more specific questions (preferably with indications of
how xtreemfs behaves; I'm not terribly familiar with it) we can answer
those in more detail. :)
